
-- ainda tenho que mexer
--função para verificar se uma conta pertence a um cliente
create or replace function conta_cliente()
returns trigger as $$
declare
	contas_cliente1 cursor for select * from possui 
									where new.id_conta1=possui.id_conta;
									
	contas_cliente2 cursor for select * from possui 
									where new.id_conta2=possui.id_conta;
									
	r1 record;
	r2 record;
	
	pertence1 boolean = false;
	pertence2 boolean = false;
begin
	
	if contas_cliente1=null then
		raise exception 'cliente 1 não possui conta.';
		return null;
	end if;
	if contas_cliente2=null and (new.tipo = 'transferencia' or new.tipo = 'emprestimo') then
		raise exception 'cliente 2 não possui conta e tipo de movimentacao requer transferencia ou emprestimo';
		return null;
	end if;
	
	-- verificar se as contas pertencem aos clientes
	
	for r1 in contas_cliente1 loop
		if r1.id_cliente = new.id_cliente1 then
			pertence1 = true;
		end if;
	end loop;
	
	for r2 in contas_cliente2 loop
		if r2.id_cliente = new.id_cliente2 then
			pertence2 = true;
		end if;
	end loop;
	
	if pertence1 and !(new.tipo = 'transferencia' or new.tipo = 'emprestimo') then
		return new;
	end if;
	
	if pertence1 and !pertence2 and (new.tipo = 'transferencia' or new.tipo = 'emprestimo') then
		raise exception 'requer segundo cliente';
		return null;
	end if;
	
	
end;
$$
language plpgsql;