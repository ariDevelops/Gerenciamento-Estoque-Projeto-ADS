#!/usr/bin/perl
use warnings;
use strict;
use feature qw(say);
use DBI;

our $quantidade;
my $codigo;
my $nome;
my $data;
my $localizacao;

my $cadastrado = undef;




sub cadastrar {
	my @lista_items = @_;	#recebe os argumentos da funcao
	my @id = qw(codigo nome data localizacao); # identificacao dos items
	
	my $i = 0; #indice
	for my $item (@lista_tems) { # Insere um item no array pra cada ID
	
	print "Entrada $id[$i]:\t";
	chomp($item = <STDIN>);
	$id[$i] = $item;
	$i++;
	
	}

	say "Valores de Entrada:\n @array";
	
	# Cadastra os valores obtidos no banco de dados
	my $dbh =  DBI->connect(
    "dbi:SQLite:dbname=Estoque.db",
    "",
    "",
    { RaiseError => 1, AutoCommit => 0, PrintError => 0 },
    ); #or die $DBH::errstr;

	
	}

