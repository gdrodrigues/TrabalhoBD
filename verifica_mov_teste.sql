--***************************** teste verifica_emprestimo *****************************

-- select * from agencia; OK

-- select * from funcionario;

-- insert into gerente(cpf) values(15605750666);
-- insert into gerente(cpf) values(15605750555);



-- insert into conta(gerente,id_agencia,saldo) values (15605750555, 1, 1000);
-- select * from conta;

-- saque ***
-- insert into movimentacao_emp(conta_cliente1,id_agencia1,conta_cliente2,id_agencia2,valor,tipo,data_mov)
--  	values(1, 1, null, null, 995, 'saque', CURRENT_TIMESTAMP);

-- alter table conta add column limite bigint not null DEFAULT '1000';



-- ******* emprestimo ***********

-- insert into movimentacao_emp(conta_cliente1,id_agencia1,conta_cliente2,id_agencia2,valor,tipo,data_mov)
--  	values(1, 1, null, null, 5000, 'emprestimo', CURRENT_TIMESTAMP);
	
-- select * from conta;
	
-- ******* deposito **********
-- insert into movimentacao_emp(conta_cliente1,id_agencia1,conta_cliente2,id_agencia2,valor,tipo,data_mov)
--  	values(1, 1, null, null, 15, 'deposito', CURRENT_TIMESTAMP);
-- select * from conta;


--******** transferencia *********** -1=não tem conta **-<
insert into movimentacao_emp(conta_cliente1,id_agencia1,conta_cliente2,id_agencia2,valor,tipo,data_mov)
  	values(1, 1, 3, null, 10, 'transferencia', CURRENT_TIMESTAMP);

select * from conta;
-- ALTER TABLE conta ADD COLUMN limite bigint not null default '1000';