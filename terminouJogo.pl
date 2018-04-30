:- use_module(library(lists)).

[qualEstado].
[jogaveis].

% Questao 5
% Condicoes de termino de jogo:
%
% CASO 1: Uma das mãos de jogadores está vazia,
% o que significa que este conseguiu
% colocar todas as suas peças na mesa.
%
% CASO 2: Nenhum jogador possui peças jogáveis,
% neste caso ninguém pode colocar mais peças
% na mesa, e então vence o jogador que possui
% menos pontos em sua mão.

% verifica se alguma das mãos está vazia
verificaMaos([],_,_,_,true,0).
verificaMaos(_,[],_,_,true,1).
verificaMaos(_,_,[],_,true,2).
verificaMaos(_,_,_,[],true,3).
verificaMaos(_,_,_,_,false,-1).

verificaJogaveis([],[],[],[]).

% soma todos os pontos das peças da mão dada
% e retorna o resultado.
contaPontosAux([], Aux, Aux).
contaPontosAux([(X,Y) | T], Aux, Sum):-
  Soma is Aux + X + Y,
  contaPontosAux(T, Soma, Sum).

% verifica se o item dado é o menor da lista.
minLista([],_).
minLista([H|T], Item):-
   (Item > H -> false
   ;minLista(T,Item)).

% usa a função contaPontosAux para pegar as somas
% de todas as mãos e então usa a função minLista
% para determinar qual jogador tem a menor quantidade de
% pontos.
contaPontos(M1,M2,M3,M4,Vencedor):-
  contaPontosAux(M1, 0, PontosJ1),
  contaPontosAux(M2, 0, PontosJ2),
  contaPontosAux(M3, 0, PontosJ3),
  contaPontosAux(M4, 0, PontosJ4),
  Pontos = [PontosJ1,PontosJ2,PontosJ3,PontosJ4],
  (minLista(Pontos, PontosJ1) -> Vencedor = 0
  ;minLista(Pontos, PontosJ2) -> Vencedor = 1
  ;minLista(Pontos, PontosJ3) -> Vencedor = 2
  ;minLista(Pontos, PontosJ4) -> Vencedor = 3
  ; Vencedor = -1).

% usa a função jogaveis para pegar as peças jogáveis de
% cada mão, e em seguida verifica se nenhuma das mãos possui
% peças jogáveis.
pegaJogaveis(M1,M2,M3,M4, EstadoMesa):-
  jogaveis(M1,EstadoMesa,J1),
  jogaveis(M2,EstadoMesa,J2),
  jogaveis(M3,EstadoMesa,J3),
  jogaveis(M4,EstadoMesa,J4),
  verificaJogaveis(J1,J2,J3,J4).

% a partir das mãos de todos os jogadores e da mesa
% verifica, de acordo com os casos 1 ou 2 se o jogo terminou
% se sim, retorna true na variavel Terminou e dados sobre o vencedor
terminouJogo(_,_,_,_,mesa([],[],[],[]),false,-1).
terminouJogo(mao(M1),mao(M2),mao(M3),mao(M4),Mesa, Terminou, Vencedor):-
  verificaMaos(M1,M2,M3,M4,Fin,Winner),

  (Fin -> Terminou = true, Vencedor = Winner
  ;qualEstado(Mesa, Estado),
   pegaJogaveis(mao(M1),mao(M2),mao(M3),mao(M4),Estado) ->
      contaPontos(M1,M2,M3,M4,W),
      Terminou = true, Vencedor = W
  ; Terminou = false, Vencedor = -1).

n :-
  notrace,nodebug.

test4:-

  J1 = mao([(2,3),(0,5),(2,4),(0,4),(0,2),(0,6),(6,6)]),

  J2 = mao([(3,5),(4,4),(1,2),(2,5),(3,4),(5,6),(1,5)]),

  J3 = mao([(1,6),(1,4),(4,6),(0,3),(2,6),(0,0),(3,6)]),

  J4 = mao([(0,1),(1,3),(3,3),(2,2),(4,5),(5,5),(1,1)]),

  M1 = mesa([(6,6)],[(3,6),(6,6)],[(5,6),(6,6)],[(6,6)]),

  terminouJogo(J1,J2,J3,J4,M1, Terminou,Vencedor),
  write(Terminou),nl,write(Vencedor).
