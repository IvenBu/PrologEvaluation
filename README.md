# PrologEvaluation

Messung der Laufzeit und Speicherplatzbelegung von Operationen auf ausgewählten Datenstrukturen in SICStus Prolog.

Dafür können die folgenden Prädikate verwendet werden, die mit den anschließend definierten Parametern befüllt werden.

__insert_Time(+KeyType, +ValueType, +Datastructure, +Size, +X, -Result)__
Fügt 'Size' zufällige K-V Paare des Key/ValueTyps in eine Datenstruktur des Typs 'Datastructure' ein. Dies wird 'X' mal wiederholt und die gemessenen Zeiten der Einfüge-Operationen in einer Liste in der Variable 'Result' ausgegeben.

__insert_Storage(+KeyType, +ValueType, +Datastructure, +Size, +X, +StorageType, -Result)__
Fügt 'Size' zufällige K-V Paare des Key/ValueTyps in eine Datenstruktur des Typs 'Datastructure' ein. Dies wird 'X' mal wiederholt und die gemessenen Speicherbelegungen des Typs 'StorageType' in einer Liste in der Variable 'Result' ausgegeben.

__get_Time(+KeyType, +ValueType, +Datastructure, +Size, +Count, +X,+AccessType, -Result)__
Fügt 'Size' zufällige K-V Paare des Key/ValueTyps in eine Datenstruktur des Typs 'Datastructure' ein. Anschließend wird auf diese Datenstrukturen mit der Zugriffsart 'AccessType' 'Count'-mal zugegriffen. Dies wird 'X' mal wiederholt und die gemessenen Zeiten der Zugriff-Operationen in einer Liste in der Variable 'Result' ausgegeben.

__get_Storage(+KeyType, +ValueType,+Datastructure,+Size,+Count,+X, +AccessType, +StorageType, -Result)__
Fügt 'Size' zufällige K-V Paare des Key/ValueTyps in eine Datenstruktur des Typs 'Datastructure' ein. Anschließend wird auf diese Datenstrukturen mit der Zugriffsart 'AccessType' 'Count'-mal zugegriffen. Dies wird 'X' mal wiederholt und die gemessenen Speicherbelegung der Zugriff-Operationen in einer Liste in der Variable 'Result' ausgegeben.

__remove_Time(+KeyType, +ValueType, +Datastructure, +Size, +Count,  +X,+AccessType, -Result)__
Fügt 'Size' zufällige K-V Paare des Key/ValueTyps in eine Datenstruktur des Typs 'Datastructure' ein. Anschließend werden 'Count' viele K-V Paare in der Zugriffsart AccessType entfernt. Dies wird 'X' mal wiederholt und die gemessenen Zeiten der Entfernen-Operationen in einer Liste in der Variable 'Result' ausgegeben.

__remove_Storage(+KeyType, +ValueType,+Datastructure, +Size,+Count, +X,+AccessType, +StorageType, -Result)__
Fügt 'Size' zufällige K-V Paare des Key/ValueTyps in eine Datenstruktur des Typs 'Datastructure' ein. Anschließend werden 'Count' viele K-V Paare in der Zugriffsart AccessType entfernt. Dies wird 'X' mal wiederholt und die gemessene Speicherbelegung des Typs 'StorageType' in einer Liste in der Varaible 'Result' ausgegeben.

__update_Time(+KeyType ,+ValueType ,+Datastructure, +Size, +Count, +X,+AccessType, -Result)__
Fügt 'Size' zufällige K-V Paare des Key/ValueTyps in eine Datenstruktur des Typs 'Datastructure' ein. Anschließend werden 'Count' - viele K-V Paare in der Zugriffsart AccessType geupdatet. Dies wird 'X' mal wiederholt und die gemessenen Zeiten der Update-Operationen in einer Liste in der Variable 'Result' ausgegeben.

__update_Storage(+KeyType, +ValueType,+Datastructure, +Size,+Count, +X,+AccessType, +StorageType, -Result)__
Fügt 'Size' zufällige K-V Paare des Key/ValueTyps in eine Datenstruktur des Typs 'Datastructure' ein. Anschließend werden 'Count' - viele K-V Paare in der Zugriffsart AccessType geupdatet. Dies wird 'X' mal wiederholt und die gemessenen Speicherbelegungen der Update-Operationen in einer Liste in der Variable 'Result' ausgegeben.

Folgende Atome können als Eingabe in die vorangestellten Prädikate verwendet werden:

__Datenstrukturen__
assert,bb,assoc,avl,mutdict,logarr, mutarray

__Typen für die Schlüssel__
ordIdx, unordIdx, idxrev,integer,atom,string
ordIdx sind Integerwerte aufsteigend von 1 bis N,unordIx sind Integerwerte von 1 bis N, die zufällig gemischt wurden und idxrev sind absteigende Integerwerte von N bis 1.

__Typen für die Werte__
integer, atom, string

__StorageType - Arten des Speichers__
global_stack_used, local_stack_used, trail_used, choice_used, heap, garbage (Ausgabe ist [no. of GCs,bytes freed,time spent] )

__AccessType - Zugriffsarten__
random, first, last
Die Zugriffsarten last und first funktionieren nur für den KeyType ordIdx.

Die Datenstrukturen logarr und Mutarray können als Schlüssel lediglich die Typen 'ordIdx','unordIdx' und 'idxrev' verwenden.

Das remove Prädikat funktioniert lediglich für die Datenstrukturen assert,bb,avl und mutdict.

Die Daten werden mit dem generate/2 Prädikat aus dem SICStus Prolog Fuzzer von J. Schmidt erstellt. (https://github.com/Joshua27/SICStusPrologFuzzer)

