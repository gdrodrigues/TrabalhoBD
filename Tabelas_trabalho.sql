create table if not exists cliente(
	CPF bigint not null unique,
	nome varchar(30) not null,
	RG bigint not null unique,
	endereco varchar(100) not null,
	
	constraint pk_cliente primary key(CPF)
);

create table agencia(
	id serial unique,
	localizacao varchar(100) not null unique,
	constraint pk_agencia primary key(id)
);

create table if not exists funcionario(
	CPF bigint not null unique,
	nome varchar(30) not null,
	RG bigint not null unique,
	cargo varchar(12) not null DEFAULT 'comum',
	agencia integer not null,
	endereco varchar(100),
	salario float not null,
	v_aliment float not null DEFAULT '450',
	p_saude float not null DEFAULT '500',
	n_dependentes int DEFAULT '0',
	
	constraint pk_funcionario primary key(CPF),

	constraint fk_agencia foreign key(agencia) references agencia(id)
		on delete cascade on update cascade
	
);

create table if not exists gerente(
	CPF bigint not null unique,
	
	constraint pk_gerente primary key(CPF),
	constraint fk_gerente_funcionario foreign key(CPF) references funcionario(CPF) --updates e deletes feito via trigger
	
);



create table if not exists conta(
	id serial,
	gerente bigint not null,
	id_agencia int not null,
	saldo bigint not null DEFAULT '0',
	limite bigint not null DEFAULT '1000',
	
	constraint pk_conta primary key (id),
	
	constraint fk_conta_cliente foreign key(gerente) references gerente(CPF)
		on delete restrict on update cascade,
		
	constraint fk_agencia foreign key(id_agencia) references agencia(id)
);


CREATE TABLE if not exists movimentacao_emp( 
	id_mov serial unique not null,
	conta_cliente1 bigint not null,
	id_agencia1 int not null,
	conta_cliente2 bigint,
	id_agencia2 int,
	valor integer not null,
	tipo varchar(20) not null,
	data_mov date not null,

	CONSTRAINT pk_movimentacao_emp
 		primary key (id_mov),
 
	CONSTRAINT fk1_movemp_cliente
 		foreign key (conta_cliente1) references conta(id)
		on delete cascade on update cascade,
	
	CONSTRAINT fk2_movemp_agencia1
 		foreign key (id_agencia1) references agencia(id)
		on delete cascade on update cascade,
	
	CONSTRAINT fk3_movemp_cliente
 		foreign key (conta_cliente2) references conta(id)
		on delete cascade on update cascade,
	
	CONSTRAINT fk4_movemp_agencia2
 		foreign key (id_agencia2) references agencia(id)
		on delete cascade on update cascade,
	
	CHECK (valor>0)
);

create table if not exists possui_conta(
	id_cliente bigint,
	id_conta int,
	
	constraint pk_possui primary key(id_cliente, id_conta),
	
	constraint fk_possui_cliente foreign key(id_cliente) references cliente(CPF)
		on delete cascade on update cascade,
	constraint fk_possui_conta foreign key(id_conta) references conta(id)
		on delete cascade on update cascade
);

create table if not exists dependente(
	CPF bigint,
	id_funcionario bigint,
	nome varchar(30),
	
	constraint pk_dependente primary key(CPF),
	
	constraint fk_dep_funcionario foreign key(id_funcionario) references funcionario(CPF)
		on delete cascade on update cascade
);

create table if not exists cartao (
	numero int not null,
	id_conta int not null,
	limite real not null,
	constraint pk_cartao primary key(numero),
	
	constraint fk_cartao_conta foreign key(id_conta) references conta(id)
);

create table if not exists possui_cartao(
	id_cliente bigint not null,
	numero_cartao int not null,
	saldo_cartao real not null,

	constraint pk_possui_cartao primary key (id_cliente, numero_cartao),
	
	constraint fk_possui_cliente foreign key(id_cliente) references cliente(CPF)
		on delete cascade on update cascade,
		
	constraint fk_possui_cartao foreign key(numero_cartao) references cartao(numero)
		on delete cascade on update cascade
);		

create table if not exists movimentacao_cart(
	id_mov serial unique not null,
	cpf_cliente bigint not null,
	valor integer not null,
	descricao varchar(100),
	data_mov date not null,
	
	CONSTRAINT pk_movimentacao_cart
 		primary key (id_mov),
 
	CONSTRAINT fk1_movcart_cliente
 		foreign key (cpf_cliente) references cliente(CPF)
		on delete cascade on update cascade	
);
