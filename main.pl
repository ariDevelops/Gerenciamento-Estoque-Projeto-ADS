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
my $entProduto = $header->Checkbutton(
    -image => $entrada,
    -indicatoron => 0,
    -selectcolor => 'darkblue',
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



# Envio de Produtos 
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


# Faturamento 
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

# Perfil do Estoquista 
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
my $text = $mw->Scrolled("Listbox");
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
$text->insert('end', "produto / 650563");



#---------------------------------------------------------------------
#Pesquisa de codigos

#botao
$mw->Button(-text => 'Busca',
            -cursor => 'hand2',
#            -command => sub { $text->destroy if Tk::Exists($text); }
             -command => \&buscarDados 
            )->pack( -side => 'left',
                     -anchor => 'n',
                                     );

#input
my $busca = $mw->Entry(-background => 'white',
                       -text => 'codigo Produto',
                       -width => 25);
$busca->pack(-side => 'left',
             -anchor => 'n',
             -padx => 3,
             -ipady => 3
           );

#informação
my $info = 'nulo';
$mw->Label(-textvariable => \$info,
           -relief => 'flat')->pack(-side => 'left',
                                    -anchor => 'n',
                                    -pady => 5,
                                    -padx => 7);

MainLoop;




########################################################################################
#                                   Algoritmos Logicos
########################################################################################



#-------------------------Algoritmo de Busca ------------------------------
sub buscarDados {
    $info = 'Buscando ...';
    $text->delete("1.0", "end");
        if(!open(FH, "db.txt")) {
            $text->insert("end", "Error: Base de dados não encontrada\n");
            return;
        }
        while( <FH> ) { $text->insert("end", $_); }
        close(FH);
        $info = "Carregado";

}


#-------------------------Janela de Cadastro------------------------------
sub cadastrar {
    my $winCadastro = $mw->Toplevel();
    $winCadastro->geometry('400x356');
    $winCadastro->configure(-background => 'white',
                            -title => "Cadastro de produto");

    #Codigo
    $winCadastro->Label(-text => 'codigo DANFE:',
                        -relief => 'flat',
                        -background => 'white')->pack(-side => 'top',
                                                      -anchor => 'w',
                                                      -pady => 5);

    my $numero = $winCadastro->Entry(-background => 'blue',
                                     -foreground => 'white',
                                     -font => 'default');
    $numero->pack(-side => 'top');


    #Nome do produto
    $winCadastro->Label(-text => 'Nome Produto:',
                        -relief => 'flat',
                        -background => 'white')->pack(-side => 'top',
                                                      -anchor => 'w',
                                                      -pady => 5);

    my $nome = $winCadastro->Entry(-background => 'blue',
                                     -foreground => 'white',
                                     -font => 'default');
    $nome->pack(-side => 'top');

    # Data
    $winCadastro->Label(-text => 'Data de chegada:',
                        -relief => 'flat',
                        -background => 'white')->pack(-side => 'top',
                                                      -anchor => 'w',
                                                      -pady => 5);

    my $data = $winCadastro->Entry(-background => 'blue',
                                     -foreground => 'white',
                                     -font => 'default');
    $data->pack(-side => 'top');


    # Departamento Categoria
    $winCadastro->Label(-text => 'Setor ("categoria"):',
                        -relief => 'flat',
                        -background => 'white')->pack(-side => 'top',
                                                      -anchor => 'w',
                                                      -pady => 5);

    my $setor = $winCadastro->Entry(-background => 'blue',
                                     -foreground => 'white',
                                     -font => 'default');
    $setor->pack(-side => 'top');




     my $cadastrar = $winCadastro->Button(-text => 'Cadastrar', 
                                          -cursor => 'hand2',
                                          -activebackground => 'grey',
                                          -command => 
    # Evento de Cadastro
    sub { exit }


     );
     $cadastrar->pack( -side => 'bottom',
                       -fill => 'x');
}

#sub inserirItem {}