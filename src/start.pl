:- dynamic(startGame/1).
:- include('player.pl').
:- include('map.pl').
% :- include('quest.pl').
:- include('fishing.pl').
:- include('ranching.pl').
:- include('marketplace.pl').
:- include('move.pl').
:- include('help.pl').


startGame(false).

start :-
    retract(startGame(false)), !,
    asserta(startGame(true)),

    write(')>=>        >=> >=======> >=>           >=>        >===>      >=>       >=> >=======>'), nl,
    write('>=>        >=> >=>       >=>        >=>   >=>   >=>    >=>   >> >=>   >>=> >=>       '), nl,
    write('>=>   >>   >=> >=>       >=>       >=>        >=>        >=> >=> >=> > >=> >=>       '), nl,
    write('>=>  >=>   >=> >=====>   >=>       >=>        >=>        >=> >=>  >=>  >=> >=====>   '), nl,
    write('>=> >> >=> >=> >=>       >=>       >=>        >=>        >=> >=>   >>  >=> >=>       '), nl,
    write('>> >>    >===> >=>       >=>        >=>   >=>   >=>     >=>  >=>       >=> >=>       '), nl,
    write('>=>        >=> >=======> >=======>    >===>       >===>      >=>       >=> >=======> '), nl,

    write('                         >===>>=====>     >===>      '), nl,
    write('                              >=>       >=>    >=>   '), nl,
    write('                              >=>     >=>        >=> '), nl,
    write('                              >=>     >=>        >=> '), nl,
    write('                              >=>     >=>        >=> '), nl,     
    write('                              >=>       >=>     >=>  '), nl, 
    write('                              >=>         >===>      '), nl,
    
    write('      >>       >======>         >=>          >>       >==>    >=> >=======>'), nl, 
    write('     >>=>      >=>    >=>    >=>   >=>      >>=>      >> >=>  >=> >=>      '), nl, 
    write('    >> >=>     >=>    >=>   >=>            >> >=>     >=> >=> >=> >=>      '), nl,
    write('   >=>  >=>    >> >==>      >=>           >=>  >=>    >=>  >=>>=> >=====>  '), nl, 
    write('  >=====>>=>   >=>  >=>     >=>          >=====>>=>   >=>   > >=> >=>      '), nl,
    write(' >=>      >=>  >=>    >=>    >=>   >=>  >=>      >=>  >=>    >>=> >=>      '), nl,
    write('>=>        >=> >=>      >=>    >===>   >=>        >=> >=>     >=> >=======>'), nl,

    initPlayer.

start :-
    write('The game has already started. Use \'help.\' to look at available commands!').