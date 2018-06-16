CREATE OR REPLACE FUNCTION responsavel() returns TRIGGER AS $$
	
DECLARE

c_contas cursor for select * from conta where conta.gerente_id = new.id; 

BEGIN

	if c_contas<>null then
		if new.agencia<>old.agencia then
			return null;
		end if;
	end if;

	return new;
END;
$$
LANGUAGE plpgsql;

-- create trigger responsavel before update gerente
-- for each row execute procedure responsavel()  