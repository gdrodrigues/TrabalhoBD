CREATE OR REPLACE FUNCTION up_gerente() returns trigger AS &&

DECLARE

BEGIN

	IF new.cago='gerente' THEN
		INSERT into GERENTE(cpf) values (new.cpf);

END
$$
LANGUAGE plpgsql;

-- CREATE TRIGGER up_gerente AFTER INSERT on FUNCIONARIO
--	FOR EACH ROW EXECUTE PROCEDURE up_gerente();