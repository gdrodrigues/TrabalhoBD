Create or replace function limite_dependentes() returns trigger AS $$

DECLARE

c_funcionario cursor for select*from funcionario where funcionario.cpf=new.cpf;
contador integer;

BEGIN
	IF c_funcionario.cargo='comum' THEN
	
		select count(*) from dependente where dependente.cpf=new.cpf into contador;
		
		IF contador=2 THEN
		
			RAISE EXCEPTION 'O funcionário já possui o número máximo de dependentes registrado';
		ELSE
			return new;
			
		END IF;

	ELSE	
		select count(*) from dependente where dependente.cpf=new.cpf into contador;
		
		IF contador=4 THEN
		
			RAISE EXCEPTION 'O gerente já possui o número máximo de dependentes registrado';
		ELSE
			return new;
			
		END IF;
	END IF;	
END;
$$
LANGUAGE plpgsql;

--CREATE TRIGGER limite_dependentes BEFORE INSERT on dependente
 --	FOR EACH ROW EXECUTE PROCEDURE limite_dependetes();