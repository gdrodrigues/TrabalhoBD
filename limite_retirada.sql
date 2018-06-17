create or replace function limite_retirada()
returns trigger as $$
declare						
	r1 record;
begin
	if new.tipo = 'saque' or new.tipo = 'emprestimo' then
		select limite,saldo into r1 from possui 
			inner join conta on conta.id = possui.id and conta.id = new.conta_id;
			
		if r1.limite + r1.saldo >= new.valor then
			update conta set conta.saldo = r1.saldo - new.valor where conta.id = new.conta_id;
			raise notice 'valor retirado com sucesso!';
			return new;
		else
			raise exception 'valor de retirada muito alto!';
			return null;
		end if;
	end if;
	
	raise exception 'n�o � uma opera��o de saque ou emprestimo!';
	return null;
end;
$$ language plpgsql;