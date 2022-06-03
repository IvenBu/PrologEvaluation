:- use_module(get).
:- use_module(insert).
:- use_module(remove).
:- use_module(update).
:- use_module(library(random),[getrand/1,setrand/1]).


  % Datenstrukturen: assert,bb,assoc,avl,mutdict,logarr und  mutarray
  % KeyTypes: ordIdx,unordIdx, idxrev, integer, atom, string.
  % ValueTypes: integer, atom, string
  % StorageTypes:global_stack_used, local_stack_used, trail_used, choice_used, heap,garbage
  % AccessType: random, first, last

/*Die Datenstrukturen logarr und Mutarray können als Schlüssel lediglich die Typen 'ordIdx','unordIdx' und 'idxrev' verwenden.AccessType first und last können lediglich mit ordIdx verwendet werden */


%Einige Verwendungsbeispiele mit kurzen Laufzeiten:

%Bsp. mit der Verwendung eines Seeds.
run_insertTimeSeed(Seed,Assert) :-
        setrand(Seed),
        format('Used Seed is ~w~n',[Seed]),
        set_prolog_flag(gc,off),
        insert_Time(ordIdx,integer,assert,1000,10,Assert).

%run_insertTimeSeed(random(27134,9213,17773,425005073),Assert).


run_insertTime(Assert,BB,AVL,Assoc,Mutdict,Logarr,Mutarray):-
        set_prolog_flag(gc,off),
        insert_Time(ordIdx,integer,assert,1000,10,Assert),
        insert_Time(ordIdx,atom,bb,1000,10,BB),
        insert_Time(ordIdx,string,avl,1000,10,AVL),
        insert_Time(ordIdx,integer,assoc,1000,10,Assoc),
        insert_Time(idxrev,integer,mutdict,1000,10,Mutdict),
        insert_Time(unordIdx,integer,logarr,1000,10,Logarr),
        insert_Time(ordIdx,integer,mutarray,1000,10,Mutarray).

% run_insertTime(Assert,BB,AVL,Assoc,Mutdict,Logarr,Mutarray).

run_insertStorage(Assert,BB,AVL,Assoc,Mutdict,Logarr,Mutarray) :-
        set_prolog_flag(gc,off),
        insert_Storage(ordIdx,atom,assert,1000,10,global_stack_used,Assert),
        insert_Storage(ordIdx,atom,bb,1000,10,local_stack_used,BB),
        insert_Storage(ordIdx,atom,avl,1000,10,trail_used,AVL),
        insert_Storage(ordIdx,atom,assoc,1000,10,choice_used,Assoc),
        insert_Storage(ordIdx,atom,mutdict,1000,10,heap,Mutdict),
        insert_Storage(ordIdx,atom,logarr,1000,10,global_stack_used,Logarr),
        set_prolog_flag(gc,on),
        insert_Storage(ordIdx,atom,mutarray,10000,10,garbage,Mutarray).

% run_insertStorage(Assert,BB,AVL,Assoc,Mutdict,Logarr,Mutarray).

%Das remove Prädikat funktioniert lediglich für die Datenstrukturen assert,bb,avl und mutdict.
run_removeTime(Assert,BB,AVL,Mutdict) :-
        set_prolog_flag(gc,off),
        remove_Time(atom, integer, assert,4000,3000,10,random,Assert),
        remove_Time(integer, string, bb,100,100,10,random,BB),
        remove_Time(string, atom, avl,1000,100,10,random,AVL),
        remove_Time(ordIdx, integer, mutdict,1000,100,10,random,Mutdict).

 % run_removeTime(Assert,BB,AVL,Mutdict).

run_removeStorage(Assert,BB,AVL,Mutdict) :-
        set_prolog_flag(gc,off),
        remove_Storage(atom, integer,assert, 1000,100, 10,random, global_stack_used, Assert),
        remove_Storage(ordIdx, atom,bb, 1000,100, 10,random, global_stack_used, BB),
        remove_Storage(ordIdx, string,avl, 1000,100, 10,random, global_stack_used, AVL),
        remove_Storage(ordIdx, integer,mutdict, 1000,100, 10,random, global_stack_used, Mutdict).

% run_removeStorage(Assert,BB,AVL,Mutdict).


run_getTime(Assert,BB,AVL,Assoc,Mutdict,Logarr,Mutarray) :-
        set_prolog_flag(gc,off),
        get_Time(ordIdx, integer,assert,10000,10,10,random,Assert),
        get_Time(ordIdx, integer,bb,10000,10,10,random,BB),
        get_Time(ordIdx, integer,avl,10000,10,10,random,AVL),
        get_Time(ordIdx, integer,assoc,10000,10,10,random,Assoc),
        get_Time(ordIdx, integer,mutdict,10000,10,10,random,Mutdict),
        get_Time(ordIdx, integer,logarr,10000,10,10,random,Logarr),
        get_Time(ordIdx, integer,mutarray,10000,10,10,random,Mutarray).

% run_getTime(Assert,BB,AVL,Assoc,Mutdict,Logarr,Mutarray).

run_getStorage(Assert,BB,AVL,Assoc,Mutdict,Logarr,Mutarray) :-
        set_prolog_flag(gc,off),
        get_Storage(ordIdx, integer,assert,100,10,10,random,global_stack_used,Assert),
        get_Storage(ordIdx, integer,bb,100,10,10,first,global_stack_used,BB),
        get_Storage(ordIdx, integer,avl,100,10,10,last,global_stack_used,AVL),
        get_Storage(ordIdx, integer,assoc,100,10,10,random,global_stack_used,Assoc),
        get_Storage(ordIdx, integer,mutdict,100,10,10,random,global_stack_used,Mutdict),
        get_Storage(ordIdx, integer,logarr,100,10,10,random,global_stack_used,Logarr),
        get_Storage(ordIdx, integer,mutarray,100,10,10,random,global_stack_used,Mutarray).
                
% run_getStorage(Assert,BB,AVL,Assoc,Mutdict,Logarr,Mutarray).


run_updateTime(Assert,BB,AVL,Assoc,Mutdict,Logarr,Mutarray) :-
        set_prolog_flag(gc,off),
        update_Time(ordIdx,integer,assert,1000,100,10,first,Assert),
        update_Time(ordIdx,integer,bb,1000,100,10,first,BB),
        update_Time(ordIdx,integer,avl,1000,100,10,first,AVL),
        update_Time(ordIdx,integer,assoc,1000,100,10,first,Assoc),
        update_Time(ordIdx,integer,mutdict,1000,100,10,first,Mutdict),
        update_Time(ordIdx,integer,logarr,1000,100,10,first,Logarr),
        update_Time(ordIdx,integer,mutarray,1000,100,10,first,Mutarray).

% run_updateTime(Assert,BB,AVL,Assoc,Mutdict,Logarr,Mutarray).

run_updateStorage(Assert,BB,AVL,Assoc,Mutdict,Logarr,Mutarray) :-
        update_Storage(ordIdx, integer,assert, 1000,100, 10,random, global_stack_used, Assert),
        update_Storage(ordIdx, integer,bb, 1000,100, 10,random, global_stack_used, BB),
        update_Storage(ordIdx, integer,avl, 1000,100, 10,random, global_stack_used, AVL),
        update_Storage(ordIdx, integer,assoc, 1000,100, 10,random, global_stack_used, Assoc),
        update_Storage(ordIdx, integer,mutdict, 1000,100, 10,random, global_stack_used, Mutdict),
        update_Storage(ordIdx, integer,logarr, 1000,100, 10,random, global_stack_used, Logarr),
        update_Storage(ordIdx, integer,mutarray, 1000,100, 10,random, global_stack_used, Mutarray).

%run_updateStorage(Assert,BB,AVL,Assoc,Mutdict,Logarr,Mutarray).

