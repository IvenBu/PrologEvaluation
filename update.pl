:- module(update,[analyseUpdate/8,analyseUpdate/9]).

:- use_module(timeAndStorage).
:- use_module(datastructures).
:- use_module(insert).
:- use_module(datagenerator).
:- use_module(library(random),[getrand/1,setrand/1]).


%With a given Seed 
analyseUpdate(Measurement,DatastructureType,KeyType,ValueType,Size,ToUpdate,AccessType,Seed,Result):-      
        setrand(Seed),
        format('~n Used Seed for Update is ~w~n',[Seed]), 
	datagenerator(ValueType,KeyType,Size,Keys,Values),
	setrand(Seed), 
	datagenerator(AccessType,Keys,ToUpdate,UpdateKeys),
	setrand(Seed), 
	data(ValueType,ToUpdate,UpdateValues),
	analyseUpdateACC(Measurement,DatastructureType,Keys,Values,UpdateKeys,UpdateValues,10,[],Result).
	
%Without a given Seed 
analyseUpdate(Measurement,DatastructureType,KeyType,ValueType,Size,ToUpdate,AccessType,Result):-      
        getrand(Seed),
        format('~n Used Seed for Update is ~w~n',[Seed]), 
	datagenerator(ValueType,KeyType,Size,Keys,Values),
	setrand(Seed), 
	datagenerator(AccessType,Keys,ToUpdate,UpdateKeys),
	setrand(Seed), 
	data(ValueType,ToUpdate,UpdateValues),
	analyseUpdateACC(Measurement,DatastructureType,Keys,Values,UpdateKeys,UpdateValues,10,[],Result).
	
analyseUpdateACC(_,_,_,_,_,_,0,R,R):- !.	
	
analyseUpdateACC(Measurement,DatastructureType,Keys,Values,UpdateKeys,UpdateValues,X,Acc,Result):-
	insert(DatastructureType,time,Keys,Values,Datastructure,_Time),
	update(DatastructureType,Measurement,UpdateKeys,UpdateValues,Datastructure,R,_Back),
	clean(DatastructureType,Keys),
	print(.),
	XNew is X - 1,
	analyseUpdateACC(Measurement,DatastructureType,Keys,Values,UpdateKeys,UpdateValues,XNew,[R|Acc],Result).
	   		
update(assert,Measurement,Keys,Values,_Assert,Result,_Back) :-
        measurement(Measurement,Result,update_Assert(Keys,Values)).
        
update(bb,Measurement,Keys,Values,_BB,Result,_Back) :-
        measurement(Measurement,Result,update_BB(Keys,Values)).

update(assoc,Measurement,Keys,Values,Assoc,Result,Back) :-
        measurement(Measurement,Result,update_Assoc(Keys,Values,Assoc,Back)).
        
update(avl,Measurement,Keys,Values,Avl,Result,Back) :-
        measurement(Measurement,Result,update_AVL(Keys,Values,Avl,Back)).
           
update(mutdict,Measurement,Keys,Values,Mutdict,Result,Back) :-
        measurement(Measurement,Result,update_Mutdict(Keys,Values,Mutdict,Back)).       
               
update(logarr,Measurement,Keys,Values,Array,Result,Back) :-
	measurement(Measurement,Result,update_Logarr(Keys,Values,Array,Back)). 


update(mutarray,Measurement,Keys,Values,Mutarray,Result,Back) :-
	measurement(Measurement,Result,update_Mutarray(Keys,Values,Mutarray,Back)).

