#!/usr/bin/env bash
# Stage, check and publish this package to Typst Universe (typst/packages).
#
#   scripts/release.sh stage   copy the package into build/packages/preview/<name>/<version>
#   scripts/release.sh check   compile the staged template and run typst-package-check
#   scripts/release.sh tag     tag HEAD as v<version> and push the tag
#   scripts/release.sh pr      push the staged package to your fork and open the PR
#
# The source of truth is this repository. The Universe copy is generated from it and is
# never edited by hand. `pr` needs `gh` logged in; in CI set GH_TOKEN to a token that can
# push to your fork of typst/packages and open pull requests there.
set -euo pipefail
cd "$(dirname "$0")/.."

NAME=$(sed -n 's/^name *= *"\(.*\)"/\1/p' typst.toml | head -1)
VERSION=$(sed -n 's/^version *= *"\(.*\)"/\1/p' typst.toml | head -1)
BUILD=build/packages
DEST=$BUILD/preview/$NAME/$VERSION
TEMPLATE_DIR=$(sed -n 's/^path *= *"\(.*\)"/\1/p' typst.toml | head -1)
TEMPLATE_MAIN=$(sed -n 's/^entrypoint *= *"\(.*\.typ\)"/\1/p' typst.toml | tail -1)

stage() {
  [ -n "$NAME" ] && [ -n "$VERSION" ] || { echo "no name/version in typst.toml" >&2; exit 1; }
  mkdir -p "$BUILD"
  # Start from an empty destination: move a previous staging aside instead of deleting it.
  if [ -d "$DEST" ]; then mv "$DEST" "$BUILD/.old-$VERSION-$(date +%s)"; fi
  mkdir -p "$DEST"
  # The `exclude` array of typst.toml, one pattern per line.
  tr -d '\n' < typst.toml \
    | sed -n 's/.*exclude *= *\[\([^]]*\)\].*/\1/p' \
    | tr ',' '\n' | tr -d ' "' | sed 's|/$|/***|' > "$BUILD/.exclude"
  git ls-files | rsync -am --files-from=- --exclude-from="$BUILD/.exclude" . "$DEST/"
  # --files-from leaves the directories of excluded files behind, empty.
  find "$DEST" -type d -empty -delete
  # Drop what only makes sense in the repository (README blocks between repo-only markers).
  perl -0pi -e 's{<!-- repo-only.*?<!-- /repo-only -->\n?}{}gs' "$DEST/README.md"
  # Imports of this package in the template and the README name the released version.
  find "$DEST" -type f \( -name '*.typ' -o -name '*.md' \) \
    -exec perl -pi -e "s{\@preview/$NAME:[0-9][0-9.]*}{\@preview/$NAME:$VERSION}g; s{preview/$NAME/[0-9][0-9.]*}{preview/$NAME/$VERSION}g" {} +
  echo "staged $DEST"
}

check() {
  [ -d "$DEST" ] || stage
  TYPST_PACKAGE_PATH="$PWD/$BUILD" typst compile --root "$DEST" \
    "$DEST/$TEMPLATE_DIR/$TEMPLATE_MAIN" "build/template-check.pdf"
  echo "template compiles"
  if command -v typst-package-check >/dev/null 2>&1; then
    # The CC-BY-SA-3.0 part of the licence (the USP model's text) is not OSI approved, which
    # Universe has accepted for this package, so that one lint does not fail the release.
    local out
    out=$(cd "$BUILD" && typst-package-check check "@preview/$NAME:$VERSION" --offline 2>&1 || true)
    printf '%s\n' "$out"
    if printf '%s\n' "$out" | grep -E '^error' | grep -v 'manifest/package/license/osi' >/dev/null; then
      echo "typst-package-check reported errors" >&2
      exit 1
    fi
  else
    echo "typst-package-check not installed, skipped (cargo install typst-package-check)"
  fi
}

tag() {
  [ -z "$(git status --porcelain)" ] || { echo "working tree is not clean" >&2; exit 1; }
  git tag -a "v$VERSION" -m "$NAME $VERSION"
  git push origin "v$VERSION"
}

pr() {
  # The tag must point at the commit being released.
  [ "$(git rev-parse "v$VERSION^{commit}" 2>/dev/null)" = "$(git rev-parse HEAD)" ] \
    || { echo "v$VERSION does not point at HEAD: run 'just tag' first" >&2; exit 1; }
  stage
  check
  local me work prev branch
  me=$(gh api user --jq .login)
  gh repo view "$me/packages" >/dev/null 2>&1 || gh repo fork typst/packages --clone=false
  work=$(mktemp -d)
  git clone --depth 1 --filter=blob:none --sparse "https://github.com/$me/packages.git" "$work/packages"
  (
    cd "$work/packages"
    git remote add upstream https://github.com/typst/packages.git
    git sparse-checkout set "packages/preview/$NAME"
    git fetch --depth 1 upstream main
    branch="$NAME-$VERSION"
    git checkout -b "$branch" FETCH_HEAD
    prev=$(ls "packages/preview/$NAME" 2>/dev/null | sort -V | tail -1 || true)
    mkdir -p "packages/preview/$NAME"
    cp -R "$OLDPWD/$DEST" "packages/preview/$NAME/$VERSION"
    git add "packages/preview/$NAME/$VERSION"
    git commit -m "$NAME:$VERSION"
    git push --force -u origin "$branch"
    {
      echo "I am submitting ${prev:+an update to }\`$NAME\` (${prev:+$prev → }$VERSION)."
      echo
      echo "Changes since ${prev:-the start} (see $(git -C "$OLDPWD" remote get-url origin)):"
      if git -C "$OLDPWD" rev-parse "v$prev" >/dev/null 2>&1; then
        git -C "$OLDPWD" log --format='- %s' "v$prev..v$VERSION"
      fi
    } > "$work/body.md"
    gh pr create --repo typst/packages --head "$me:$branch" --base main \
      --title "$NAME:$VERSION" --body-file "$work/body.md"
  )
  echo "temporary clone left in $work"
}

case "${1:-}" in
  stage) stage ;;
  check) stage; check ;;
  tag) tag ;;
  pr) pr ;;
  *) sed -n '2,10p' "$0"; exit 2 ;;
esac
