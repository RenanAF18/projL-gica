/* * SISTEMA DE GERENCIAMENTO DE PROJETOS DE PESQUISA
 * Disciplina: Lógica Para Computação
 * Objetivo: Modelar a alocação de alunos em projetos acadêmicos via fila de espera.
 */

-- ----------------------------------------------------------------------------
-- ESTRUTURA DO MODELO (ASSINATURAS)
-- Define as entidades e os relacionamentos básicos do sistema.
-- ----------------------------------------------------------------------------

-- define um conjunto de areas
sig AreaConhecimento{}

-- define as areas específicas
sig AreaPesquisa{
    area: one AreaConhecimento
}

-- representa as materias cursadas pelos alunos
sig Disciplina{
    area: one AreaConhecimento
}

-- define o conjunto de professores do departamento
sig Professor{}

-- projeto central que tem as regras de negocio do sistema de pesquisa
sig Projeto{
    professor: one Professor,
    areaPesquisa: one AreaPesquisa,
    lista: one ListaDeCandidatos,
    alunos: set Aluno,
    vagas: one Int
}

-- representa os alunos do curso
sig Aluno{
    disciplinasPaga: set Disciplina
}

-- define a lista que armazena os alunos interessados em ingressar em um determinado projeto
sig ListaDeCandidatos{
    alunosNaLista: seq Aluno
}

-- ----------------------------------------------------------------------------
-- PARTE 2: FATOS (REGRAS DE NEGÓCIO)
-- Restrições que garantem que o sistema opere conforme as normas do curso.
-- ----------------------------------------------------------------------------

-- nenhum projeto pode ter mais alunos do que vagas
fact maxAlunosPorProjeto{
    all p:Projeto | #p.alunos <= p.vagas
}

-- garante que toda lista de candidatos pertença a exato um projeto
fact listaSempreAssociada {
    all l:ListaDeCandidatos | one p:Projeto | p.lista = l
}

-- cada projeto tem entre 1 e 4 vagas
fact vagas{
    all p:Projeto | 0 < p.vagas and p.vagas <= 4
}

-- um aluno participa de no msximo um projeto
fact alunoEmNoMaximoUmProjeto{
    all a:Aluno | lone p:Projeto | a in p.alunos
}

-- um aluno so pode participar de um projeto se estiver na lista de candidatos
fact naListaDeCandidatos{
    all a:Aluno | all p:Projeto | a in p.alunos =>
    a in p.lista.alunosNaLista.elems
}

-- garante que um projeto tenha sua lista exclusiva
fact listasUnicas {
    all disj p1, p2: Projeto |
        p1.lista != p2.lista
}

-- ordem de entrada dos alunos
fact ordemDeEntrada{
    all p:Projeto |
        #p.lista.alunosNaLista = #(p.lista.alunosNaLista.elems)
}

-- alunos so pode participar de projetos na area que ja tenham cursado disciplina relacionada
fact alunosParticipandoEmProjetoComAreasDeConhecimentoJáPagas{
    all a:Aluno | all p:Projeto | a in p.lista.alunosNaLista.elems =>
    some d: a.disciplinasPaga | d.area = p.areaPesquisa.area
}


-- existem exatamente 3 areas de pesquisa
fact {
    #AreaPesquisa = 3
}
fact areasDePesquisaDistintas {
    all disj ap1, ap2: AreaPesquisa |
        ap1.area != ap2.area
}

-- forma de preenchimento das vagas usando a lista de candidatos
fact filaPreencheVagas {
    all p:Projeto |
        all i: p.lista.alunosNaLista.inds |
            i < p.vagas implies
                p.lista.alunosNaLista[i] in p.alunos
}

-- ----------------------------------------------------------------------------
-- PARTE 3: VERIFICAÇÕES (ASSERTIONS E CHECKS)
-- Testes automáticos para validar se as regras não geram estados inconsistentes.
-- ----------------------------------------------------------------------------

-- Valida se a ocupação respeita o limite de vagas
assert menosAlunosQueVaga{
    all p:Projeto | #p.alunos <= p.vagas
}

-- Valida o teto de 4 vagas por projeto.
assert maxVagasEmProjeto{
    all p:Projeto | p.vagas <=4
}

-- Valida o piso de pelo menos 1 vaga por projeto
assert minVagasEmProjeto{
    all p:Projeto | p.vagas >= 1
}

-- Valida se o número total de alunos participantes nunca excede 4
assert maxAlunosEmProjeto{
    all p:Projeto | #p.alunos <=4
}

-- Valida a relação um-para-um entre projetos e listas
assert listaExclusiva {
    all p1, p2:Projeto | p1 != p2 => p1.lista != p2.lista
}

-- Execução dos testes
check listaExclusiva for 6
check menosAlunosQueVaga for 6
check maxAlunosEmProjeto for 6
check maxVagasEmProjeto for 6
check minVagasEmProjeto for 6
run {} for 3

-- ----------------------------------------------------------------------------
-- PARTE 4: PREDICADOS (CENÁRIOS)
-- ----------------------------------------------------------------------------

-- simula se é possível um aluno estar em listas de espera de projetos diferentes
pred alunoEmMaisDeUmaLista {
    some a:Aluno |
        some disj p1,p2:Projeto |
            a in p1.lista.alunosNaLista.elems and
            a in p2.lista.alunosNaLista.elems
}

run alunoEmMaisDeUmaLista for 6
