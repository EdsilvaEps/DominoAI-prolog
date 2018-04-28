%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                  %
% Simplified Domino game %
%                                  %
%                                  %
% Author : Edson NS Neto
%
% Date   : 13/04/2018              %
%                                  %
%                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- use_module(library(lists)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% funcoes uteis  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% funcao para inverter uma lista
reverse([],Z,Z).
reverse([H|T],Z,Acc) :-
    reverse(T,Z,[H|Acc]).

% funcao para decrementar um numero
decr(X,NX):-
  NX is X-1.

% funcao para incrementar um numero
incr(X,NX):-
  NX is X + 1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% funcoes uteis/fim %%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%% questao 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ex : ?- distribuiPedras(E), E = equipes(J1,J2,J3,J4).

% E = equipes(mao([(2,3),(1,3),(4,6),(2,4),(0,4),...]), ...)

% J1 = mao([(2,3),(1,3),(4,6),(2,4),(0,4),(0,2),(0,0)]),

% J2 = mao([(3,5),(4,4),(1,2),(2,5),(3,4),(5,6),(1,5)]),

% J3 = mao([(1,6),(1,4),(3,3),(0,3),(2,6),(0,6),(3,6)]),

% J4 = mao([(0,1),(6,6),(0,5),(2,2),(4,5),(5,5),(1,1)]).

% funcao principal, utiliza a funcao basica embaralhaMao para
% distribuir pecas para as maos dos quatro jogadores do jogo
maosEquipes([], J1,J2,J3,J4,equipes(J1,J2,J3,J4)).
maosEquipes(Mesa1,J1,J2,J3,J4, equipes(J1,J2,J3,J4)):-
  % chama embaralhaMao para todos os membros da equipe, retorna e corta
  embaralhaMao(Mesa1,Mesa2,mao([]),J1,7),
  embaralhaMao(Mesa2,Mesa3,mao([]),J2,7),
  embaralhaMao(Mesa3,Mesa4,mao([]),J3,7),
  embaralhaMao(Mesa4,Mesa5,mao([]),J4,7),
  maosEquipes(Mesa5,J1,J2,J3,J4, equipes(J1,J2,J3,J4)),!.

% funcao que distribui randomicamente 7 pecas da mesa para
% uma mao e retorna uma lista com as pecas da mao e as pecas
% restantes na mesa
embaralhaMao(PMesa,PMesa,Mao,Mao,0). % se mao estiver completa retorna
embaralhaMao([],_, Mao,Mao,_). % se a mesa estiver vazia retorna
embaralhaMao(PMesa,MesaResto,mao(Acc),Mao,Count):-
  length(PMesa,L), % pega a quantidade de pecas restantes na mesa
  random(0,L,PedraIndice), % escolhe aleatoriamente o indice de alguma peca
  nth0(PedraIndice,PMesa,Head), % armazena esta peca em uma variavel Head
  delete(PMesa,Head,Resto), % remove esta peca da mesa
  decr(Count, Ncount), % decrementa o contador de pecas restantes para completar a mao
  embaralhaMao(Resto, MesaResto ,mao([Head|Acc]),Mao,Ncount). % adiciona a peca na mao e chama a funcao novamente
																				  % com a nova mesa como parametro

% distribuir pedras para os jogadores
distribuiPedras(equipes(J1,J2,J3,J4)):-
  % chama a funcao com todas as pedras inicialmente nao atribuidas a jogadores (pecas sobre a mesa)
  B = [(0,0),(0,1),(0,2),(0,3),(0,4),(0,5),(0,6),(1,1),
       (1,2),(1,3),(1,4),(1,5),(1,6),(2,2),(2,3),(2,4),
       (2,5),(2,6),(3,3),(3,4),(3,5),(3,6),(4,4),(4,5),
       (4,6),(5,5),(5,6),(6,6)],
  maosEquipes(B, J1,J2,J3,J4, equipes(J1,J2,J3,J4)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% questao 1/fim %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
