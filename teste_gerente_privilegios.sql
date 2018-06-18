-- ***************************************** TESTE DOS PRIVILEGIOS DO GERENTE *************************************

--1° inserir uma agencia e alguns funcionarios *******************************

-- insert into agencia(localizacao) values('rua dos bobos °1');
--select * from agencia;

-- INSERT INTO funcionario(cpf,nome,rg,agencia,endereco,salario) values(15605750777, 'Menino', 123567, 1,'rua A n° 8001',1100.0);
-- INSERT INTO funcionario(cpf,nome,rg,agencia,endereco,salario) values(15605750888, 'Neymar', 123568, 1,'rua A n° 8002',1100.0);
-- INSERT INTO funcionario(cpf,nome,rg,agencia,endereco,salario) values(15605750999, 'IC_UFF', 123569, 1,'rua A n° 8003',1100.0);
-- INSERT INTO funcionario(cpf,nome,rg,agencia,endereco,salario) values(15605750111, 'UFFUFF', 123561, 1,'rua A n° 8004',1100.0);

--INSERT INTO funcionario(cpf,nome,rg,cargo,agencia,endereco,salario) values(15605750666, 'Menino', 123566, 'gerente', 1,'rua A n° 8001',1100.0);
--INSERT INTO funcionario(cpf,nome,rg,cargo,agencia,endereco,salario) values(15605750555, 'Neymar', 123565, 'gerente', 1,'rua A n° 8002',1100.0);


--2° inserir os casos de confronto: *********************88

--INSERT INTO funcionario(cpf,nome,rg,cargo,agencia,endereco,salario, v_aliment, p_saude) 
--	values(15605750260, 'Jesus1', 120224, 'gerente', 1,'rua A n° 8002',90001.0, 460.0, 5000.0);

-- INSERT INTO funcionario(cpf,nome,rg,cargo,agencia,endereco,salario, v_aliment, p_saude) 
-- 	values(15605750333, 'Jesus', 123544, 'Cara de TI', 1,'rua A n° 8002',900.0, 40.0, 50.0);
	
select * from funcionario;


--3° update ***********

--update funcionario set salario = 300 where nome = 'Menino';

--update funcionario set salario = 401 where cargo='Cara de TI';

--select * from funcionario;