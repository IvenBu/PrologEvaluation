:- module(remove,[analyseRemove/8,analyseRemove/9]).

:- use_module(timeAndStorage).
:- use_module(datastructures).
:- use_module(library(sets),[subtract/3]).
:- use_module(datagenerator).
:- use_module(insert).
:- use_module(library(random),[getrand/1,setrand/1]).
:- use_module(library(lists)).



%With a given Seed
analyseRemove(Measurement,DatastructureType,KeyType,ValueType,Size,ToRemove,AccessType,Seed,Result):-
	setrand(Seed), 
	format('~n Used Seed for Remove is ~w~n',[Seed]),  
	datagenerator(ValueType,KeyType,Size,Keys,Values),
	setrand(Seed), 
	datagenerator(AccessType,Keys,ToRemove,RemoveKeys),
	analyseRemoveACC(Measurement,DatastructureType,Keys,Values,RemoveKeys,10,[],Result).
	
%Without a given Seed
analyseRemove(Measurement,DatastructureType,KeyType,ValueType,Size,ToRemove,AccessType,Result):-
	getrand(Seed), 
	format('~n Used Seed for Remove is ~w~n',[Seed]),  
	datagenerator(ValueType,KeyType,Size,Keys,Values),
	setrand(Seed), 
	datagenerator(AccessType,Keys,ToRemove,RemoveKeys),
	analyseRemoveACC(Measurement,DatastructureType,Keys,Values,RemoveKeys,10,[],Result).
     
analyseRemoveACC(_,_,_,_,_,0,Result,Result):- !.   

analyseRemoveACC(Measurement,DatastructureType,Keys,Values,RemoveKeys,X,Acc,Result):-     
	insert(DatastructureType,time,Keys,Values,Datastructure,_Time),
	remove(DatastructureType,Measurement,RemoveKeys,Datastructure,R),
	subtract(Keys,RemoveKeys,H),
        clean(DatastructureType,H),
        print(.),
        XNew is X - 1,
	analyseRemoveACC(Measurement,DatastructureType,Keys,Values,RemoveKeys,XNew,[R|Acc],Result).   

remove(assert,Measurement,Keys,_Assert,Result) :-			
        measurement(Measurement,Result,remove_Assert(Keys)).
        
remove(bb,Measurement,Keys,_BB,Result) :-
	remove_dups(Keys,Pruned),
        measurement(Measurement,Result,remove_BB(Pruned)).
        
remove(avl,Measurement,Keys,Avl,Result) :-
        measurement(Measurement,Result,remove_AVL(Keys,Avl)).

remove(mutdict,Measurement,Keys,Mutdict,Result) :-
        measurement(Measurement,Result,remove_Mutdict(Keys,Mutdict)).

remove(logarr,_,_,_,na).
remove(mutarray,_,_,_,na).
remove(assoc,_,_,_,na).


