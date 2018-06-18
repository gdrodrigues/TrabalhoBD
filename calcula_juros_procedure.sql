create or replace function calcula_juros()
returns void as $$
declare

	emprestimos cursor for select * from movimentacao_emp
							where tipo = 'emprestimo';
	
	r1 record;
begin
	
	for r1 in emprestimos loop
		if r1.situacao <> 'quitado' then
			update conta set saldo = saldo+(r1.juros*saldo) where id = r1.conta_cliente1;
		end if;
	end loop;

end;
$$
language plpgsql;