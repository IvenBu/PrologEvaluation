:- module(get,[get/4,get_Time/8,get_Storage/9]).
:- use_module(timeAndStorage).
:- use_module(datagenerator).
:- use_module(insert).
:- use_module(datastructures).

/*Prozeduren bzgl. dem Zugriff auf Daten aus den Datenstrukturen */

% Time

get(assert,Keys, _Datastructure, Time):-
        time(Time,get_Assert(Keys)).

get(bb,Keys, _Datastructure, Time):-
        time(Time,get_BB(Keys)).

get(assoc,Keys, Datastructure, Time):-
        time(Time,get_Assoc(Keys,Datastructure)).

get(avl,Keys, Datastructure, Time):-
        time(Time,get_AVL(Keys,Datastructure)).

get(mutdict,Keys, Datastructure, Time):-
        time(Time,get_Mutdict(Keys,Datastructure)).

get(logarr,Keys, Datastructure, Time):-
        time(Time,get_Logarr(Keys,Datastructure)).

get(mutarray,Keys, Datastructure, Time):-
        time(Time,get_Mutarray(Keys,Datastructure)).



get(random,Datastructure,Keys,Count, DatastructureFilled, Time):-
        data(Keys ,Count, KeysGet),
        get(Datastructure,KeysGet, DatastructureFilled, Time).

get(first,Datastructure,_,Count, DatastructureFilled, Time):-
        data(ordIdx,Count,KeysGet),
        get(Datastructure,KeysGet, DatastructureFilled, Time).
        
get(last,Datastructure,Keys,Count, DatastructureFilled, Time):-
        length(Keys,X),
        data(ordIdx,X,Count,KeysGet),
        get(Datastructure,KeysGet,DatastructureFilled, Time).

get_Time(KeyType, ValueType,Datastructure,Size,Count,X,AccessType,Result) :-
       get_Time_ACC(KeyType, ValueType,Datastructure,Size, Count,X,AccessType,[], Result).

get_Time_ACC(_,_,_,_,_,0,_,Result,Result).

get_Time_ACC(KeyType, ValueType,Datastructure,Size, Count,X,AccessType,Acc, Result):-
        data(KeyType, Size, Keys),
        data(ValueType, Size, Values),
        insert(Datastructure,Keys,Values,_,DatastructureFilled),
        get(AccessType,Datastructure,Keys,Count, DatastructureFilled,Time),
        clean(Datastructure,Keys),
        print(.),
        XNew is X - 1,
        get_Time_ACC(KeyType, ValueType,Datastructure,Size, Count,XNew,AccessType,[Time|Acc], Result).



%Storage

get(assert,Keys, _Datastructure,StorageType, Storage):-
        storageBytes(StorageType,get_Assert(Keys),Storage).

get(bb,Keys, _Datastructure,StorageType, Storage):-
        storageBytes(StorageType,get_BB(Keys),Storage).

get(assoc,Keys, Datastructure,StorageType, Storage):-
         storageBytes(StorageType,get_Assoc(Keys,Datastructure),Storage).

get(avl,Keys, Datastructure,StorageType, Storage):-
        storageBytes(StorageType,get_AVL(Keys,Datastructure),Storage).

get(mutdict,Keys, Datastructure,StorageType, Storage):-
        storageBytes(StorageType,get_Mutdict(Keys,Datastructure),Storage).

get(logarr,Keys, Datastructure,StorageType, Storage):-
        storageBytes(StorageType,get_Logarr(Keys,Datastructure),Storage).

get(mutarray,Keys, Datastructure,StorageType, Storage):-
        storageBytes(StorageType,get_Mutarray(Keys,Datastructure),Storage).

get(random,Datastructure,Keys,Count, DatastructureFilled,StorageType, Storage):-
        data(Keys ,Count, KeysGet),
        get(Datastructure,KeysGet, DatastructureFilled,StorageType, Storage).

get(first,Datastructure,_,Count, DatastructureFilled,StorageType, Storage):-
        data(ordIdx,Count,KeysGet),
        get(Datastructure,KeysGet, DatastructureFilled,StorageType, Storage).
        
get(last,Datastructure,Keys,Count, DatastructureFilled,StorageType, Storage):-
        length(Keys,X),
        data(ordIdx,X,Count,KeysGet),
        get(Datastructure,KeysGet, DatastructureFilled,StorageType, Storage).

get_Storage(KeyType, ValueType,Datastructure, Size,Count, X,AccessType, StorageType, Result) :-
        get_Storage_ACC(KeyType, ValueType,Datastructure, Size,Count,X,AccessType, StorageType, [], Result).

get_Storage_ACC(_,_,_,_,_,0,_,_, Result,Result).

get_Storage_ACC(KeyType, ValueType,Datastructure, Size,Count,X,AccessType, StorageType, Acc, Result):-
        data(KeyType, Size, Keys),
        data(ValueType, Size, Values),
        insert(Datastructure,Keys,Values,_,DatastructureFilled),
        get(AccessType,Datastructure,Keys,Count,DatastructureFilled,StorageType,Storage),
        clean(Datastructure,Keys),
        print(.),
        XNew is X - 1,
        get_Storage_ACC(KeyType, ValueType,Datastructure, Size,Count,XNew,AccessType, StorageType, [Storage|Acc], Result).

 
