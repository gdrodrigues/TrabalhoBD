-- função para garantir que os beneficios de um gerente sejam maiores que o do resto dos funcionarios
-- *detalhe: entre funcionarios da mesma agencia*
CREATE OR REPLACE FUNCTION gerente_privilegios()returns TRIGGER AS $$

DECLARE
	r1 funcionario%rowtype;
BEGIN
	
	if(new.cargo = 'gerente')then
		for r1 in select * from funcionario WHERE funcionario.cargo<>'gerente' and new.agencia=funcionario.agencia loop
			if new.salario<r1.salario or new.v_aliment<r1.v_aliment
				or new.p_saude<r1.p_saude THEN
				
				RAISE EXCEPTION 'Um gerente não pode possuir algum beneficio inferior ao de algum funcionario';
				return null;
			end if;
		end loop;
		
	--caso o seja um funcionario 'comum' vem para cá
	else
		for r1 in select * from funcionario WHERE funcionario.cargo='gerente'and new.agencia=funcionario.agencia loop
			if new.salario>r1.salario or new.v_aliment>r1.v_aliment 
				or new.p_saude>r1.p_saude THEN
				RAISE EXCEPTION 'O funcionario não pode possuir algum beneficio superior ao de algum gerente';
				return null;
			end if;
		end loop;
	end if;

	return new;
END;
$$
LANGUAGE plpgsql;

drop trigger gerente_privilegios on funcionario;
CREATE TRIGGER gerente_privilegios BEFORE INSERT OR UPDATE ON FUNCIONARIO
FOR EACH ROW EXECUTE PROCEDURE gerente_privilegios();