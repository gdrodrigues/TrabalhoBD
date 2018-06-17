CREATE OR REPLACE FUNCTION lanca_movimentacao() returns trigger AS &&

DECLARE

BEGIN

	if new.tipo='saque' THEN

		UPDATE conta SET conta.saldo=conta.saldo-new.valor WHERE conta.id=new.conta_cliente1;
		
	ELSIF new.tipo='deposito' or new.tipo='emprestimo'THEN

		UPDATE conta SET conta.saldo=conta.saldo+new.valor WHERE conta.id=new.conta_cliente1;

	ELSE

		UPDATE conta SET conta.saldo=conta.saldo-new.valor WHERE conta.id=new.conta_cliente1;
		UPDATE conta SET conta.saldo=conta.saldo+new.valor WHERE conta.id=new.conta_cliente2;

	END IF;


END
$$
LANGUAGE plpgsql;

-- CREATE TRIGGER lanca_movimentacao AFTER INSERT on MOVIMENTACAO
--	FOR EACH ROW EXECUTE PROCEDURE lanca_movimentos();