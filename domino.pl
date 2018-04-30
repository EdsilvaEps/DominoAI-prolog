:- use_module(library(lists)).

:-[qualEstado,distribui,jogaveis,terminouJogo,joga].

%terminou(pontos(P1,P2,P3,P4) Vencedor):-
terminou(Vencedor):-
    write("\nTERMINOU O JOGO! "),write(Vencedor),write(" EH O VENCEDOR!"),nl.
    %write("\n\n"),write("Jogador1 - "),write(P1),write("\n"),
    %write("Jogador2 - "),write(P2),nl,
    %write("Jogador3 - "),write(P3),nl,
    %write("Jogador4 - "),write(P4),nl.

proximoJogador(0, 1).
proximoJogador(1, 2).
proximoJogador(2, 3).
proximoJogador(3, 0).

qualDupla(0,0).
qualDupla(1,1).
qualDupla(2,0).
qualDupla(3,1).

somaMesa([], Aux, Aux).
somaMesa([(X,X)|T],Aux,Soma):-
  NovoAux is Aux + X + X,
  somaMesa(T, NovoAux, Soma).
somaMesa([X|T], Aux, Soma):-
  NovoAux is Aux + X,
  somaMesa(T, NovoAux, Soma).


contaPts(JogadorIndex, [dupla(A),dupla(B)], estado(P1,P2,P3,P4), NovoPlacar):-
  Placar = [A,B], E = [P1,P2,P3,P4],
  somaMesa(E,0,Soma),
  Resto is Soma rem 5,
  (Resto == 0 ->
    qualDupla(JogadorIndex, DuplaIndex),
    nth0(DuplaIndex, Placar, DuplaPts),
    NDuplaPts is DuplaPts + Soma,
    NDupla = dupla(NDuplaPts),
    replace([dupla(A),dupla(B)], DuplaIndex, NDupla, NovoPlacar),
    write("Dupla "),write(DuplaIndex),write(" marcou "),write(Soma),write(" pts"),nl,
    write(NovoPlacar),nl
  ;NovoPlacar = [dupla(A),dupla(B)]).


jogaEConta(JogadorIndex, equipes(J1,J2,J3,J4), Mesa, Placar,  NovaEquipe, NovaMesa, NovoPlacar):-
  E = [J1,J2,J3,J4],
  nth0(JogadorIndex, E, Mao),
  joga(Mao, Mesa, NovaMao, NovaMesa),
  replace(E, JogadorIndex, NovaMao, [N1,N2,N3,N4]),
  NovaEquipe = equipes(N1,N2,N3,N4),
  (Mao == NovaMao ->
    write('Jogador '),write(JogadorIndex),write(' passou'),nl,nl,
    NovoPlacar = Placar
  ;qualEstado(NovaMesa,Q),
   write('Jogador '),write(JogadorIndex),write(' jogou'),nl,
   contaPts(JogadorIndex, Placar, Q, NovoPlacar),
   %NovoPlacar = Placar,
   write('Nova Mesa é '),write(Q),nl,nl).



move(_, equipes(J1,J2,J3,J4), Mesa, _, true, _, _, _, _, _):-
  terminouJogo(J1,J2,J3,J4,Mesa, _, Vencedor),
  terminou(Vencedor).

move(JogadorIndex, Equipes, Mesa, Placar, false, ProxJogadorIndex, NovaEquipe, NovaMesa, NovoPlacar, NovoTerminou):-
  proximoJogador(JogadorIndex, ProxJogadorIndex),
  jogaEConta(JogadorIndex, Equipes, Mesa, Placar, equipes(N1,N2,N3,N4), NovaMesa, NovoPlacar),
  terminouJogo(N1,N2,N3,N4,NovaMesa, NovoTerminou,_),
  NovaEquipe = equipes(N1,N2,N3,N4).

fazJogada(Jogador, Equipes, Mesa, Placar, true):-
  write('Jogo terminou'),nl,
  move(Jogador, Equipes, Mesa, Placar, true, _, _, _, _, _).
fazJogada(Jogador, Equipes, Mesa, Placar, T):-
  move(Jogador, Equipes, Mesa, Placar, T, ProxJogador, NovaEquipe, NovaMesa, NovoPlacar, Terminou),
  write('Terminou? '),write(Terminou),nl,
  write('Proximo: jogador '),write(ProxJogador),nl,
  %write('Nova Mesa é '),write(NovaMesa),nl,
  %read(_),
  write(NovaEquipe),write('-'),nl,
  %move(ProxJogador, NovaEquipe, NovaMesa, ProxJogador2, NovaEquipe2, NovaMesa2, Terminou),
  %write(NovaEquipe2),write('-'),write(NovaMesa2),nl.

  fazJogada(ProxJogador, NovaEquipe, NovaMesa, NovoPlacar, Terminou).






play:-


%%%% test env %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %J1 = mao([(2,3),(0,5),(2,4),(0,4),(0,2),(0,6),(6,6)]),

  %J2 = mao([(3,5),(4,4),(1,2),(2,5),(3,4),(5,6),(1,5)]),

  %J3 = mao([(1,6),(1,4),(4,6),(0,3),(2,6),(0,0),(3,6)]),

  %J4 = mao([(0,1),(1,3),(3,3),(2,2),(4,5),(5,5),(1,1)]),

  %Jogadores = equipes(J1,J2,J3,J4),

  %Mesa = mesa([(6,6)],[(6,6)],[(6,6)],[(6,6)]),

  %Jogadores = equipes(mao([(0,1),(0,6)]),mao([(0,0),(0,4),(2,2)]),mao([(4,6),(2,6)]),mao([(0,5),(3,3),(2,5)])),
  %Mesa =  mesa([(4,4),(4,1),(1,1),(1,5),(5,3),(3,4),(4,2),(2,1),(1,6),(6,6)],[(1,3),(3,0),(0,2),(2,3),(3,6),(6,6)],[(4,5),(5,5),(5,6),(6,6)],[(6,6)]),

  %jogaEConta(2,Jogadores,Mesa,NJogadores,NovaMesa),
  %write(NJogadores),nl,write(NovaMesa).


  %jogaEConta(j1,J1, 0, Mesa, NJ1, Pontos2, Mesa1),
  %jogaEConta(j1,NJ1, Pontos2, Mesa1, _, _, _).

  %Placar = [dupla(0),dupla(0)],
  %E = estado((6,6),3,5,(6,6)),

  %contaPts(1, Placar, E, NovoPlacar),
  %write(NovoPlacar).

  %somaMesa([(6,6),(6,6),(6,6),(6,6)],0,Soma),
  %write(Soma).

  %%%% test env/fim %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  %% comandos de jogo %%%%%


  distribuiPedras(Equipes),
  Mesa = mesa([],[],[],[]),
  Placar = [dupla(0),dupla(0)],

  fazJogada(0, Equipes,Mesa,Placar, false).
