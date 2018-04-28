:- use_module(library(lists)).


% Defina um programa jogaveis/3 que associa uma mão de pedras, um estado válido da mesa a uma lista da mão que podem jogar neste estado (valor: 15 %). Exemplo:
%  ?- jogaveis(mao([(4,4),(1,2),(2,5)]),estado(3,0,(5,5),4),Jogaveis).
%  Jogaveis = [(4,4),(2,5)]

% funcao para verificar se uma peca pertence a uma mesa
% +X,+Y, lados da peca, +lista, pontas de mesa
pertence(6,6,[]):-
  true.
pertence(_,_,[]):- % se todas as pontas foram verificadas retorna false
  false.
pertence(X,Y,[(A,A)|T]):- % se ponta contem carroca
  (X = A -> true % verifica se os lados da peca sao iguais
  ;Y = A -> true
  ; pertence(X,Y,T)). % senao tenta a proxima ponta
pertence(X,Y,[H|T]):- % se ponta contem valor normal
  (X = H -> true % verifica se lados da peca sao iguais
  ;Y = H -> true
  ; pertence(X,Y,T)). % senao tenta a proxima ponta


pega_jogaveis(mao([]), _, Jogaveis ,Jogaveis).% se todas as pecas da mao foram verificadas retorna Jogaveis

pega_jogaveis(mao([(X,Y)|T]), estado(),[], Jogaveis):- % se estado eh vazio, a primeira peca que satisfizer condição eh a unica jogavel
  (pertence(X,Y,[]) ->
    Jogaveis = [(X,Y)] % retorna esta peca se achar
  ;pega_jogaveis(mao(T), estado(),[], Jogaveis)),!. % senao procura a proxima


pega_jogaveis(mao([(X,Y)|T]), estado(A,B,C,D),Acc, Jogaveis):-
  E = [A,B,C,D], % coloca todas as pontas em uma lista
  (pertence(X,Y,E) -> % se a peca pode ser jogada em alguma ponta
    pega_jogaveis(mao(T), estado(A,B,C,D), [(X,Y)| Acc], Jogaveis) % adiciona peca na lista auxiliar e verifica proxima peca
  ;pega_jogaveis(mao(T), estado(A,B,C,D),Acc, Jogaveis)),!. % senao verifica proxima peca sem adicionar a atual na lista

jogaveis(mao(Mao), estado(A,B,C,D), Jogaveis):- % fiz essa gambiarra pra nao usar acc na funcao principal
  pega_jogaveis(mao(Mao), estado(A,B,C,D),[], Jogaveis).

jogaveis(mao(Mao), estado(), Jogaveis):-
  pega_jogaveis(mao(Mao), estado(),[], Jogaveis).

test3:-
 jogaveis(mao([(4,4),(1,2),(1,6),(6,6)]),estado(),Jogaveis),
 write(Jogaveis).
