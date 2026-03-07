## **Sistema de Gerenciamento de Projetos de Pesquisa (Alloy Model)**
## **Disciplina: Lógica Para Computação**
## **Professor: Salatiel Dantas**
## **Integrantes:**
- BEATRIZ DE MELO PAIVA
- BRUNA ROCHA CAVALCANTI
- LUIS GUSTAVO PAIVA ALVES
- MIQUEIAS HENDERSON DA SILVA SANTOS
- SAVIO FERREIRA BELTRAO CARTAXO
- SAVIO RENAN ALVES FURTADO

Observações para a Equipe
- Sempre realize o git pull antes de iniciar qualquer modificação.
- Qualquer alteração na lógica dos fatos deve ser comunicada previamente no grupo de comunicação da equipe.
------------------------------------------------------------------------------------------------------------------------------------
## Projeto:
### O curso de Ciência da Computação deseja gerenciar a inscrição de alunos em projetos de pesquisa oferecidos por professores do departamento. Cada projeto de pesquisa está associado a exatamente um professor responsável, mas um professor pode orientar vários projetos simultaneamente. O curso considera um conjunto fixo de 3 áreas de pesquisa principais, e cada projeto está vinculado a exatamente uma dessas áreas. Cada projeto possui capacidade limitada, oferecendo no máximo 4 vagas para alunos participantes. Um aluno pode participar de, no máximo, um projeto de pesquisa por semestre letivo. Os alunos podem se inscrever em projetos cuja área esteja relacionada a uma disciplina na qual já tenham sido aprovados anteriormente. Para cada projeto existe uma lista de candidatos. Sempre que houver vaga disponível em um projeto, ela deve ser preenchida por um dos alunos da lista de candidatos correspondente, caso existam candidatos aguardando. Não é permitido que um projeto tenha mais alunos participantes do que o seu limite de vagas, nem que um aluno participe de um projeto para o qual não tenha realizado inscrição prévia.
------------------------------------------------------------------------------------------------------------------------------------
## Esquema do projeto:

<img width="740" height="608" alt="image" src="https://github.com/user-attachments/assets/8014df22-ff0c-4684-8412-f66cb5f4655c" />

------------------------------------------------------------------------------------------------------------------------------------
## **1. Sobre o Projeto**
Este projeto consiste em uma especificação formal utilizando a linguagem Alloy para modelar o sistema de inscrição de alunos em projetos de pesquisa de um departamento de Ciência da Computação.

## **2. Modelagem do Domínio (Assinaturas)**
O modelo define os componentes principais do sistema como conjuntos de objetos:
- Professor: Responsável por orientar os projetos.
- Área de Pesquisa & Área de Conhecimento: Define o escopo temático do projeto.
- Projeto: Entidade central que vincula um professor, uma área, uma lista de candidatos e um conjunto de alunos participantes.
- Aluno: Participante que possui um histórico de disciplinas cursadas (pagas).

## **3. Regras de Negócio (Fatos)**
Para garantir a consistência do sistema, os seguintes fatos (facts) foram implementados:
- Capacidade de Vagas: Cada projeto possui entre 1 e 4 vagas.
- Limite de Alunos: O número de alunos em um projeto nunca excede sua capacidade de vagas.
- Exclusividade do Aluno: Um aluno pode participar de, no máximo, um projeto por semestre.
- Pré-requisito Acadêmico: Um aluno só pode participar de um projeto se já tiver sido aprovado em uma disciplina da mesma área de conhecimento do projeto.
- Inscrição Prévia: É obrigatório que o aluno esteja na lista de candidatos do projeto para ser efetivado nele.

## **4. Verificação de Propriedades (Asserções)**
O projeto utiliza asserts para verificar se as restrições impostas estão sendo cumpridas pelo motor de busca do Alloy:
- maxAlunosEmProjeto: Verifica se nenhum projeto ultrapassa o limite físico de 4 alunos.
- minVagasEmProjeto: Garante que todo projeto ofertado tenha ao menos uma vaga disponível.
