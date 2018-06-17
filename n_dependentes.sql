CREATE OR REPLACE FUNCTION n_dependentes() returns TRIGGER AS $$

-- trigger que garante o valor correto do atributo derivado "n_dependentes" da entidade funcionario

DECLARE

BEGIN
	UPDATE funcionario SET funcionario.n_dependentes = funcionario.n_dependentes+1 WHERE funcionario.cpf=new.cpf; 

END;
$$
LANGUAGE plpgsql;

-- CREATE TRIGGER n_dependentes AFTER INSERTION on DEPENDENTE
--	FOR EACH ROW EXECUTE PROCEDURE n_dependentes();