# Behälter-Pascal

# 1.Behälter für Wörter
Implementieren Sie einen Behälter (container) für Wörter (also für Werte des Datentyps STRING) auf Basis eines binären Suchbaums als abstrakte Datenstruktur (ADS) in Form eines Moduls (Pascal-UNIT) mit der Bezeichnung WC_ADS (für word container as abstract data structure).
Als Operationen müssen mindestens IsEmpty, Insert, Remove und Contains zur Verfügung gestellt werden.

# 2. Behälter für Wörter
Realisieren Sie (auf Basis Ihrer Erfahrungen aus Aufgabe 1) einen abstrakten Datentyp (AT) für Wortbehälter (word container) auf Basis binärer Suchbäume in Form eines Moduls (Pascal-UNIT) mit der Bezeichnung WC_ADT (für word container as abstract data type).
Als Operationen müssen (wieder) mindestens IsEmpty, Insert, Remove und Contains zur Verfügung gestellt werden.
# 3. Menge
Eine Menge (im Sinne der Mathematik) enthält jedes Element nur einmal, wobei die Reihenfolge der Elemente irrelevant ist. In einer Wortmenge kommt also jedes Wort nur einmal vor. Somit muss gelten { 'a', 'b', 'b', 'a' } = { 'a', 'b' } = { 'b', 'a' }.
Realisieren Sie (auf Basis Ihrer Erfahrungen aus Aufgabe 1 und 2) einen abstrakten Datentyp (ADT) für Wortmengen (word sets) in Form eines Moduls (Pascal-UNIT) mit der Bezeichnung WS_ADT.
Neben den schon aus den ersten Aufgaben bekannten Operationen IsEmpty, Insert, Remove und Contains müssen nun auch die typischen Mengenoperationen Union, Intersection und Difference in Form von Funktionen mit folgender Schnittstelle
###FUNCTION ...(s1, s2: WordSet): WordSet;
realisiert werden, sowie die Operation Cardinality, welche die Anzahl der Elemente einer Menge liefert.
Um Ihre Mengenimplementierung zu testen, versuchen Sie zu überprüfen, ob die derzeitige Koaliti- onsform in Österreich (große Koalition aus SPÖ und ÖVP) wirklich eine gute Idee war. Lesen Sie dazu die Parteiprogramme der vier größeren, derzeit im Nationalrat vertretenen Parteien (SPÖ, ÖVP, FPÖ, GRÜNE, also ohne Team Stronach und NEOS, siehe ZIP-Datei Parteiprogramme im Moodle-Kurs) jeweils in eine Wortmenge ein und bilden dann alle möglichen Schnittmengen aus jeweils zweien davon. Als Ausgangsbasis für Ihre Programm können Sie den Inhalt der ZIP-Datei WordStuff verwenden.
... mal sehen, ob die Parteiprogramme von SPÖ und ÖVP wirklich die meisten "Gemeinsamkeiten" (in Form von gleichen Wörtern) aufweisen oder ob nicht eine andere Zusammenstellung besser ge- eignet gewesen wäre.
