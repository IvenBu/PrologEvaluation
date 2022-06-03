:- module(update,[update/6,update_Time/8,update_Storage/9]).
:- use_module(timeAndStorage).
:- use_module(datagenerator).
:- use_module(insert).
:- use_module(datastructures).
:- use_module(library(random),[getrand/1,setrand/1]).

/* Updaten mit Zeitmessung */
update(assert,Keys, Values, _Datastructure,_, Time) :-
        time(Time,update_Assert(Keys, Values)).

update(bb,Keys, Values, _Datastructure,_, Time) :-
        time(Time,update_BB(Keys, Values)).

update(avl,Keys, Values, Datastructure,Back, Time) :-
        time(Time,update_AVL(Keys, Values,Datastructure,Back)).

update(assoc,Keys, Values, Datastructure,Back, Time) :-
        time(Time,update_Assoc(Keys, Values,Datastructure,Back)).

update(mutdict,Keys, Values, Datastructure,Back, Time) :-
        time(Time,update_Mutdict(Keys, Values,Datastructure,Back)).

update(logarr,Keys, Values, Datastructure,Back, Time) :-
        time(Time,update_Logarr(Keys, Values,Datastructure,Back)).

update(mutarray,Keys, Values, Datastructure,Back, Time) :-
        time(Time,update_Mutarray(Keys, Values,Datastructure,Back)).

update(random,Datastructure,Keys,ValuesType,Count, DatastructureFilled, Time):-
        data(Keys, Count, KeysUpdate),
        data(ValuesType, Count, ValuesUpdate),
        update(Datastructure,KeysUpdate, ValuesUpdate, DatastructureFilled, _,Time).

update(last,Datastructure,Keys,ValuesType,Count,DatastructureFilled, Time):-
        length(Keys,X),
        data(ordIdx,X,Count,KeysUpdate),
        data(ValuesType,Count, ValuesUpdate),
        update(Datastructure,KeysUpdate,ValuesUpdate, DatastructureFilled,_, Time).

update(first,Datastructure,_, ValuesType,Count,DatastructureFilled, Time):-
        data(ordIdx,Count,KeysUpdate),
        data(ValuesType, Count, ValuesUpdate),
        update(Datastructure,KeysUpdate,ValuesUpdate, DatastructureFilled,_, Time).
        
update_Time(KeyType ,ValuesType ,Datastructure, Size,Count,X,AccessType,Time) :-
        getrand(Seed),
       update_Time_ACC(KeyType ,ValuesType ,Datastructure, Size,Count,X,AccessType,[],Seed,Time).

update_Time_ACC(_,_,_,_,_,0,_,Result,_,Result).

update_Time_ACC(KeyType ,ValueType ,Datastructure, Size, Count,X,AccessType,Acc,Seed,Result):-
        setrand(Seed),
        data(KeyType, Size, Keys),
        data(ValueType, Size, Values),
        insert(Datastructure,Keys,Values,_,DatastructureFilled),
        update(AccessType,Datastructure,Keys,ValueType,Count,DatastructureFilled,Time),
        clean(Datastructure,Keys),
        print(.),
        XNew is X - 1,
        update_Time_ACC(KeyType ,ValueType ,Datastructure, Size, Count,XNew,AccessType,[Time|Acc],Seed,Result).
        
        
        %Speichermessung
        

update(assert,Keys, Values, _Datastructure,_, StorageType, Storage) :-
        storageBytes(StorageType,update_Assert(Keys, Values),Storage).

update(bb,Keys, Values, _Datastructure,_, StorageType, Storage) :-
        storageBytes(StorageType,update_BB(Keys, Values),Storage).

update(avl,Keys, Values, Datastructure,Back, StorageType, Storage) :-
        storageBytes(StorageType,update_AVL(Keys,Values, Datastructure, Back),Storage).

update(assoc,Keys, Values, Datastructure,Back, StorageType, Storage) :-
         storageBytes(StorageType,update_Assoc(Keys,Values,Datastructure, Back),Storage).

update(mutdict,Keys, Values, Datastructure,Back, StorageType, Storage) :-
        storageBytes(StorageType,update_Mutdict(Keys,Values, Datastructure, Back),Storage).

update(logarr,Keys, Values, Datastructure,Back, StorageType, Storage) :-
        storageBytes(StorageType,update_Logarr(Keys, Values,Datastructure, Back),Storage).

update(mutarray,Keys, Values, Datastructure,Back, StorageType, Storage) :-
        storageBytes(StorageType,update_Mutarray(Keys, Values,Datastructure, Back),Storage).
        
        
update(random,Datastructure,Keys,ValuesType,Count, DatastructureFilled,StorageType, Storage):-
        data(Keys ,Count, KeysUpdate),
        data(ValuesType, Count, ValuesUpdate),
        update(Datastructure,KeysUpdate,ValuesUpdate, DatastructureFilled,_,StorageType, Storage).

update(first,Datastructure,_,ValuesType,Count, DatastructureFilled,StorageType, Storage):-
        data(ordIdx,Count,KeysUpdate),
        data(ValuesType, Count, ValuesUpdate),
        update(Datastructure,KeysUpdate,ValuesUpdate, DatastructureFilled,_,StorageType, Storage).
        
update(last,Datastructure,Keys,ValuesType,Count, DatastructureFilled,StorageType, Storage):-
        length(Keys,X),
        data(ordIdx,X,Count,KeysUpdate),
        data(ValuesType,Count, ValuesUpdate),
        update(Datastructure,KeysUpdate,ValuesUpdate, DatastructureFilled,_,StorageType, Storage).


update_Storage(KeyType, ValueType,Datastructure, Size,Count, X,AccessType, StorageType, Result) :-
	getrand(Seed),
        update_Storage_ACC(KeyType, ValueType,Datastructure, Size,Count,X,AccessType, StorageType, [],Seed, Result).

update_Storage_ACC(_,_,_,_,_,0,_,_, Result,_,Result).

update_Storage_ACC(KeyType, ValueType,Datastructure, Size,Count,X,AccessType, StorageType, Acc,Seed, Result):-
        setrand(Seed),
        data(KeyType, Size, Keys),
        data(ValueType, Size, Values),
        insert(Datastructure,Keys,Values,_,DatastructureFilled),
        update(AccessType,Datastructure,Keys,ValueType,Count,DatastructureFilled,StorageType,Storage),
        clean(Datastructure,Keys),
        print(.),
        XNew is X - 1,
        update_Storage_ACC(KeyType, ValueType,Datastructure, Size,Count,XNew,AccessType, StorageType, [Storage|Acc],Seed, Result).

            
        
        




