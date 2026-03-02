sig AreaConhecimento{}
sig AreaPesquisa extends AreaConhecimento{
    area: one AreaConhecimento
}
sig Disciplina extends AreaConhecimento{
    area: one AreaConhecimento
}
sig Professor{}
sig Projeto{
    professor: one Professor,
    area: one AreaPesquisa,
    lista: one ListaDeCandidatos,
    alunos: set Aluno
}
sig Aluno{
    disciplinasPaga: set Disciplina

}
sig ListaDeCandidatos{}

fact maxAlunosPorProjeto{
    all p:Projeto | #p.alunos <=4
}

fact alunoEmNoMaximoUmProjeto{
    all a:Aluno | lone p:Projeto | a in p.alunos
}

fact {
    #AreaPesquisa = 3
}
run {} for 1