:- use_module(insert).
:- use_module(remove).
:- use_module(get).
:- use_module(update).
:- use_module(library(random),[getrand/1,setrand/1]).

  % Datenstrukturen: assert,bb,assoc,avl,mutdict,logarr und  mutarray
  % KeyTypes: ordIdx,integer, atom, string.
  % ValueTypes: integer, atom, string
  % StorageTypes:global_stack_used, local_stack_used, trail_used, choice_used, heap,garbage
  % AccessType: random, first, last

/*Es wurden für die Beispiele bewusst kleine Datenmengen verwendet um die Laufzeit gering zu halten. Die Aussagekraft der Ergebnisse ist aufgrund dessen beschränkt*/

test(X,Seed,Result1,Result2,Result3,Result4) :-
	set_prolog_flag(gc,on),
	analyseInsert(time,X,ordIdx,integer,10,Seed,Result1),
	analyseGet(global_stack_used,X,ordIdx,integer,100,10,random,Seed,Result2),
	analyseRemove(time,X,ordIdx,integer,100,10,random,Seed,Result3),
      	analyseUpdate(heap,X,ordIdx,integer,100,10,random,Seed,Result4).

% test(X,random(26010,5548,23873,425005073),Result1,Result2,Result3,Result4).

testNoSeed(X,R1,R2,R3,R4):-
	set_prolog_flag(gc,on),
	analyseInsert(time,X,ordIdx,integer,100,R1),
	analyseGet(time,X,ordIdx,atom,100,10,random,R2),
	analyseRemove(time,X,ordIdx,string,100,10,random,R3),
      	analyseUpdate(time,X,ordIdx,integer,100,10,random,R4).

% testNoSeed(X,R1,R2,R3,R4).

testAgain(R1,R2,R3,R4):-
	set_prolog_flag(gc,on),
	analyseInsert(time,assert,string,integer,100,R1),
	analyseGet(time,avl,atom,atom,100,10,last,R2),
	analyseRemove(time,mutdict,string,string,10000,1000,random,R3),
      	analyseUpdate(time,assoc,ordIdx,integer,100,10,random,R4).

%testAgain(R1,R2,R3,R4).
