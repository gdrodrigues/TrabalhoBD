CREATE OR REPLACE FUNCTION integridade_mov() returns TRIGGER AS $$

DECLARE

BEGIN

	if new.tipo='transferencia'THEN
		if new.cpf_cliente2=null or new.id_agencia2=null THEN
			RAISE EXCEPTION "Para esse tipo de movimentação é necessário um destinatário"
		END IF
	elsif new.tipo='saque' or new.tipo='deposito' THEN
		if new.cpf_cliente2<>null or new.id_agencia2<>null THEN
			RAISE EXCEPTION "Para esse tipo de movimentação é necessário registrar só uma conta e agência"

-- Fazer as restrições para emprestimo.	

END;
$$
LANGUAGE plpgsql;

-- CREATE TRIGGER intefridade_mov() BEFORE INSERT ON FUNCIONARIO