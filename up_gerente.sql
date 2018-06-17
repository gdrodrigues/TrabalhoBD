CREATE OR REPLACE FUNCTION up_gerente() returns trigger AS &&

DECLARE

BEGIN

	IF (TG_OP= 'INSERT' and new.cago='gerente') THEN
		INSERT into GERENTE(cpf) values (new.cpf);
		

	ELSIF TG_OP= 'UPDATE'
	
		if funcionario.cargo='comum' and new.cargo='gerente' THEN
			INSERT into GERENTE(cpf) values (new.cpf);
		END IF;

		if funcionario.cargo='gerente' and new.cargo='comum' THEN
			DELETE FROM gerente WHERE gerente.cpf=new.cpf;
		END IF;
		
	END IF;
	
	return new;

END
$$
LANGUAGE plpgsql;

-- CREATE TRIGGER up_gerente AFTER INSERT or BEFORE UPDATE on FUNCIONARIO
--	FOR EACH ROW EXECUTE PROCEDURE up_gerente();
