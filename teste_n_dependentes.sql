--*************************** CASO DE TESTE DEPENDENTE FUNCIONARIO ********************************************

-- 1° precisamos inserir uma agencia e duas contas

-- insert into agencia(localizacao) values('rua dos bobos n° 0');
-- INSERT INTO funcionario(cpf,nome,rg,agencia,endereco,salario) values(15605750771, 'RodLM', 1235674, 1,'rua paraiso, eden, sao joao de meriti, rj',1100.0);
-- INSERT INTO funcionario(cpf,nome,rg,agencia,endereco,salario) values(15605750772, 'RodLM', 1235673, 1,'rua paraiso, eden, sao joao de meriti, rj',1100.0);
--select * from funcionario;

-- 2° inserimos alguns dependentes

--insert into dependente(CPF, id_funcionario, nome) values(1560570888, 15605750772, 'joaozinho');
--insert into dependente(CPF, id_funcionario, nome) values(1560570999, 15605750772, 'mariazinha');
-- insert into dependente(CPF, id_funcionario, nome) values(1560570111, 15605750260, 'pedrinho');
-- insert into dependente(CPF, id_funcionario, nome) values(1560570555, 15605750260, 'luiz');
-- insert into dependente(CPF, id_funcionario, nome) values(1560570556, 15605750260, 'andre');
-- insert into dependente(CPF, id_funcionario, nome) values(1560570557, 15605750260, 'gabriel');
--insert into dependente(CPF, id_funcionario, nome) values(1560570558, 15605750260, 'duarte');

-- 3° deletamos alguns dependentes

--delete from dependente where cpf = 1560570888;
--delete from dependente where cpf = 1560570557;
--delete from dependente where cpf = 1560570556;

--select * from funcionario;

-- 4° teste de update mudar dependente de funcionario

--update dependente set id_funcionario = 15605750772 where id_funcionario = 15605750771;
--update dependente set id_funcionario = 15605750771 where cpf = 1560570999;
-- update dependente set id_funcionario = 15605750771 where id_funcionario = 15605750260;

select * from funcionario;