:- module(insert,[insert_Time/6,insert_Storage/7,insert/5]).

:- use_module(library(mutarray)).
:- use_module(library(logarr)).
:- use_module(library(mutdict)).
:- use_module(datagenerator).
:- use_module(timeAndStorage).
:- use_module(datastructures).

/*Einfuegen mit Zeitmessung */

insert(assert,Keys, Values, Time, _) :-
        time(Time,insert_Assert(Keys,Values)).

insert(bb,Keys, Values, Time, _) :-
        time(Time,insert_BB(Keys,Values)).
        
insert(assoc,Keys, Values, Time, Back) :-
        time(Time,insert_Assoc(Keys,Values,assoc,Back)).

insert(avl,Keys, Values, Time, Back) :-
        time(Time,insert_AVL(Keys,Values,empty,Back)).

insert(mutdict,Keys, Values, Time, Back) :-
        new_mutdict(MutdictNeu),
        time(Time,insert_Mutdict(Keys,Values,MutdictNeu ,Back)).

insert(logarr,Keys, Values, Time, Back) :-
        new_array(Array),
        time(Time,insert_Logarr(Keys,Values, Array,Back)).
       
insert(mutarray,Keys, Values, Time,Back) :-
        length(Keys,X),
        new_mutarray(MutarrayNeu,X),
        time(Time, insert_Mutarray(Keys,Values, MutarrayNeu,Back)).
        
/*Einfuegen mit Speichermessung */

insert(assert,Keys, Values,StorageType, Storage):-
        storageBytes(StorageType,insert_Assert(Keys,Values),Storage).

insert(bb,Keys, Values,StorageType, Storage):-
        storageBytes(StorageType,insert_BB(Keys,Values),Storage).

insert(assoc,Keys, Values,StorageType, Storage):-
        storageBytes(StorageType,insert_Assoc(Keys,Values,assoc,_),Storage).

insert(avl,Keys, Values,StorageType, Storage):-
        storageBytes(StorageType,insert_AVL(Keys,Values,empty,_),Storage).

insert(mutdict,Keys, Values,StorageType, Storage):-
        new_mutdict(MutdictNeu),
        storageBytes(StorageType,insert_Mutdict(Keys,Values,MutdictNeu,_),Storage).

insert(logarr,Keys, Values,StorageType, Storage):-
        new_array(Array),
        storageBytes(StorageType,insert_Logarr(Keys,Values,Array,_),Storage).

insert(mutarray,Keys, Values,StorageType, Storage):-
        length(Keys,X),
        new_mutarray(MutarrayNeu,X),
        storageBytes(StorageType,insert_Mutarray(Keys,Values,MutarrayNeu,_),Storage).


/* Speicherbenutzung beim Einfügen*/

insert_Storage(KeyType, ValuesType,Datastructure, Size,X, StorageType, Result) :-
        insert_Storage_ACC(KeyType, ValuesType,Datastructure, Size,X, StorageType, [], Result).

insert_Storage_ACC(_,_,_,_,0,_,Result,Result).

insert_Storage_ACC(KeyType, ValueType,Datastructure, Size,X, StorageType, Acc, Result):-
        data(KeyType, Size, Keys),
        data(ValueType, Size, Values),
        insert(Datastructure,Keys, Values, StorageType, Storage),
        clean(Datastructure,Keys),
        print(.),
        XNew is X - 1,
        insert_Storage_ACC(KeyType, ValueType,Datastructure, Size,XNew, StorageType, [Storage|Acc], Result).

insert_Time(KeyType ,ValueType ,Datastructure,Size,X,Result) :-
insert_Time_ACC(KeyType ,ValueType ,Datastructure,Size,X,[],Result).

insert_Time_ACC(_ ,_,_,_,0,Result,Result).

insert_Time_ACC(KeyType ,ValueType ,Datastructure,Size,X,Acc,Result):-
        data(KeyType, Size, Keys),
        data(ValueType, Size, Values),
        insert(Datastructure,Keys, Values, Time,_),
        clean(Datastructure,Keys),
        print(.),
        XNew is X - 1,
        insert_Time_ACC(KeyType ,ValueType ,Datastructure,Size,XNew,[Time|Acc],Result).
              


