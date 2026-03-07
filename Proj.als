-- Aqui começa a parte Estrutural de Modelo Alloy ---------------------------------------------

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

-- Aqui começa os Fatos ----------------------------------------------------------------------

-- nenhum projeto pode ter mais alunos do que vagas
fact maxAlunosPorProjeto{
    all p:Projeto | #p.alunos <= p.vagas
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

-- forma de preenchimento das vagas usando a lista de candidatos
fact filaPreencheVagas {
    all p:Projeto |
        all i: p.lista.alunosNaLista.inds |
            i < p.vagas implies
                p.lista.alunosNaLista[i] in p.alunos
}

--  Aqui começa os ASSERTS e CHECKS -------------------------------------------------------------------------
assert menosAlunosQueVaga{
    all p:Projeto | #p.alunos <= p.vagas
}
assert maxVagasEmProjeto{
    all p:Projeto | p.vagas <=4
}
assert minVagasEmProjeto{
    all p:Projeto | p.vagas >= 1
}
assert maxAlunosEmProjeto{
    all p:Projeto | #p.alunos <=4
}

check menosAlunosQueVaga for 6
check maxAlunosEmProjeto for 6
check maxVagasEmProjeto for 6
check minVagasEmProjeto for 6
run {} for 3
