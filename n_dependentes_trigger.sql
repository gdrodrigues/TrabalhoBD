CREATE OR REPLACE FUNCTION n_dependentes() returns TRIGGER AS $$

-- trigger que garante o valor correto do atributo derivado "n_dependentes" da entidade funcionario

DECLARE
	c_funcionario cursor for select*from funcionario where funcionario.cpf=new.cpf
	limite_gerente int = 4;
	limite_comum int =2;
	n_dep int;
BEGIN
	
	if(TG_OP = 'INSERT') then

		select n_dependentes into n_dep from funcionario as f where f.cpf = new.id_funcionario;
		if (c_funcionario.cargo='gerente'and n_dep<limite_gerente or c_funcionario.cargo='comum' and n_dep<limite_comum) then
			UPDATE funcionario SET n_dependentes = n_dependentes+1 WHERE cpf=new.id_funcionario; 
			return new;
		else
			raise exception 'O funcionário já atingiu o limite de dependentes';
			return null;
		end if;
	elsif (TG_OP = 'DELETE') then
		select n_dependentes into n_dep from funcionario as f where f.cpf = old.id_funcionario;
		
		--raise notice '% n dep', old.cpf;
		
		if(n_dep>0)then
			UPDATE funcionario SET n_dependentes = n_dependentes-1 WHERE cpf=old.id_funcionario;
		end if;
		return old;
		
	elsif (TG_OP = 'UPDATE')then
		if(new.id_funcionario <> old.id_funcionario)then
			select n_dependentes into n_dep from funcionario as f where f.cpf = new.id_funcionario;
			
			if(n_dep>=limite_dep)then 
				raise exception 'novo funcionario ja esta no limite de dependentes';
				return null;
			end if;
			
			UPDATE funcionario SET n_dependentes = n_dependentes+1 WHERE cpf=new.id_funcionario;
			UPDATE funcionario SET n_dependentes = n_dependentes-1 WHERE cpf=old.id_funcionario;
			return new;
		end if;
	end if;

	return null;
	
END;
$$
LANGUAGE plpgsql;

drop trigger n_dependentes on dependente;
CREATE TRIGGER n_dependentes before INSERT or update or delete on dependente
FOR EACH ROW EXECUTE PROCEDURE n_dependentes();
