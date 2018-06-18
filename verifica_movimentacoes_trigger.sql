--função para verificar movimentaçoes
create or replace function verifica_movimentacoes()
returns trigger as $$
declare
	r1 record;
	r2 record;
begin
	select * into r1 from conta where new.conta_cliente1 = conta.id;
	
	if r1 = null then
		raise exception 'todos os tpos de movimentacao requerem no minimo uma conta';
		return null;
	
	elsif new.tipo = 'saque' then
		if new.valor>r1.saldo then
			raise exception 'valor maior que seu saldo';
			return null;
		end if;
	
	elsif new.tipo = 'emprestimo' then
		if r1.saldo>0 then
			raise exception 'O emprestimo só pode ser feito por conta com saldo<=0';
			return null;
		elsif new.valor>r1.limite then
			raise exception 'valor de emprestimo maior que seu limite';
			return null;
		end if;
	
	elsif new.tipo = 'deposito' then
		update conta set saldo = saldo+new.valor where id=new.conta_cliente1;
		return new;
		
	elsif new.tipo = 'transferencia' then
	
		if new.conta_cliente2<0 then
			raise exception 'o tipo trasnferencia requer duas contas';
			return null;
			
		elsif new.conta_cliente1 = new.conta_cliente2 then
			raise exception 'o tipo trasnferencia requer duas contas diferentes';
			return null;
			
		else
			if r1.saldo<new.valor then
				raise exception 'transferencia não foi possivel, saldo menor que valor de transferencia';
				return null;
			else
				update conta set saldo = saldo-new.valor where id=new.conta_cliente1;
				update conta set saldo = saldo+new.valor where id=new.conta_cliente2;
				return new;
			end if;
		end if;
		
	end if;
	
	update conta set saldo = saldo-new.valor where id=new.conta_cliente1;
	return new;
end;
$$
language plpgsql;

drop trigger verifica_movimentacoes on movimentacao_emp;
create trigger verifica_movimentacoes before insert on movimentacao_emp
	for each row execute procedure verifica_movimentacoes();
