:- use_module(library(lists)).

:-[qualEstado,distribui,jogaveis,terminouJogo,joga].


jogaEConta(Jogador,Mao1, Pontos1, Mesa1, Mao2, Pontos2, Mesa2):-
  joga(Mao1,Mesa1,Mao2,Mesa2,P),
  (Mesa1 = Mesa2 -> write(Jogador),write(" passou"),write('\n\n')
  ;Pontos2 is Pontos1 + P,
   write(Jogador),write(" fez "),write(P),write(" pontos - "),write(Jogador),write(" tem "),write(Pontos2),write(" pontos."),
   write('\n'),write(Mao2),write('\n'),write(Mesa2),write('\n\n')).


terminou(pontos(P1,P2,P3,P4), Vencedor):-
    write("\nTERMINOU O JOGO! "),write(Vencedor),write(" EH O VENCEDOR!"),
    write("\n\n"),write("Jogador1 - "),write(P1),write("\n"),
    write("Jogador2 - "),write(P2),nl,
    write("Jogador3 - "),write(P3),nl,
    write("Jogador4 - "),write(P4),nl.




%jogaRodada(equipes(J1,J2,J3,J4), pontos(P1,P2,P3,P4), Mesa1):-
%  jogaEConta(jogador1,J1,P1,Mesa1,NJ1,NP1,Mesa2),
%  jogaEConta(jogador2,J2,P2,Mesa2,NJ2,NP2,Mesa3),
%  jogaEConta(jogador3,J3,P3,Mesa3,NJ3,NP3,Mesa4),
%  jogaEConta(jogador4,J4,P4,Mesa4,NJ4,NP4,NovaMesa),
%  read(_),
%  jogaRodada(equipes(NJ1,NJ2,NJ3,NJ4), pontos(NP1,NP2,NP3,NP4),NovaMesa).

move(jogador1 , equipes(J1,J2,J3,J4), pontos(P1,P2,P3,P4), Mesa1, jogador2 , E , P , Mesa2, Terminou):-
  jogaEConta(jogador1, J1, P1, Mesa1, NJ1, NP1, Mesa2),
  terminouJogo(mao(NJ1),mao(J2),mao(J3),mao(J4),Mesa2, Terminou, _),
  E = equipes(NJ1,J2,J3,J4), P = pontos(NP1,P2,P3,P4).

move(jogador2 , equipes(J1,J2,J3,J4), pontos(P1,P2,P3,P4), Mesa1, jogador3 , E , P , Mesa2, Terminou):-
  jogaEConta(jogador2, J2, P2, Mesa1, NJ2, NP2, Mesa2),
  terminouJogo(mao(J1),mao(NJ2),mao(J3),mao(J4),Mesa2, Terminou, _),
  E = equipes(J1,NJ2,J3,J4), P = pontos(P1,NP2,P3,P4).

move(jogador3 , equipes(J1,J2,J3,J4), pontos(P1,P2,P3,P4), Mesa1, jogador4 , E , P , Mesa2, Terminou):-
  jogaEConta(jogador3, J3, P3, Mesa1, NJ3, NP3, Mesa2),
  terminouJogo(mao(J1),mao(J2),mao(NJ3),mao(J4),Mesa2, Terminou, _),
  E = equipes(J1,J2,NJ3,J4), P = pontos(P1,P2,NP3,P4).

move(jogador4 , equipes(J1,J2,J3,J4), pontos(P1,P2,P3,P4), Mesa1, jogador1 , E , P , Mesa2, Terminou):-
  jogaEConta(jogador4, J4, P4, Mesa1, NJ4, NP4, Mesa2),
  terminouJogo(mao(J1),mao(J2),mao(J3),mao(NJ4),Mesa2, Terminou, _),
  E = equipes(J1,J2,J3,NJ4), P = pontos(P1,P2,P3,NP4).


fazJogada(_,equipes(J1,J2,J3,J4), pontos(P1,P2,P3,P4), Mesa, true):-
  terminouJogo(mao(J1),mao(J2),mao(J3),mao(J4),Mesa, _, Vencedor),
  terminou(pontos(P1,P2,P3,P4), Vencedor).

fazJogada(Jogador, Equipes, Placar, Mesa, _) :-
  move(Jogador, Equipes, Placar, Mesa, ProxJogador, Equipes2, Placar2, Mesa2, Terminou),
  fazJogada(ProxJogador, Equipes2, Placar2, Mesa2, Terminou).


play:-
  %Mesa = mesa([],[],[],[]),
  Placar = pontos(0,0,0,0),




  %distribuiPedras(Jogadores),

%%%% test env %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  J1 = mao([(2,3),(0,5),(2,4),(0,4),(0,2),(0,6)]),

  J2 = mao([(3,5),(4,4),(1,2),(2,5),(3,4),(5,6),(1,5)]),

  J3 = mao([(1,6),(1,4),(4,6),(0,3),(2,6),(0,0),(3,6)]),

  J4 = mao([(0,1),(1,3),(3,3),(2,2),(4,5),(5,5),(1,1)]),

  Jogadores = equipes(J1,J2,J3,J4),

  Mesa = mesa([(6,6)],[(6,6)],[(6,6)],[(6,6)]),


  jogaEConta(j1,J1, 0, Mesa, NJ1, Pontos2, Mesa1),
  jogaEConta(j1,NJ1, Pontos2, Mesa1, _, _, _).

  %%%% test env/fim %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


  %terminouJogo(mao(J1),mao(J2),mao(J3),mao(J4),Mesa, Terminou, Vencedor),
  %verificaSeTerminou(Jogadores,Placar,Mesa,Terminou),
  %write(Terminou).
  %fazJogada(jogador1, Jogadores, Placar, Mesa, false).

  %jogaRodada(Jogadores, Placar, Mesa).
  %write(Jogadores).
