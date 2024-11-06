#!/usr/bin/perl
#Desenvolvimento do Sistema de Gerenciamento de Estoque - Ariel Gomes Vieira 
#04/11/2024
use warnings;
use strict;
use autodie;
use feature "say";

#dependencias
use Cwd;
use Tk;
use Tk::PNG;
use DBI;



# configurações da janela principal
binmode(STDOUT, ":utf8");
my $mw = MainWindow->new;
$mw->geometry('800x500');
$mw->configure(-background => 'grey',
               -title => 'Easy Estoque');




#---------------------------------------------------------------------
# cabeçalho e Barra de ferramentas
my $header = $mw->Frame(-background => "blue",
                        -relief => "groove",
                        -borderwidth => 7);
$header->configure(-height => '64');
$header->pack(
    -side => 'top',
    -fill => 'x'); 

# Icones 
my($entrada, $db, $envios, $vendas, $estoquista, $lixeira) = (
$header->Photo(-file => './assets/32px/inventory32.png'),
$header->Photo(-file => './assets/32px/database-table32.png'),
$header->Photo(-file => './assets/32px/delivery32.png'),
$header->Photo(-file => './assets/32px/sales32.png'),
$header->Photo(-file => './assets/32px/man32.png'),
$header->Photo(-file => './assets/32px/lixo1.png')
);

# botões ferramentas

# Entrada de produtos 
my $entProduto = $header->Button(
    -image => $entrada,
    #-indicatoron => 0,
    #-selectcolor => 'darkblue',
    -background => 'blue',
    -activebackground => 'darkblue',
    -highlightbackground => 'blue',
    -relief => 'flat',
    -borderwidth => 0,
    -cursor => 'hand2',
    -command => \&cadastrar
);
$entProduto->configure(-width => '40', 
                       -height => '40');

$entProduto->pack(-side => 'left',
                  -padx => 5, -pady => 5);



# Banco de dados
my $dbProdutos = $header->Button(
    -image => $db,
    #-indicatoron => 0,
    #-selectcolor => 'darkblue',
    -background => 'blue',
    -activebackground => 'darkblue',
    -highlightbackground => 'blue',
    -relief => 'flat',
    -borderwidth => 0,
    -cursor => 'hand2',
    -command => \&InterfaceSQL
);
$dbProdutos->configure(-width => '40', 
                       -height => '40');

$dbProdutos->pack(-side => 'left',
                  -padx => 5, -pady => 5);



# Envio de Produtos 
my $envProdutos = $header->Button(
    -image => $envios,
    #-indicatoron => 0,
    #-selectcolor => 'darkblue',
    -background => 'blue',
    -activebackground => 'darkblue',
    -highlightbackground => 'blue',
    -relief => 'flat',
    -borderwidth => 0,
    -cursor => 'hand2',
);
$envProdutos->configure(-width => '40', 
                       -height => '40');

$envProdutos->pack(-side => 'left',
                  -padx => 5, 
                  -pady => 5);


# Faturamento 
my $faturamento = $header->Button(
    -image => $vendas,
    #-indicatoron => 0,
    #-selectcolor => 'darkblue',
    -background => 'blue',
    -activebackground => 'darkblue',
    -highlightbackground => 'blue',
    -relief => 'flat',
    -borderwidth => 0,
    -cursor => 'hand2',
);
$faturamento->configure(-width => '40', 
                       -height => '40');

$faturamento->pack(-side => 'left',
                  -padx => 5, 
                  -pady => 5);

# Perfil do Estoquista 
my $estoquistaPerfil = $header->Button(
    -image => $estoquista,
    #-indicatoron => 0,
    #-selectcolor => 'darkblue',
    -background => 'blue',
    -activebackground => 'darkblue',
    -highlightbackground => 'blue',
    -relief => 'flat',
    -borderwidth => 0,
    -cursor => 'hand2',
);
$estoquistaPerfil->configure(-width => '40', 
                       -height => '40');

$estoquistaPerfil->pack(-side => 'left',
                  -padx => 5, 
                  -pady => 5);

# Lixeira 
my $lixo = $header->Checkbutton(
    -image => $lixeira,
    -indicatoron => 0,
    -selectcolor => 'darkblue',
    -background => 'blue',
    -activebackground => 'darkblue',
    -highlightbackground => 'blue',
    -relief => 'flat',
    -borderwidth => 0,
    -cursor => 'hand2',
);
$lixo->configure(-width => '40', 
                 -height => '40');

$lixo->pack(-side => 'right',
                  -padx => 5, 
                  -pady => 5);




#---------------------------------------------------------------------
# rodapé do programa
my $footer = $mw->Frame(-background => 'black');
$footer->configure(-height => '20');
$footer->pack(-side => "bottom",
              -fill => 'x');

my $copy = "\x{00A9}";  # simbolo &copy
$footer->Label(-text => "Ariel Vieira $copy",
               -background => 'black',
               -foreground => 'white',
               -font => 'lucidasanstypewriter-8')
               ->pack(-side => 'right');

$footer->Label(
    -text => 'v2.0.0 GNU/General Public licence',
    -background => 'black',
    -foreground => 'white',
    -font => 'lucidasanstypewriter-8')
    ->pack(-side => 'left');



#---------------------------------------------------------------------
# Area de Texto 
our $text = $mw->Scrolled("Listbox");
$text->configure(-background => 'white', #'LightBlue',
                 -foreground => 'darkblue',
                 -relief => 'ridge',
                 -borderwidth => 5,
                 -cursor => 'pencil',
                 -width => 60,
                 -height => 20,
                 #-font => 'default',
                 #-highlightcolor => color,
                 #-highlightbackground => color,
                 #-insertbackground => color,
                 #-insertborderwidth => amount,
                 -selectbackground => 'darkblue',
                 #-selectborderwidth => amount,
                 -selectforeground => 'white',
                 );
$text->pack(-side => 'left',
            -anchor => 'n',
            #-fill => 'y'
);



#---------------------------------------------------------------------
#Pesquisa de codigos
#input
our $busca = $mw->Entry(-background => 'white',
                       -text => 'codigo Produto',
                       #-textvariable => $texto,
                       -width => 25);
$busca->pack(-side => 'left',
             -anchor => 'n',
             -padx => 3,
             -ipady => 3
           );


#botao
$mw->Button(-text => 'Busca',
            -cursor => 'hand2',
#            -command => sub { $text->destroy if Tk::Exists($text); }
             -command => \&buscarDados
            )->pack( -side => 'left',
                     -anchor => 'n');
                                     

#informação
my $info = 'nulo';
$mw->Label(-textvariable => \$info,
           -relief => 'flat')->pack(-side => 'left',
                                    -anchor => 'n',
                                    -pady => 5,
                                    -padx => 7);

MainLoop;




########################################################################################
#                  Area Principal Campo de Busca e relatorio Produtos
########################################################################################



#-------------------------Algoritmo de Busca ------------------------------
sub buscarDados {
    our $text;
    our $busca;

    my $codigo = $busca->get();

    $info = 'Buscando ...';
    $text->delete("1.0", "end");
        if(!open(FH, "db.txt")) {
            $text->insert("end", "Error: Base de dados não encontrada\n");
            return;
        }
        while( <FH> ) { 
            #$text->insert("end", $_); 
            $text->insert("end", $_) if $_ =~ /$codigo/;
        }
        close(<FH>);
        $info = "Carregado";

}

########################################################################################
#---------------------------------Janela de Cadastro------------------------------
########################################################################################
sub cadastrar {
    my $winCadastro = $mw->Toplevel();
    $winCadastro->geometry('400x356');
    $winCadastro->configure(-background => 'white',
                            -title => "Cadastro de produto");

    # Input Codigo Danfe
    $winCadastro->Label(-text => 'codigo DANFE:',
                        -relief => 'flat',
                        -background => 'white')->pack(-side => 'top',
                                                      -anchor => 'w',
                                                      -pady => 5);

    my $numero = $winCadastro->Entry(-background => 'blue',
                                     -foreground => 'white',
                                     -font => 'default');
    $numero->pack(-side => 'top');


    # Input Nome do produto
    $winCadastro->Label(-text => 'Nome Produto:',
                        -relief => 'flat',
                        -background => 'white')->pack(-side => 'top',
                                                      -anchor => 'w',
                                                      -pady => 5);

    my $nome = $winCadastro->Entry(-background => 'blue',
                                     -foreground => 'white',
                                     -font => 'default');
    $nome->pack(-side => 'top');

    #  Input Data de chegada
    $winCadastro->Label(-text => 'Data de chegada:',
                        -relief => 'flat',
                        -background => 'white')->pack(-side => 'top',
                                                      -anchor => 'w',
                                                      -pady => 5);

    my $data = $winCadastro->Entry(-background => 'blue',
                                     -foreground => 'white',
                                     -font => 'default');
    $data->pack(-side => 'top');


    # Input Departamento Categoria
    $winCadastro->Label(-text => 'Setor ("categoria"):',
                        -relief => 'flat',
                        -background => 'white')->pack(-side => 'top',
                                                      -anchor => 'w',
                                                      -pady => 5);

    my $setor = $winCadastro->Entry(-background => 'blue',
                                     -foreground => 'white',
                                     -font => 'default');
    $setor->pack(-side => 'top');




	# Botão de Cadastro
     my $botaoCadastro = $winCadastro->Button(
        -text => 'Cadastrar', 
        -cursor => 'hand2',
        -activebackground => 'grey',
        -command => 
                sub { 
                        my @items;
                            push(@items, ($numero->get(), 
                                          $nome->get(), 
                                          $data->get(), 
                                          $setor->get()));

                         &inserirItem(@items);
                    });

     $botaoCadastro->pack( -side => 'bottom',
                       -fill => 'x');


}

########################################################################################
#                               Logica de Banco de Dados 
########################################################################################


sub inserirItem {
    #say $_ for @_;
    my @data = @_;
    my $PATH = "$ENV{\"HOME\"}/.config/easy-estoque/Estoque.db";
    my $dir = "$ENV{\"HOME\"}/.config/easy-estoque";
    my $dbh;
    my $condicao = undef;
    
    #checa se o diretorio de configuracoes existe
    if ( -e $dir and -d $dir ) {
		
		# Conecta o Banco de Dados
		 $dbh = DBI->connect(
		"dbi:SQLite:dbname=$PATH",
		"",
		"",
		{ RaiseError => 1, AutoCommit => 0, PrintError => 0 },
		);
		$condicao = "existe";
	
	 } else {
		 # Cria o diretorio antes de conectar o banco 
		mkdir $dir;
		$dbh = DBI->connect(
		"dbi:SQLite:dbname=$PATH",
		"",
		"",
		{ RaiseError => 1, AutoCommit => 0, PrintError => 0 },
		);
		$condicao = "nao existe";
	 }


	#checa se o banco de dados ja existe!
	if ( $condicao eq "nao existe") {
     my $sql = 
     qq{
     CREATE TABLE Estoque (codigo INTEGER, nome VARCHAR(255), data VARCHAR(128), setor  VARCHAR(128))
     };
    $dbh->do($sql);
    $dbh->commit();
    $dbh->rollback();
	}
	 

	if ( $condicao eq "existe" ) {
	my $sql2 = 
	qq{INSERT INTO Estoque (codigo, nome, data, setor) VALUES (?, ?, ?, ?)};
	
	my $sth = $dbh->prepare($sql2);
	$sth->execute($data[0], $data[1], $data[2], $data[3]);
    $dbh->commit();
    $dbh->rollback();
	}
	
	
    
}

sub InterfaceSQL {
    my $PATH = "$ENV{\"HOME\"}/.config/easy-estoque/Estoque.db";
    system("sqlitebrowser $PATH");
	}
