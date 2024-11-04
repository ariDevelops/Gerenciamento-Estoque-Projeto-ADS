#!/usr/bin/perl
use warnings;
use strict;
use autodie;
use feature "say";

#dependencias
use Cwd;
use Tk;
use Tk::PNG;



# configurações da janela principal
binmode(STDOUT, ":utf8");
my $mw = MainWindow->new;
$mw->geometry('800x500');
$mw->configure(-background => 'grey',
               -title => 'estoque');

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

#----------- Entrada de produtos ---------------
my $entProduto = $header->Checkbutton(
    -image => $entrada,
    -indicatoron => 0,
    -selectcolor => 'darkblue',
    -background => 'blue',
    -activebackground => 'darkblue',
    -highlightbackground => 'blue',
    -relief => 'flat',
    -borderwidth => 0,
    -cursor => 'hand2'
);
$entProduto->configure(-width => '40', 
                       -height => '40');

$entProduto->pack(-side => 'left',
                  -padx => 5, -pady => 5);



#----------- Banco de dados ---------------
my $dbProdutos = $header->Checkbutton(
    -image => $db,
    -indicatoron => 0,
    -selectcolor => 'darkblue',
    -background => 'blue',
    -activebackground => 'darkblue',
    -highlightbackground => 'blue',
    -relief => 'flat',
    -borderwidth => 0,
    -cursor => 'hand2',
);
$dbProdutos->configure(-width => '40', 
                       -height => '40');

$dbProdutos->pack(-side => 'left',
                  -padx => 5, -pady => 5);



#----------- Envio de Produtos ---------------
my $envProdutos = $header->Checkbutton(
    -image => $envios,
    -indicatoron => 0,
    -selectcolor => 'darkblue',
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


#----------- Faturamento ---------------
my $faturamento = $header->Checkbutton(
    -image => $vendas,
    -indicatoron => 0,
    -selectcolor => 'darkblue',
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

#----------- Perfil do Estoquista ---------------
my $estoquistaPerfil = $header->Checkbutton(
    -image => $estoquista,
    -indicatoron => 0,
    -selectcolor => 'darkblue',
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

#----------- Lixeira ---------------
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


MainLoop;