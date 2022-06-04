:- module(get,[analyseGet/8,analyseGet/9]).

:- use_module(timeAndStorage).
:- use_module(datastructures).
:- use_module(insert).
:- use_module(datagenerator).
:- use_module(library(random),[getrand/1,setrand/1]).

%With a given Seed
analyseGet(Measurement,DatastructureType,KeyType,ValueType,Size,ToGet,AccessType,Seed,Result):-  
	setrand(Seed), 
	format('~n Used Seed for Get is ~w~n',[Seed]),      
	datagenerator(ValueType,KeyType,Size,Keys,Values),
	setrand(Seed), 
	datagenerator(AccessType,Keys,ToGet,GetKeys),
	analyseGetACC(Measurement,DatastructureType,Keys,Values,GetKeys,10,[],Result).
	
%Without a given Seed
analyseGet(Measurement,DatastructureType,KeyType,ValueType,Size,ToGet,AccessType,Result):-  
	getrand(Seed), 
	format('~n Used Seed for Get is ~w~n',[Seed]),      
	datagenerator(ValueType,KeyType,Size,Keys,Values),
	setrand(Seed), 
	datagenerator(AccessType,Keys,ToGet,GetKeys),
	analyseGetACC(Measurement,DatastructureType,Keys,Values,GetKeys,10,[],Result).
        
analyseGetACC(_,_,_,_,_,0,Result,Result):- !.
        
analyseGetACC(Measurement,DatastructureType,Keys,Values,GetKeys,X,Acc,Result):-
        insert(DatastructureType,time,Keys,Values,Datastructure,_Time),
        get(DatastructureType,Measurement,GetKeys,Datastructure,R,_Back),
        clean(DatastructureType,Keys),
        print(.),
        XNew is X - 1,
        analyseGetACC(Measurement,DatastructureType,Keys,Values,GetKeys,XNew,[R|Acc],Result). 
        
get(assert,Measurement,Keys,_Assert,Result,_Back) :-
        measurement(Measurement,Result,get_Assert(Keys)).
        
get(bb,Measurement,Keys,_BB,Result,_Back) :-
        measurement(Measurement,Result,get_BB(Keys)).

get(assoc,Measurement,Keys,Assoc,Result,_Back) :-
        measurement(Measurement,Result,get_Assoc(Keys,Assoc)).

get(avl,Measurement,Keys,Avl,Result,_Back) :-
        measurement(Measurement,Result,get_AVL(Keys,Avl)).

get(mutdict,Measurement,Keys,Mutdict,Result,_Back) :-
        measurement(Measurement,Result,get_Mutdict(Keys,Mutdict)).

get(logarr,Measurement,Keys,Array,Result,_Back) :-
	measurement(Measurement,Result,get_Logarr(Keys,Array)).

get(mutarray,Measurement,Keys,Mutarray,Result,_Back) :-
