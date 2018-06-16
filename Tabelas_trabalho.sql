create table cliente(
	CPF int(11),
	nome varchar(30) not null,
	RG int() not null unique,
	endereco varchar(100) not null,
	
	constraint pk_cliente primary key (id)
);

create table conta(
	id serial,
	gerente integer not null,
	
	constraint pk_conta primary key (id),
	
	constraint fk_cliente foreign key(gerente) references gerente(CPF)
		on delete restrict on update cascade
);

create table funcionario(
	CPF int(11),
	nome varchar(30) not null,
	RG int() not null unique,
	endereco varchar(100),
	salario float not null,
	v_aliment float not null,
	p_saude float not null,
	n_dependentes int,
	
	constraint pk_funcionario primary key(CPF)
	
);

create table gerente(
	CPF int(11),
	
	constraint pk_gerente primary key(CPF),
	constraint fk_funcionario foreign key(CPF) references funcionario(CPF)
		on delete cascade on update cascade
	
);

create table agencia(
	id serial,
	
	constraint pk_agencia primary key(id)
)

CREATE TABLE EMPRESTIMO
(id_emp serial unique not null,
cpf_cliente int not null,
id_agencia int not null,
valor integer not null,
data_emp date not null,
juro double DEFAULT '0,33',


CONSTRAINT EMPPK
 primary key (id_emp),
 
CONSTRAINT EMPFK1
 foreign key (cpf_cliente) references cliente(CPF)
	on delete cascade on update cascade, 
	
CONSTRAINT EMPFK2
 foreign key (id_agencia) references agencia(id),
	on delete cascade on update cascade,
	
CHECK (valor>200)
);

CREATE TABLE MOVIMENTACAO
( id_mov serial unique not null,
cpf_cliente1 int not null,
id_agencia1 int not null,
cpf_cliente2 int,
id_agencia2 int,
valor integer not null,
tipo varchar(20) not null,
data_mov date not null,

CONSTRAINT MOVPK
 primary key (id_mov),
 
CONSTRAINT MOVFK1
 foreign key (cpf_cliente1) references cliente(CPF)
	on delete on update cascade,
	
CONSTRAINT MOVFK2
 foreign key (id_agencia1) references agencia(id)
	on delete cascade on update cascade,
	
CONSTRAINT MOVFK3
 foreign key (cpf_cliente2) references cliente(CPF)
	on delete set null on update cascade,
	
CONSTRAINT MOVFK4
 foreign key (id_agencia2) references agencia(id)
	on delete cascade on update cascade
);
