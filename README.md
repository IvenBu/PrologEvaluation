# ReadMe

Messung der Laufzeit und Speicherplatzbelegung von Operationen auf ausgewählten Datenstrukturen in SICStus Prolog.

Dafür können die folgenden Prädikate verwendet werden, die mit den anschließend definierten Parametern befüllt werden.

__analyseInsert(+Measurement,+DatastructureType,+KeyType,+ValueType,+Size,-Result)__
Fügt 'Size' zufällige K-V Paare des Key/ValueTyps in eine leere Datenstruktur des Typs 'DatastructureType' ein. Dies wird 10 mal wiederholt und dabei eine Messung des Typs 'Measurement'durchgeführt und das Ergebnis in einer Liste in der Variable 'Result' ausgegeben.

__analyseGet(+Measurement,+DatastructureType,+KeyType,+ValueType,+Size,+X,+AccessType,-Result)__
Fügt 'Size' zufällige K-V Paare des Key/ValueTyps in eine leere Datenstruktur des Typs 'DatastructureType' ein. Anschließend wird auf diese Datenstrukturen mit der Zugriffsart 'AccessType' 'X'-mal zugegriffen. Dies wird 10 mal wiederholt und dabei eine Messung des Typs 'Measurement'durchgeführt und das Ergebnis in einer Liste in der Variable 'Result' ausgegeben.

__analyseRemove(+Measurement,+DatastructureType,+KeyType,+ValueType,+Size,+X,+AccessType,-Result)__
Fügt 'Size' zufällige K-V Paare des Key/ValueTyps in eine leere Datenstruktur des Typs 'DatastructureType' ein. Anschließend werden 'X' viele K-V Paare mit der Zugriffsart AccessType entfernt. Dies wird 10 mal wiederholt und dabei eine Messung des Typs 'Measurement'durchgeführt und das Ergebnis in einer Liste in der Variable 'Result' ausgegeben.

__analyseUpdate(+Measurement,+DatastructureType,+KeyType,+ValueType,+Size,+X,+AccessType,-Result)__
Fügt 'Size' zufällige K-V Paare des Key/ValueTyps in eine leere Datenstruktur des Typs 'DatastructureType' ein. Anschließend werden 'X' viele K-V Paare mit der Zugriffsart AccessType geupdatet. Dies wird 10 mal wiederholt und dabei eine Messung des Typs 'Measurement'durchgeführt und das Ergebnis in einer Liste in der Variable 'Result' ausgegeben.
    	
Durch das Einfügen eines Seeds vor der Variable 'Result', können Berechnung's übergreifend identische Daten verwendet werden. 
    	
Folgende Atome können als Eingabe in die vorangestellten Prädikate verwendet werden:

__Datenstrukturen__
assert,bb,assoc,avl,mutdict,logarr, mutarray

__Typen für die Schlüssel__
integer,atom,string,ordIdx,revIdx,unordIdx
ordIdx sind Integerwerte aufsteigend von 1 bis N, revIdx sind Integerwerte absteigend von N bis 1 und unordIdx sind Integerwerte von 1 bis N gemischt.

__Typen für die Werte__
integer, atom, string

__Measurement__
time,global_stack_used,local_stack_used, trail_used, choice_used, heap, garbage (Ausgabe ist [no. of GCs,bytes freed,time spent] )

__AccessType - Zugriffsarten__
random, first, last
Die Zugriffsarten last und first funktionieren nur für den KeyType ordIdx.

Die Datenstrukturen logarr und Mutarray können als Schlüssel lediglich die Typen 'ordIdx' verwenden.

Das remove Prädikat funktioniert lediglich für die Datenstrukturen assert,bb,avl und mutdict.

Die Daten werden mit dem generate/2 Prädikat aus dem SICStus Prolog Fuzzer von J. Schmidt erstellt. (https://github.com/Joshua27/SICStusPrologFuzzer)


