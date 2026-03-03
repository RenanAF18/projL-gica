sig AreaConhecimento{}
sig AreaPesquisa{
    area: one AreaConhecimento
}
sig Disciplina{
    area: one AreaConhecimento
}
sig Professor{}
sig Projeto{
    professor: one Professor,
    areaPesquisa: one AreaPesquisa,
    lista: one ListaDeCandidatos,
    alunos: set Aluno,
    vagas: one Int
}

sig Aluno{
    disciplinasPaga: set Disciplina
}

sig ListaDeCandidatos{}

fact maxAlunosPorProjeto{
    all p:Projeto | #p.alunos <= p.vagas
}
fact vagas{
    all p:Projeto | 0 < p.vagas and p.vagas <= 4
}

fact alunoEmNoMaximoUmProjeto{
    all a:Aluno | lone p:Projeto | a in p.alunos
}
fact alunosEmProjetoComAreasDeConhecimentoJáPagas{
    all a:Aluno | all p:Projeto | a in p.alunos =>
    some d: a.disciplinasPaga | d.area = p.areaPesquisa.area
}
fact naListaDeCandidatos{
    all a:Aluno | all p:Projeto | a in p.alunos =>
    a in p.lista
}

fact {
    #AreaPesquisa = 3
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
check maxAlunosEmProjeto for 6
check maxVagasEmProjeto for 6
check minVagasEmProjeto for 6
run {} for 3