:- module(datagenerator,[data/3, data/4]).

:- use_module(library(sets),[del_element/3]).
:- use_module(library(between)).
:- use_module(library(lists)).
:- use_module(library(file_systems),[file_members_of_directory/3]).
:- use_module(library(random),[random_member/2]).

include_type_definition(_-FullPath) :- consult(FullPath).

:- file_members_of_directory('./SICStusPrologFuzzer/','*.pl',FileList),
   maplist(include_type_definition,FileList). 

/* Erzeugung der Daten unter der Verwendung der generate/2 Funktion aus dem Fuzzer */
                                
data(string,X, Data) :-
        generate(list(list(integer([between(33,126)])),[size:X]),Data).

data(atom,X, Data) :-
        generate(list(atom([alph]),[size:X]),Data).

data(ordIdx,X,Data) :-
        numlist(1,X, Data).
        
data(unordIdx,X,Data) :-
	numlist(1,X,H),
	shuffle(X,H,[],Data).
	
data(idxrev,X,Data) :-
	numlist(1,X,H),
	reverse(H,Data).

data(integer,X,Data) :-
        generate(list(integer([]),[size:X]),Data).
        
/* Für die random Auswahl von X Integern aus einer Liste Helper*/
data(Keys,Count, Data) :-
	shuffle(Count,Keys,[],Data).

shuffle(0,_,Values,Values).

shuffle(X,H,Acc,Data) :-
	random_member(Value,H),
        SizeNew is X - 1,
        del_element(Value,H,HNew),
        shuffle(SizeNew,HNew,[Value|Acc],Data).
        
/* für den Zugriff auf die Elemente von Hinten*/  
data(ordIdx,X,Count,Keys) :-
	H is (X - (Count - 1)),
	numlist(H,X,List),
	reverse(List, Keys).
	
	
	
	
	
