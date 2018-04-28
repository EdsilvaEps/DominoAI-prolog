
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% questao 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% questao 2 : Defina um programa qualEstado/2 que associa uma mesa ao estado válido desta mesa.
% Exemplo: ?- qualEstado(mesa([(6,6)],[(3,6),(6,6)],[(5,6),(6,6)],[(6,6)]),E).
%             E = estado((6,6),3,5,(6,6))

% a relacao 'mesa' e uma lista de 4 listas, onde as listas representam as pontas da mesa

% funcao verificaPonta que retorna o ultimo elemento da ponta dada
verificaPonta([], Estado, Estado). % se a lista e vazia retorna
verificaPonta([(X,X)|_], _, Estado):- % se o ultimo elemento da ponta é a carroca de sena retorna a dupla
  verificaPonta([], (X,X), Estado).
verificaPonta([(X,_)|_],_,Estado):- % se nao é carroca retorna o primeiro numero da dupla
  verificaPonta([],X,Estado).


qualEstado(mesa([],[],[],[]),E):- % se a mesa estiver vazia entao retorna um estado vazio
  E = estado(),!.
  %write('E = '), write(E). % por causa da falta de auxiliar no functor qualEstado/2, escrever resultado na tela
qualEstado(mesa(Ponta1, Ponta2, Ponta3, Ponta4), E):-
  % chama o verificaPonta/3 para todas as pontas da mesa dada
  % e guarda cada ponta em uma variavel Px
  verificaPonta(Ponta1,[],P1),
  verificaPonta(Ponta2,[],P2),
  verificaPonta(Ponta3,[],P3),
  verificaPonta(Ponta4,[],P4),
  E = estado(P1,P2,P3,P4),!.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% questao 2/fim %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test2:-
  qualEstado(mesa([(6,6)],[(4,4),(3,6),(6,6)],[(5,6),(6,6)],[(6,6)]),E),
  write(E).
