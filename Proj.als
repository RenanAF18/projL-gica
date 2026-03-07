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
    lista: seq Aluno
}
----------------------------------------------------------------------------------------------

fact maxAlunosPorProjeto{
    all p:Projeto | #p.alunos <= p.vagas
}
fact vagas{
    all p:Projeto | 0 < p.vagas and p.vagas <= 4
}

fact alunoEmNoMaximoUmProjeto{
    all a:Aluno | lone p:Projeto | a in p.alunos
}
fact naListaDeCandidatos{
    all a:Aluno | all p:Projeto | a in p.alunos =>
    a in p.lista.alunos
}
fact alunosParticipandoEmProjetoComAreasDeConhecimentoJáPagas{
    all a:Aluno | all p:Projeto | a in p.lista.alunos =>
    some d: a.disciplinasPaga | d.area = p.areaPesquisa.area
}
fact {
    #AreaPesquisa = 3
}
fact seNalistaEComVagasEntaoNoProjeto{
    all p:Projeto | (#p.alunos < p.vagas) => no 
    (p.lista.alunos - p.alunos)
}

assert maisAlunosQueVaga{
    all p:Projeto | #p.alunos > #p.vagas
}
assert alunosEmProjetosMenorQueVagas{
    all p:Projeto | #p.alunos < p.vagas
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
check maisAlunosQueVaga for 6
check maxAlunosEmProjeto for 6
check maxVagasEmProjeto for 6
check minVagasEmProjeto for 6
run {} for 3