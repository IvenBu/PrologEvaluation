:- module(datastructures,[insert_Assert/2,remove_Assert/1,get_Assert/1,update_Assert/2,
                          insert_BB/2,remove_BB/1,get_BB/1,update_BB/2,insert_Assoc/4,get_Assoc/2,update_Assoc/4,insert_AVL/4,remove_AVL/2,get_AVL/2,update_AVL/4,insert_Mutdict/4,remove_Mutdict/2,get_Mutdict/2,update_Mutdict/4,insert_Logarr/4,get_Logarr/2, update_Logarr/4,insert_Mutarray/4,get_Mutarray/2,update_Mutarray/4,clean/2,clean/0,deleteBB/1]).

:- use_module(library(plunit)).
:- use_module(library(avl)).
:- use_module(library(assoc)).
:- use_module(library(lists)).
:- use_module(library(mutdict)).
:- use_module(library(mutarray)).
:- use_module(library(logarr)).


/* Einzelne Datenstrukturen mit den für Sie wichtigen Operationen*/

/* Assert und Retract */

insert_Assert([],[]).

insert_Assert([K|K_Rest],[V|V_Rest]) :-
        assert(mapping(K,V)),
        insert_Assert(K_Rest,V_Rest).

remove_Assert([]).

remove_Assert([K|K_Rest]) :-
        retract(mapping(K,_)),
        remove_Assert(K_Rest).

get_Assert([]).

get_Assert([K|K_Rest]) :-
        clause(mapping(K,_),true),
        get_Assert(K_Rest).

update_Assert([],[]).

update_Assert([K|K_Rest],[V|V_Rest]) :-
        retract(mapping(K,_)),
        assert(mapping(K,V)),
        update_Assert(K_Rest,V_Rest).


/* Blackboard*/

insert_BB([],[]).

insert_BB([K|K_Rest],[V|V_Rest]) :-
        bb_put(K,V),
        insert_BB(K_Rest, V_Rest).

remove_BB([]).

remove_BB([K|K_Rest]) :-
        bb_delete(K,_),
        remove_BB(K_Rest).

get_BB([]).

get_BB([K|K_Rest]) :-
        bb_get(K,_),
        get_BB(K_Rest).

update_BB([],[]).

update_BB([K|K_Rest],[V|V_Rest]) :-
        bb_update(K, _OldTerm, V),
        update_BB(K_Rest,V_Rest).


/*Assoc */

insert_Assoc([],[],DataBack,DataBack).

insert_Assoc([K|K_Rest], [V|V_Rest],Assoc, Acc):-
        put_assoc(K,Assoc, V, NeuesAssoc),
        insert_Assoc(K_Rest,V_Rest,NeuesAssoc,Acc).

get_Assoc([],_).

get_Assoc([K|K_Rest],Assoc) :-
        get_assoc(K, Assoc,_),
        get_Assoc(K_Rest,Assoc).

update_Assoc([],[],DataBack,DataBack).

update_Assoc([K|K_Rest],[V|V_Rest],OldAssoc,Acc) :-
        put_assoc(K, OldAssoc, V, NewAssoc),
        update_Assoc(K_Rest,V_Rest, NewAssoc,Acc).


/* AVL*/

insert_AVL([],[],DataBack,DataBack).

insert_AVL([K|K_Rest], [V|V_Rest],AVL, Acc):-
        avl_store(K,AVL, V, NeuerAVL),
        insert_AVL(K_Rest,V_Rest,NeuerAVL,Acc).
  
remove_AVL([],_).

remove_AVL([K|K_Rest],OldAVL) :-
        avl_delete(K,OldAVL,_,NewAVL),
        remove_AVL(K_Rest,NewAVL).

get_AVL([],_).

get_AVL([K|K_Rest],AVL) :-
        avl_fetch(K, AVL, _),
        get_AVL(K_Rest,AVL).

update_AVL([],[],DataBack,DataBack).

update_AVL([K|K_Rest],[V|V_Rest],OldAVL,Acc) :-
        avl_change(K, OldAVL, _, NewAVL, V),
        update_AVL(K_Rest,V_Rest,NewAVL,Acc).


/*Mutdict */
insert_Mutdict([],[],DataBack,DataBack).

insert_Mutdict([K|K_Rest], [V|V_Rest],Mutdict, Acc):-
        mutdict_put(Mutdict,K,V),
        insert_Mutdict(K_Rest,V_Rest,Mutdict,Acc).
  
remove_Mutdict([],_).

remove_Mutdict([K|K_Rest],Mutdict) :-
        mutdict_delete(Mutdict,K),
        remove_Mutdict(K_Rest,Mutdict).

get_Mutdict([],_).

get_Mutdict([K|K_Rest],Mutdict) :-
       mutdict_get(Mutdict, K, _),
       get_Mutdict(K_Rest,Mutdict).

update_Mutdict([],[],DataBack,DataBack).

update_Mutdict([K|K_Rest],[V|V_Rest],Mutdict,Acc):-
        mutdict_update(Mutdict, K, _, V),
        update_Mutdict(K_Rest,V_Rest, Mutdict,Acc).


/* Logarr*/

insert_Logarr([],[],DataBack,DataBack).

insert_Logarr([K|K_Rest], [V|V_Rest],Array, Acc):-
        aset(K,Array,V,NewArray),
        insert_Logarr(K_Rest,V_Rest,NewArray,Acc).

get_Logarr([],_).

get_Logarr([K|K_Rest],Logarr) :-
       aref(K, Logarr, _),
       get_Logarr(K_Rest,Logarr).

update_Logarr([],[],DataBack,DataBack).

update_Logarr([K|K_Rest],[V|V_Rest],OldLogarr,Acc) :-
        aset(K, OldLogarr, V, NewLogarr),
        update_Logarr(K_Rest, V_Rest, NewLogarr,Acc).

/* Mutarray */

insert_Mutarray([],[],DataBack,DataBack).

insert_Mutarray([K|K_Rest], [V|V_Rest],Mutarray, Acc):-
        mutarray_put(Mutarray,K,V),
        insert_Mutarray(K_Rest,V_Rest,Mutarray,Acc).

get_Mutarray([],_).

get_Mutarray([K|K_Rest],MutArray) :-
        mutarray_get(MutArray,K,_),
        get_Mutarray(K_Rest,MutArray).

update_Mutarray([],[],DataBack,DataBack).

update_Mutarray([K|K_Rest],[V|V_Rest],MutArray,Acc) :-
        mutarray_update(MutArray, K, _OldElement, V),
        update_Mutarray(K_Rest,V_Rest, MutArray,Acc).
        
        
/* Manuelles ausführen der GC, entfernen der mit assert hinzugefügten Klauseln, leeren des Blackboards*/

clean :-
        garbage_collect.
        
clean(assert,_) :-
        abolish(mapping/2).

clean(avl,_).
clean(logarr,_).
clean(mutdict,_).
clean(mutarray,_).
clean(assoc,_).

clean(bb,Keys) :-
        deleteBB(Keys).

deleteBB([]).

deleteBB([K|S]) :-
        bb_delete(K,_),
        deleteBB(S).


