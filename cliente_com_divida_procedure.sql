--retorna todos os clientes de uma agencia que possuem dividda com o banco
create or replace function clientes_agencia(id_agencia int)
returns table(cpf_cliente bigint, nome_cliente varchar) as $$
declare
	contas_agencia cursor for select c.id as id_conta from conta as c
								inner join agencia on c.id_agencia = agencia.id
								where c.saldo<0; 
								
	r1 record;
	r2 record;
begin
	for r1 in contas_agencia loop
		for r2 in (select cl.cpf as cpf, cl.nome as nome from possui_conta pc 
					inner join cliente cl on pc.id_cliente = cl.cpf
					where r1.id_conta = pc.id_conta) loop
					
			return query select r2.cpf, r2.nome;
		end loop;
	end loop;	
	
	return;
end;
$$
language plpgsql;