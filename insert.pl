:- module(insert,[insert/6,analyseInsert/6,analyseInsert/7]).

:- use_module(library(mutarray)).
:- use_module(library(logarr)).
:- use_module(library(mutdict)).
:- use_module(timeAndStorage).
:- use_module(datastructures).
:- use_module(datagenerator).
:- use_module(library(random),[getrand/1,setrand/1]).

%With a given Seed
analyseInsert(Measurement,DatastructureType,KeyType,ValueType,Size,Seed,Result):-    
	setrand(Seed),
	format('~n Used Seed for Insert is ~w~n',[Seed]),
	datagenerator(ValueType,KeyType,Size,Keys,Values),
	analyseInsertACC(Measurement,DatastructureType,Keys,Values,10,[],Result).

%Without a given Seed
analyseInsert(Measurement,DatastructureType,KeyType,ValueType,Size,Result):-    
	getrand(Seed),
	format('~n Used Seed for Insert is ~w~n',[Seed]),
	datagenerator(ValueType,KeyType,Size,Keys,Values),
	analyseInsertACC(Measurement,DatastructureType,Keys,Values,10,[],Result).

analyseInsertACC(_,_,_,_,0,Result,Result):- !.

analyseInsertACC(Measurement,DatastructureType,Keys,Values,X,Acc,Result):-
	insert(DatastructureType,Measurement,Keys,Values,_,R),
	clean(DatastructureType,Keys),
	print(.),
	XNew is X - 1,
	analyseInsertACC(Measurement,DatastructureType,Keys,Values,XNew,[R|Acc],Result).
	
insert(assert,Measurement,Keys,Values,_Back,Result) :-
        measurement(Measurement,Result,insert_Assert(Keys,Values)).

insert(bb,Measurement,Keys,Values,_Back,Result) :-
        measurement(Measurement,Result,insert_BB(Keys,Values)).

insert(avl,Measurement,Keys,Values,Back,Result) :-
        measurement(Measurement,Result,insert_AVL(Keys,Values,empty,Back)).

insert(mutdict,Measurement,Keys,Values,Back,Result) :-
        new_mutdict(Mutdict),
        measurement(Measurement,Result,insert_Mutdict(Keys,Values,Mutdict,Back)).

insert(logarr,Measurement,Keys,Values,Back,Result) :-
	new_array(Array),
	measurement(Measurement,Result,insert_Logarr(Keys,Values, Array,Back)).

insert(mutarray,Measurement,Keys,Values,Back,Result) :-
	length(Keys,X),
	new_mutarray(Mutarray,X),
	measurement(Measurement,Result,insert_Mutarray(Keys,Values,Mutarray,Back)).

insert(assoc,Measurement,Keys,Values,Back,Result) :-
        measurement(Measurement,Result,insert_Assoc(Keys,Values,assoc,Back)).
	



