--função para verificar se um cliente pode fazer um emprestimo
-- regras: o usuário só pode fazer emprestimos dentro do seu limite na conta que ele está usando
-- O valor maximo que o cliente pode pegar emprestado é 30%da_renda * 12, sendo este valor o limite; 
-- O cliente só pode fazer um emprestimo se não tiver nenhum pendente.
-- O valor maximo do limite


--***********************
--criar atributo renda
create or replace function verifica_emprestimo()
returns trigger as $$
declare
	
	--adicionar data em movimentacao
--	conta_cliente cursor for select * from conta
								where new.id_conta1 = conta.id;
								
	emprestimos_cliente cursor for select * from movimentacao_emp
									where new.cpf_cliente1 = movimentacao.cpf_cliente and
									movimentacao_emp.tipo = 'emprestimo';
	
	r1 record;
	pertence boolean = false;
	
begin
	
	if new.tipo = 'emprestimo' then
		r1 = select * from conta where new.id_conta1 = conta.id;
		
		--talvez precise criar o atributo divida
		if new.valor>r1.limite+r1.saldo then
			raise exception 'valor maior que seu limite + divida';
			return null;
		
		--criar variavel quitado;
		else
			for r1 in emprestimos_cliente loop
				if r1.quitado = 'nao' then
					raise exception 'o cliente possui um emprestimo não quitado.';
					return null;
				end if;
			end loop;
			
			--for r1 in emprestimos_cliente loop
				--if (SELECT DATE_PART('DAY',CURRENT_TIMESTAMP))-(SELECT DATE_PART('DAY',r1.data))< 
			--end loop;
			
		end if;
	end if;
	
	return new;
end;
$$
language plpgsql;