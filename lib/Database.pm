#!/usr/bin/perl
#package DataBase;
use warnings;
use strict;


use DBI;
use Carp 'croak';
#use Exporter::NoWork;

  my $db_file = "loja1.db";

    my $dbh =  DBI->connect(
    "dbi:SQLite:dbname=$db_file",
    "",
    "",
    { RaiseError => 1, AutoCommit => 0, PrintError => 0 },
    ) or die $DBH::errstr;

    #my $sql =
    #qq{CREATE TABLE Produtos (nome VARCHAR(128), codigo INTEGER)};

    #eval {
      #$dbh->do($sql);
      #$dbh->commit();
    #};

    #if ($@) {
      #$dbh->rollback();
      #die $@;
    #}
    
    my %estoque = (
		'short' => 1253,
		'camisetas' => 2255,
		'mamadeiras' => 46663,
		'Tenis Juv' => 3466
	);
	
	my $sql = 
	qq{INSERT INTO Produtos (nome, codigo) VALUES (?, ?)};
	
	eval {
		my $sth = $dbh->prepare($sql);
		
			while( my($nome, $codigo) = each %estoque) {
				$sth->execute($nome, $codigo);
			}
			
			$dbh->commit();
			return 1;
		}




