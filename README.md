## **Sistema de Gerenciamento de Projetos de Pesquisa (Alloy Model)**
Este repositório contém a especificação formal utilizando a linguagem Alloy para modelar o sistema de inscrição e seleção de alunos em projetos de pesquisa de um departamento de Ciência da Computação.

## **Disciplina: Lógica Para Computação & Professor: Salatiel Dantas**

## **Integrantes:**
- BEATRIZ DE MELO PAIVA
- BRUNA ROCHA CAVALCANTI
- LUIS GUSTAVO PAIVA ALVES
- MIQUEIAS HENDERSON DA SILVA SANTOS
- SAVIO FERREIRA BELTRAO CARTAXO
- SAVIO RENAN ALVES FURTADO

Observações para a Equipe:
- Sempre realize o git pull antes de iniciar qualquer modificação.
- Qualquer alteração na lógica dos fatos deve ser comunicada previamente no grupo de comunicação da equipe.
------------------------------------------------------------------------------------------------------------------------------------
## **Projeto:**
### O curso de Ciência da Computação deseja gerenciar a inscrição de alunos em projetos de pesquisa oferecidos por professores do departamento. Cada projeto de pesquisa está associado a exatamente um professor responsável, mas um professor pode orientar vários projetos simultaneamente. O curso considera um conjunto fixo de 3 áreas de pesquisa principais, e cada projeto está vinculado a exatamente uma dessas áreas. Cada projeto possui capacidade limitada, oferecendo no máximo 4 vagas para alunos participantes. Um aluno pode participar de, no máximo, um projeto de pesquisa por semestre letivo. Os alunos podem se inscrever em projetos cuja área esteja relacionada a uma disciplina na qual já tenham sido aprovados anteriormente. Para cada projeto existe uma lista de candidatos. Sempre que houver vaga disponível em um projeto, ela deve ser preenchida por um dos alunos da lista de candidatos correspondente, caso existam candidatos aguardando. Não é permitido que um projeto tenha mais alunos participantes do que o seu limite de vagas, nem que um aluno participe de um projeto para o qual não tenha realizado inscrição prévia.

## **Descrição do Problema**
O sistema visa gerenciar a alocação de alunos em projetos orientados por professores. As principais restrições incluem:
- Capacidade: Cada projeto oferece entre 1 e 4 vagas.
- Orientação: Um professor pode orientar vários projetos, mas cada projeto tem exatamente um orientador.
- Áreas de Conhecimento: Existem 3 áreas fixas e distintas; o aluno deve ter cursado uma disciplina na área do projeto para ser elegível.
- Processo de Seleção: A entrada ocorre via lista de candidatos (fila), respeitando a ordem de inscrição.
------------------------------------------------------------------------------------------------------------------------------------
## Esquema do projeto:

<img width="740" height="608" alt="image" src="https://github.com/user-attachments/assets/8014df22-ff0c-4684-8412-f66cb5f4655c" />

------------------------------------------------------------------------------------------------------------------------------------
## **1. Sobre o Projeto**
Este projeto consiste em uma especificação formal utilizando a linguagem Alloy para modelar o sistema de inscrição de alunos em projetos de pesquisa de um departamento de Ciência da Computação.

## **2. Modelagem do Domínio**
Assinaturas (sig)
- Professor: Entidade responsável pela orientação.
- AreaConhecimento & AreaPesquisa: Definem o escopo temático e os pré-requisitos acadêmicos.
- Projeto: O elemento central que conecta Professor, AreaPesquisa, ListaDeCandidatos, Alunos e o número de Vagas.
- Aluno: Candidato que possui um conjunto de disciplinasPaga.
- ListaDeCandidatos: Estrutura que utiliza sequências (seq Aluno) para garantir a ordem de entrada.

Regras de Negócio (Fatos)
- maxAlunosPorProjeto: O número de participantes nunca excede as vagas definidas.
- naListaDeCandidatos: Um aluno só pode ser efetivado se estiver previamente na lista de candidatos do projeto.
- filaPreencheVagas: Garante que, se houver vaga, o aluno na posição correspondente da lista deve estar no projeto.
- ordemDeEntrada: Garante que a lista de candidatos não possua duplicatas, mantendo a integridade da fila.

## **3. Verificação de Propriedades (Asserções)**
O modelo foi validado através de asserções para garantir que as propriedades desejadas sejam sempre verdadeiras:
- check menosAlunosQueVaga: Valida se o limite de vagas é respeitado em todos os escopos.
- check minVagasEmProjeto: Garante que não existam projetos com 0 vagas.
- run alunoEmMaisDeUmaLista: Comando utilizado para simular e visualizar instâncias onde um aluno demonstra interesse em múltiplos projetos.
------------------------------------------------------------------------------------------------------------------------------------
## **Conclusão**
Este modelo Alloy demonstrou ser eficaz na representação das regras de negócio do departamento. A utilização de lógica de primeira ordem permitiu identificar que as restrições de pré-requisitos acadêmicos e a ordem de prioridade dos candidatos estão consistentes. As verificações automatizadas confirmam que o sistema é seguro contra transbordamento de vagas e garante que apenas alunos qualificados participem das pesquisas, cumprindo integralmente os requisitos da disciplina.
