#!/usr/bin/perl
#package DataBase;
use warnings;
use strict;


use DBI;
use Carp 'croak';
#use Exporter::NoWork;

  my $db_file = "Estoque.db";

    my $dbh =  DBI->connect(
    "dbi:SQLite:dbname=$db_file",
    "",
    "",
    { RaiseError => 1, AutoCommit => 0, PrintError => 0 },
    ); #or die $DBH::errstr;

    #my $sql =
    #qq{
    #CREATE TABLE Produtos (nome VARCHAR(128), codigo INTEGER, data VARCHAR(255), setor VARCHAR(128))
    #};

    #eval {
      #$dbh->do($sql);
      #$dbh->commit();
    #};

    #if ($@) {
      #$dbh->rollback();
      #die $@;
    #}
    
    #my %estoque = (
		#'short' => 1253,
		#'camisetas' => 2255,
		#'mamadeiras' => 46663,
		#'Tenis Juv' => 3466
	#);
	
#	my $sql2 = 
#	qq{INSERT INTO Produtos (nome, codigo, data, setor) VALUES (?, ?, ?, ?)};
	
	#eval {
#		my($nome, $codigo, $data, $setor) = ('tenis bob', 2366, '10/23', 'infantil');
#		my $sth = $dbh->prepare($sql2);
#		$sth->execute($nome, $codigo, $data, $setor);
		
			#while( my($nome, $codigo) = each %estoque) {
				#$sth->execute($nome, $codigo);
			#}
			
			#$dbh->commit();
			#return 1;
		#}

	my $sql = 
	qq{SELECT nome, codigo, data, setor FROM Produtos};
	my $sth = $dbh->prepare($sql);
	$sth->execute;
	
	while (my @row = $sth->fetchrow_array ) {
	#next if $_ =~ /tenis/;
	print "nome: $row[0]\tcodigo: $row[1]\tdata: $row[2]\tsetor: $row[3] \n" 
		if $row[0] =~ /camisa/;
	}
	
	$dbh->rollback();



