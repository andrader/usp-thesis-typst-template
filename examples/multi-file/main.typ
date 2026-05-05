#import "/src/lib.typ": usp-thesis

#show: usp-thesis.with(
  title: [Normas e Regulamentos da Pós-Graduação na USP],
  title-alt: [Rules and Regulations of Graduate Studies at USP],
  subtitle: [Uma Compilação Modular de Diretrizes e Regimentos],
  author: "João da Silva",
  advisor: "Prof. Dr. Orientador Exemplar",
  institute: "Instituto de Matemática e Estatística",
  program: "Programa de Pós-Graduação em Estatística",
  degree: "Mestre",
  local: "São Paulo",
  year: "2024",
  abstract-pt: [
    Este trabalho apresenta uma compilação modular dos principais documentos normativos que regem a pós-graduação na Universidade de São Paulo (USP). A estrutura utiliza múltiplos arquivos para facilitar a manutenção de documentos longos.
  ],
  keywords-pt: ("USP", "Regimento", "Modular", "Pós-Graduação"),
  abstract-en: [
    This work presents a modular compilation of the main normative documents governing graduate studies at the University of São Paulo (USP). The structure uses multiple files to facilitate the maintenance of long documents.
  ],
  keywords-en: ("USP", "Regulation", "Modular", "Graduate Studies"),
  dedication: [Aos estudantes que buscam organização.],
  acknowledgments: [Agradeço à comunidade Typst pelas ferramentas de modularização.],
  epigraph: ["Dividir para conquistar." \ --- Ditado Popular],
  list-of-figures: true,
  list-of-tables: true,
  banca: (
    (nome: "Prof. Dr. Examinador Interno", instituicao: "IME-USP"),
    (nome: "Prof. Dr. Examinador Externo", instituicao: "UNICAMP"),
  ),
)

// Incluindo as seções modulares
#include "sections/01-diretrizes.typ"
#include "sections/02-regimento.typ"
#include "sections/03-regulamento.typ"

#bibliography("./refs.bib")

#include "sections/04-apendice.typ"
