create table if not exists cliente(
	CPF int(11),
	nome varchar(30) not null,
	RG int() not null unique,
	endereco varchar(100) not null,
	
	constraint pk_cliente primary key (id)
);

create table if not exists funcionario(
	CPF int(11),
	nome varchar(30) not null,
	RG int not null unique,
	endereco varchar(100),
	salario float not null,
	v_aliment float not null,
	p_saude float not null,
	n_dependentes int,
	
	constraint pk_funcionario primary key(CPF)
	
);

create table if not exists gerente(
	CPF int(11),
	
	constraint pk_gerente primary key(CPF),
	constraint fk_gerente_funcionario foreign key(CPF) references funcionario(CPF) --updates e deletes feito via trigger
	
);

create table if not exists conta(
	id serial,
	gerente integer not null,
	
	constraint pk_conta primary key (id),
	
	constraint fk_conta_cliente foreign key(gerente) references gerente(CPF)
		on delete restrict on update cascade
);


create table agencia(
	id serial,
	localizacao varchar(100),
	constraint pk_agencia primary key(id)
)

CREATE TABLE if not exists emprestimo(
	id_emp serial unique not null,
	cpf_cliente int not null,
	id_agencia int not null,
	valor integer not null,
	data_emp date not null,
	juro double DEFAULT '0,33',


	CONSTRAINT pk_emprestimo
 	primary key (id_emp),
 
	CONSTRAINT fk1_emp_cliente
 		foreign key (cpf_cliente) references cliente(CPF)
		on delete restrict on update restrict, 
	
	CONSTRAINT fk2_emp_agencia
 		foreign key (id_agencia) references agencia(id),
		on delete restrict on update restrict,
	
	CHECK (valor>200)
);

CREATE TABLE if not exists movimentacao_emp( 
	id_mov serial unique not null,
	cpf_cliente1 int not null,
	id_agencia1 int not null,
	cpf_cliente2 int,
	id_agencia2 int,
	valor integer not null,
	tipo varchar(20) not null,
	data_mov date not null,

	CONSTRAINT pk_movimentacao_emp
 		primary key (id_mov),
 
	CONSTRAINT fk1_movemp_cliente
 		foreign key (cpf_cliente1) references cliente(CPF)
		on delete on update cascade,
	
	CONSTRAINT fk2_movemp_agencia1
 		foreign key (id_agencia1) references agencia(id)
		on delete cascade on update cascade,
	
	CONSTRAINT fk3_movemp_cliente
 		foreign key (cpf_cliente2) references cliente(CPF)
		on delete set null on update cascade,
	
	CONSTRAINT fk4_movemp_agencia2
 		foreign key (id_agencia2) references agencia(id)
		on delete cascade on update cascade
);

create table if not exists possui(
	id_cliente int,
	id_conta int,
	
	constraint pk_possui primary key(id_cliente, id_conta),
	
	constraint fk_possui_cliente foreign key(id_cliente) references cliente(CPF)
		on delete cascade on update cascade,
	constraint fk_possui_conta foreign key(id_conta) references conta(id)
		on delete cascade on update cascade
);

create table if not exists dependente(
	CPF int,
	id_funcionario int,
	nome varchar(30),
	
	constraint pk_dependente primary key(CPF),
	
	constraint fk_dep_funcionario foreign key(id_funcionario) references funcionario(CPF)
		on delete cascade on update cascade
);

create table if not exists cartao (
	numero int,
	id_conta int,
	
	constraint pk_cartao primary key(numero),
	
	constraint fk_cartao_conta foreign key(id_conta) references conta(id)
);

create table if not exists movimentacao_cart(
	id_mov serial unique not null,
	cpf_cliente1 int not null,
	id_agencia1 int not null,
	cpf_cliente2 int,
	id_agencia2 int,
	valor integer not null,
	tipo varchar(20) not null,
	data_mov date not null,
	
	CONSTRAINT pk_movimentacao_cart
 		primary key (id_mov),
 
	CONSTRAINT fk1_movcart_cliente
 		foreign key (cpf_cliente1) references cliente(CPF)
		on delete on update cascade,
	
	CONSTRAINT fk2_movcart_agencia1
 		foreign key (id_agencia1) references agencia(id)
		on delete cascade on update cascade,
	
	CONSTRAINT fk3_movcart_cliente
 		foreign key (cpf_cliente2) references cliente(CPF)
		on delete set null on update cascade,
	
	CONSTRAINT fk4_movcart_agencia2
 		foreign key (id_agencia2) references agencia(id)
		on delete cascade on update cascade
)









