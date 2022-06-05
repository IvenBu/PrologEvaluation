:- module(statistics,[prodOfList/2,geoMean/2]).

:- use_module(datastructures).

prodOfList(List,R):-
	prodOfList(List,1,R).

prodOfList([],R,R).

prodOfList([H|T],X,R):-
        Helper is H * X,
        prodOfList(T,Helper,R).

geoMean(List,R) :-
        prodOfList(List,H),
        R is (exp(H,(1/10))).
       
       

