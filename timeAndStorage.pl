:- module(timeAndStorage,[time/2,storageBytes/3]).
:- use_module(datastructures).

/* Zeitmessung */
time(Time, Prozedur) :-
        clean,
        statistics(walltime,[Start,_]),
        Prozedur,
        statistics(walltime,[Stop,_]),
        Time is Stop - Start,!.

/* Messen der Speicherbelegung */
storageBytes(heap,Procedure,Bytes) :-
        clean,
        statistics(heap,[Start,_]),
        Procedure,
        statistics(heap,[Stop,_]),
        Bytes is Stop-Start.

storageBytes(garbage,Procedure,[NumberGC,Bytes,Time]) :-
        clean,
        statistics(garbage_collection,[Start1,Start2,Start3]),
        Procedure,
        statistics(garbage_collection,[Stop1,Stop2,Stop3]),
        NumberGC is Stop1 - Start1,
        Bytes is Stop2 - Start2,
        Time is Stop3 - Start3,
        !.

/* Storage:global_stack_used, local_stack_used, trail_used, choice_used, heap ,garbage(Ausgabe is [no. of GCs,bytes freed,time spent]*/
storageBytes(Storage,Procedure,Bytes) :-
        clean,
        statistics(Storage,Start),
        Procedure,
        statistics(Storage,Stop),
        Bytes is Stop-Start.



