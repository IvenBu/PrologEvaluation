:- module(remove,[remove/4,remove_Time/7,remove_Time/8,remove_Storage/9]).

:- use_module(timeAndStorage).
:- use_module(datagenerator).
:- use_module(insert).
:- use_module(datastructures).
:- use_module(library(sets),[subtract/3]).
:- use_module(library(lists)).

/* löschen der Daten*/
remove(assert,Keys,_Datastructure,Time):-
        time(Time,remove_Assert(Keys)).

remove(bb,Keys,_Datastructure,Time):-
	remove_dups(Keys, Pruned),
        time(Time,remove_BB(Pruned)).

remove(avl,Keys,Datastructure,Time):-
        time(Time,remove_AVL(Keys,Datastructure)).

remove(mutdict,Keys,Datastructure,Time):-
        time(Time,remove_Mutdict(Keys,Datastructure)).


%remove funktioniert nicht für die Datenstrukturen assoc, loggar und mutarray

remove(random,Datastructure,Keys,Count, DatastructureFilled,KeysRemove,Time):-
        data(Keys,Count, KeysRemove),
        remove(Datastructure,KeysRemove, DatastructureFilled, Time).

remove(first,Datastructure,_,Count, DatastructureFilled,KeysRemove,Time):-
        data(ordIdx, Count, KeysRemove),
        remove(Datastructure,KeysRemove, DatastructureFilled, Time).
        
remove(last,Datastructure,Keys,Count, DatastructureFilled,KeysRemove,Time):-
        length(Keys,X),
        data(ordIdx,X,Count,KeysRemove),
        remove(Datastructure,KeysRemove, DatastructureFilled, Time).

remove_Time(KeyType, ValueType,Datastructure,Size,Count,X,AccessType,Result) :-
       remove_Time_ACC(KeyType, ValueType,Datastructure,Size, Count,X,AccessType,[], Result).

remove_Time_ACC(_,_,_,_,_,0,_,Result,Result).

remove_Time_ACC(KeyType, ValueType,Datastructure,Size, Count,X,AccessType,Acc, Result):-
        data(KeyType, Size, Keys),
        data(ValueType, Size, Values),
        insert(Datastructure,Keys,Values,_,DatastructureFilled),
        remove(AccessType,Datastructure,Keys,Count,DatastructureFilled,RemovedKeys,Time),
        subtract(Keys,RemovedKeys,R),
        clean(Datastructure,R),
        print(.),
        XNew is X - 1,
        remove_Time_ACC(KeyType, ValueType,Datastructure,Size, Count,XNew,AccessType,[Time|Acc], Result).

%Remove mit Speichermessung

remove_Storage(KeyType, ValueType,Datastructure, Size,Count, X,AccessType, StorageType, Result) :-
        remove_Storage_ACC(KeyType, ValueType,Datastructure, Size,Count,X,AccessType, StorageType, [], Result).

remove_Storage_ACC(_,_,_,_,_,0,_,_, Result,Result).

remove_Storage_ACC(KeyType, ValueType,Datastructure, Size,Count,X,AccessType, StorageType, Acc, Result):-
        data(KeyType, Size, Keys),
        data(ValueType, Size, Values),
        insert(Datastructure,Keys,Values,_,DatastructureFilled),
        remove(AccessType,Datastructure,Keys,Count,DatastructureFilled,RemovedKeys,StorageType,Storage),
        subtract(Keys,RemovedKeys,R),
        clean(Datastructure,R),
        print(.),
        XNew is X - 1,
        remove_Storage_ACC(KeyType, ValueType,Datastructure, Size,Count,XNew,AccessType, StorageType, [Storage|Acc], Result).
        
remove(random,Datastructure,Keys,Count, DatastructureFilled,KeysRemove,StorageType, Storage):-
        data(Keys ,Count, KeysRemove),
        remove(Datastructure,KeysRemove, DatastructureFilled,StorageType, Storage).

remove(first,Datastructure,_,Count, DatastructureFilled,KeysRemove,StorageType, Storage):-
        data(ordIdx,Count,KeysRemove),
        remove(Datastructure,KeysRemove, DatastructureFilled,StorageType, Storage).
        
remove(last,Datastructure,Keys,Count, DatastructureFilled,KeysRemove,StorageType, Storage):-
        length(Keys,X),
        data(ordIdx,X,Count,KeysRemove),
        remove(Datastructure,KeysRemove, DatastructureFilled,StorageType, Storage).


remove(assert,Keys,_Datastructure,StorageType, Storage):-
        storageBytes(StorageType,remove_Assert(Keys),Storage).

remove(bb,Keys,_Datastructure,StorageType, Storage):-
        storageBytes(StorageType,remove_BB(Keys),Storage).

remove(avl,Keys,Datastructure,StorageType, Storage):-
        storageBytes(StorageType,remove_AVL(Keys,Datastructure),Storage).

remove(mutdict,Keys,Datastructure,StorageType, Storage):-
        storageBytes(StorageType,remove_Mutdict(Keys,Datastructure),Storage).




