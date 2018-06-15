CREATE OR REPLACE FUNCTION gerenteSupreme()returns TRIGGER AS $$

DECLARE
c1_funcionarios CURSOR for select*from funcionario WHERE funcionario.cargo<>'gerente' and new.agencia=funcionario.agencia;
r1 funcionario%rowtype;
c2_funcionarios CURSOR for select*from funcionario WHERE funcionario.cargo='gerente'and new.agencia=funcionario.agencia;
r2 funcionarios%rowtype;

BEGIN

	for r1 in c1_funcionarios LOOP		
		if new.salario<r1.salario or new.vale_alimentacao<r1.vale_alimentacao or new.p_saude<r1.p_saude or new.n_dependentes<r1._dependentes THEN
			RAISE EXCEPTION 'Os benefícios do gerente não estão de acordo com a política salarial da empresa'

		END IF;
	END LOOP;

	return new;

END;
$$
LANGUAGE plpgsql;

-- CREATE TRIGGER gerenteSupreme() BEFORE INSERT OR UPDATE ON FUNCIONARIO
-- 	FOR EACH ROW EXECUTE PROCEDURE gerenteSupreme();