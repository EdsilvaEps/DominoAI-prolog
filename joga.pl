:- use_module(library(lists)).
:- [qualEstado, jogaveis].
% Questao 4
% Defina um programa joga/4 que associa uma mão de pedras e uma mesa a uma nova mesa,
% alterada pela jogada (se possıvel), de uma pedra da mão, e nova mão resultante (valor: 15 %). Exemplo:
%
%  ?- M1 = mesa([(6,6)],[(3,6),(6,6)],[(5,6),(6,6)],[(6,6)]),
%  Mao1 = mao([(6,4),(1,2),(2,5),(0,1),(3,4),(2,2)]),
%  joga(Mao1,M1,Mao2,M2).
%  Mao2 = mao([(1,2),(2,5),(0,1),(3,4),(2,2)])
%
%  M2 = mesa([(4,6),(6,6)],[(3,6),(6,6)],[(5,6),(6,6)],[(6,6)])

% recebe uma mao, uma ponta da mesa (uma lista de pecas), e retorna a mao modificada (ou nao)
% e a ponta modificada (ou nao)

replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]) :-
    I > 0,
    I1 is I - 1,
    replace(T, I1, X, R).

%replace(_, _, [], []).
%replace(O, R, [O|T], [R|T2]) :- replace(O, R, T, T2).
%replace(O, R, [H|T], [H|T2]) :- H \= O, replace(O, R, T, T2).

proximaPonta(0,1).
proximaPonta(1,2).
proximaPonta(2,3).

verificaPecas([(6,6) | _], [], NovaPonta):- % CHECK!
  NovaPonta = [(6,6)].
verificaPecas([(X,Y) | _], [(P1,P2) | PTail], NovaPonta):-
  (X == P1 ->
    append([(Y,X)], [(P1,P2) | PTail], NovaPonta)
    %NovaPonta = [(Y,X) | (P1,P2), PTail]
  ;Y == P1 ->
    append([(X,Y)], [(P1,P2) | PTail], NovaPonta)
    %NovaPonta = [(X,Y) | (P1,P2), PTail]
  ;NovaPonta = [(P1,P2) | PTail]).

% recebe a mao (lista de pecas da mao), a mesa (lista de pontas da mesa ou lista de listas), a ponta
% que estamos verificando (index na lista de pontas) e retorna a nova mesa (lista de pontas)
verificaPontas(Mao, Mesa, PontaAtual,  NovaMesa):-
  proximaPonta(PontaAtual, ProximaPontaIndex), % registra qual será a proxima ponta a ser verificada
  nth0(PontaAtual, Mesa, Ponta), % pega a ponta que verificaremos pelo index
  % chama a funcao verificaPecas para colocar a peca na ponta, se esta combinar
  verificaPecas(Mao, Ponta, NovaPonta),
  % se a nova ponta só possuir a carroca de sena, esta peça deve ser colocada em todas as pontas
  % pois é a peça inicial (CHECK!)
  ((Ponta == [], NovaPonta == [(6,6)]) ->
    NovaMesa = [[(6,6)],[(6,6)],[(6,6)],[(6,6)]]
   % se a nova ponta for diferente da anterior, uma nova peça foi adicionada à ponta e esta
   % deve ser substituida na mesa
  ;Ponta \= NovaPonta ->
    replace(Mesa, PontaAtual, NovaPonta, NovaMesa)
  % se nenhuma das condicoes anteriores foi satisfeita, então esta ponta não recebeu nova peca
  % e precisamos verificar a proxima ponta
  ;verificaPontas(Mao, Mesa, ProximaPontaIndex, NovaMesa)).

joga(mao(Mao), mesa(P1,P2,P3,P4), NovaMao, NovaMesa):-
  E = [P1,P2,P3,P4], % coloca as listas de pontas em uma lista para processamento
  qualEstado(mesa(P1,P2,P3,P4), Estado), % pega o estado da mesa
  jogaveis(mao(Mao), Estado, Jogaveis), % pega as pecas jogaveis desta mao
  length(Jogaveis, L),
  % senao houverem pecas jogaveis, tudo sera retornado como esta
  (L == 0 ->
    NovaMesa = mesa(P1,P2,P3,P4), NovaMao = mao(Mao)
  % senao deletamos a primeira peca jogavel da mao
  ;nth0(0,Jogaveis, Jogavel),
   delete(Mao, Jogavel, NMao),
  % e a colocamos na mesa usando a funcao verificaPontas
   verificaPontas([Jogavel], E, 0, [NP1,NP2,NP3,NP4]),
  % em seguida colocamos o resultado da funcao dentro dos objetos pertinentes e retornamos
   NovaMao = mao(NMao), NovaMesa = mesa(NP1,NP2,NP3,NP4)).


test:-
  M1 = mesa([],[],[],[]),
  %Mao1 = mao([(6,4),(2,6),(0,1),(6,6)]),
  %M1 = mesa([(6,6)],[(3,6),(6,6)],[(5,6),(6,6)],[(6,6)]),
  Mao1 = mao([(6,6),(1,2),(6,4),(0,1),(3,4),(6,2)]),
  %joga(Mao1,M1,Mao2,M2,P),


  %M1 = mesa([(6,6)],[(6,6)],[(6,6)],[(6,6)]),

  joga(Mao1,M1,Mao2,M2),
  write(Mao2),write(', '),write(M2),nl,
  joga(Mao2,M2,Mao3,M3),
  write(Mao3),write(', '),write(M3),nl,
  joga(Mao3,M3,Mao4,M4),
  write(Mao4),write(', '),write(M4).
