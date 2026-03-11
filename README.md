# Sistema de Gerenciamento de Projetos de Pesquisa (Alloy)
> Especificação formal em Alloy para modelar a inscrição e seleção de alunos em projetos de pesquisa acadêmicos, com controle de vagas, fila de candidatos e pré-requisitos por área de conhecimento.
---

## 📋 Informações da Disciplina
| Campo | Informação |
|---|---|
| **Disciplina** | Lógica Para Computação |
| **Professor** | Salatiel Dantas |
| **Instituição** | Universidade Estadual da Paraíba (UEPB) |
---

## 👥 Integrantes
- Beatriz de Melo Paiva
- Bruna Rocha Cavalcanti
- Luis Gustavo Paiva Alves
- Miqueias Henderson da Silva Santos
- Savio Ferreira Beltrao Cartaxo
- Savio Renan Alves Furtado

Observações para a Equipe:
- Sempre realize o git pull antes de iniciar qualquer modificação.
- Qualquer alteração na lógica dos fatos deve ser comunicada previamente no grupo de comunicação da equipe.
---
## **Projeto:**
### O curso de Ciência da Computação deseja gerenciar a inscrição de alunos em projetos de pesquisa oferecidos por professores do departamento. Cada projeto de pesquisa está associado a exatamente um professor responsável, mas um professor pode orientar vários projetos simultaneamente. O curso considera um conjunto fixo de 3 áreas de pesquisa principais, e cada projeto está vinculado a exatamente uma dessas áreas. Cada projeto possui capacidade limitada, oferecendo no máximo 4 vagas para alunos participantes. Um aluno pode participar de, no máximo, um projeto de pesquisa por semestre letivo. Os alunos podem se inscrever em projetos cuja área esteja relacionada a uma disciplina na qual já tenham sido aprovados anteriormente. Para cada projeto existe uma lista de candidatos. Sempre que houver vaga disponível em um projeto, ela deve ser preenchida por um dos alunos da lista de candidatos correspondente, caso existam candidatos aguardando. Não é permitido que um projeto tenha mais alunos participantes do que o seu limite de vagas, nem que um aluno participe de um projeto para o qual não tenha realizado inscrição prévia.

## **Descrição do Problema:**
O curso de Ciência da Computação deseja gerenciar a inscrição de alunos em projetos de pesquisa oferecidos por professores do departamento. As principais regras do sistema são:

- Cada projeto está associado a **exatamente um professor** responsável, mas um professor pode orientar **vários projetos** simultaneamente.
- O sistema considera um conjunto fixo de **3 áreas de pesquisa** principais.
- Cada projeto está vinculado a **exatamente uma área** e oferece **no máximo 4 vagas**.
- Um aluno pode participar de, **no máximo, um projeto** por semestre letivo.
- O aluno só pode se inscrever em projetos cuja área esteja relacionada a uma **disciplina já cursada**.
- A seleção é feita por ordem de inscrição (**fila de candidatos**).
- Não é permitido que um projeto tenha mais alunos do que seu limite de vagas, nem que um aluno participe sem inscrição prévia.
---
## 1. Sobre o Projeto
Este projeto consiste em uma especificação formal utilizando a linguagem Alloy para modelar o sistema de inscrição de alunos em projetos de pesquisa de um departamento de Ciência da Computação.

## 2. Modelagem do Domínio
## Assinaturas (Entidades)
| Assinatura | Descrição |
|---|---|
| `AreaConhecimento` | Conjunto genérico de áreas do conhecimento |
| `AreaPesquisa` | Área específica de pesquisa vinculada a uma `AreaConhecimento` |
| `Disciplina` | Matéria cursada pelo aluno, associada a uma `AreaConhecimento` |
| `Professor` | Docente responsável por orientar projetos |
| `Projeto` | Entidade central: conecta professor, área, lista de candidatos, alunos e vagas |
| `Aluno` | Candidato com conjunto de disciplinas cursadas |
| `ListaDeCandidatos` | Estrutura sequencial (`seq Aluno`) que mantém a ordem de inscrição |

---

## Regras de Negócio (Fatos)
| Fato | Descrição |
|---|---|
| `maxAlunosPorProjeto` | O número de participantes nunca excede as vagas definidas |
| `listaSempreAssociada` | Toda lista de candidatos pertence a exatamente um projeto |
| `vagas` | Cada projeto tem entre 1 e 4 vagas |
| `alunoEmNoMaximoUmProjeto` | Um aluno participa de no máximo um projeto |
| `naListaDeCandidatos` | Um aluno só pode estar em um projeto se estiver na lista de candidatos correspondente |
| `listasUnicas` | Projetos distintos possuem listas de candidatos distintas |
| `ordemDeEntrada` | A lista não possui duplicatas (integridade da fila) |
| `alunosParticipandoEmProjetoComAreasDeConhecimentoJáPagas` | O aluno só pode se inscrever em projetos de áreas que já cursou |
| `filaPreencheVagas` | As vagas disponíveis são preenchidas pelos alunos na ordem da fila |
| *(anônimo)* | Existem exatamente 3 áreas de pesquisa |
| `areasDePesquisaDistintas` | Cada área de pesquisa possui uma `AreaConhecimento` diferente |

---

## Verificações (Asserções)
As asserções validam automaticamente que as propriedades desejadas são sempre verdadeiras:
| Asserção | O que valida |
|---|---|
| `menosAlunosQueVaga` | O número de alunos respeita o limite de vagas |
| `maxVagasEmProjeto` | Nenhum projeto possui mais de 4 vagas |
| `minVagasEmProjeto` | Nenhum projeto possui menos de 1 vaga |
| `maxAlunosEmProjeto` | O total de alunos participantes nunca excede 4 por projeto |
| `listaExclusiva` | A relação um-para-um entre projetos e listas é mantida |

Todas as verificações são executadas com escopo `for 6`:
```alloy
check listaExclusiva for 6
check menosAlunosQueVaga for 6
check maxAlunosEmProjeto for 6
check maxVagasEmProjeto for 6
check minVagasEmProjeto for 6
```
---

## Predicados (Cenários de Simulação)
| Predicado | Descrição |
|---|---|
| `alunoEmMaisDeUmaLista` | Simula se um aluno pode estar na lista de espera de **mais de um projeto** ao mesmo tempo (permitido pelo modelo) |

```alloy
run alunoEmMaisDeUmaLista for 6
```

> **Nota:** Um aluno pode estar em múltiplas listas de candidatos, mas só pode ser **efetivado em um único projeto**.

---
## 3. Como Executar

### Pré-requisitos
- [Alloy Analyzer](https://alloytools.org/) versão 4.x ou superior (recomendado: Alloy 6)
- Java 8+ instalado

### Passos
1. Clone o repositório:
   ```bash
   git clone https://github.com/<seu-usuario>/projLogica.git
   cd projLogica
   ```
2. Abra o Alloy Analyzer.
3. Carregue o arquivo `Projeto_alloy` via **File → Open**.
4. Execute as verificações clicando em **Execute** ou usando o menu **Run/Check**.
5. Para visualizar instâncias geradas, clique em **Show** após qualquer comando `run`.
---
## **Conclusão**
Este modelo Alloy demonstrou ser eficaz na representação das regras de negócio do departamento. A utilização de lógica de primeira ordem permitiu identificar que as restrições de pré-requisitos acadêmicos e a ordem de prioridade dos candidatos estão modeladas de forma consistente. As verificações automatizadas confirmam que o sistema é seguro contra transbordamento de vagas e garante que apenas alunos qualificados participem das pesquisas, cumprindo integralmente os requisitos da disciplina.

O principal ponto de atenção identificado está no `fact ordemDeEntrada`, que não garante ausência de duplicatas em sequências Alloy da forma como está implementado — uma revisão desse fact é recomendada para garantir a integridade total da fila.
