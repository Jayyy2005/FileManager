# Projekt-Dokumentation


## Informieren

### User Stories

| US-№ | Verbindlichkeit | Art          | Beschreibung                                                       |
| ---- | --------------- | ------------ | ------------------------------------------------------------------|
| 0    | Muss            | Funktional   | Als ein Besucher muss ich in der Lage sein, das Programm zu öffnen. |
| 1    | Muss            | Funktional   | Als ein Besucher kann ich Dateien komprimieren. |
| 2    | Muss            | Funktional   | Als ein Besucher kann ich Dateien dekomprimieren. |
| 3    | Muss            | Funktional   | Als ein Besucher kann ich Videos in MP3-Format konvertieren. |
| 4    | Muss            | Qualitativ   | Als ein Besucher kann ich Fehlermeldungen einsehen. |




### 1.3 Testfälle

| Testfall-Nummer | Ausgangslage                                                                  | Eingabe                                  | Erwartete Ausgabe                                                     |
| --------------- | ----------------------------------------------------------------------------- | ---------------------------------------- | --------------------------------------------------------------------- |
| 0.1             | Der Besucher öffnet das Programm.                      | Programm öffnen.    | Startseite des Programmes wird geöffnet.    |
| 0.2             | Der Besucher klickt auf die Schaltflächen, um die entsprechende Windows zu wechseln.                    | Klick auf die Schaltflächen "Zurück".                 | Entsprechende Funktionalitäten werden gewechselt.                 |
| 1.1             | Der Besucher wechselt zu "Komprimieren".                    | Schaltfläche "Komprimieren" vom Homescreen klicken. | Window für Komprimieren wird geöffnet. |
| 1.2             | Der Besucher wählt eine Datei.                      | Klick auf "Datei auswählen".                      | Windows Explorer wird geöffnet, um eine Datei auszuwählen.     |
| 1.3             | Der Besucher entfernt Auswahl eines Datei.                               | Klick auf "Auswahl entfernen".                                           | Kein Datei wurde gewählt.                                           |
| 1.4             | Der Besucher komprimiert.                                          | Klick auf "Komprimieren".                                           | Ausgewählte Dateien werden komprimiert.                                  |
| 2.1             | Der Besucher dekomprimiert.               | Klick auf "Dekomprimieren".     | Ausgewählte ZIP-Datei wird dekomprimiert.     |
| 3.1             | Der Besucher wechselt zu "MP3-Konvertierung". | Schaltfläche "MP3-Konvertierung" vom Homescreen klicken.         | Window für MP3-Konvertierung wird geöffnet.          |
| 3.2             | Der Besucher wählt eine Video-Datei.                      | Klick auf "Datei auswählen".                      | Windows Explorer wird geöffnet, um eine Datei auszuwählen.     |
| 3.3             | Der Besucher entfernt Auswahl eines Video-Datei.                               | Klick auf "Auswahl entfernen".                                           | Kein Datei wurde gewählt.                                           |
| 3.4             | Der Besucher konvertiert.                                          | Klick auf "Konvertiere zu MP3!".                                           | Ausgewählte Video-Dateien werden zu MP3-Format konvertiert.                                  |
| 4.1             | Der Besucher konvertiert/komprimiert/dekomprimiert eine existierende Output                                          | Klick auf Aktion                                           | Fehlermeldung wird angezeigt.                                  |
| 4.2             | Der Besucher konvertiert/komprimiert/dekomprimiert eine ungültige Datei                                          | Klick auf Aktion                                           | Fehlermeldung wird angezeigt.                                  |


## 2 Planen

| AP-№ | Zuständig | Beschreibung                            | Geplante Zeit | Frist        |
| ---- | --------- | --------------------------------------- | ------------- | ------------ |
| 0.0  | Raviraj   | Erstellung der Projektdokumentation    | 2 Stunden     | 19.01.2024   |
| 1.A  | Raviraj   | Design und Umsetzung der Startseite     | 4 Stunden     | 19.01.2024   |
| 1.B  | Raviraj   | Design und Umsetzung der Komprimierung-Seite  | 4 Stunden | 26.01.2024   |
| 1.C  | Raviraj   | Design und Umsetzung der Konvertierung-Seite | 4 Stunden | 02.02.2024   |
| 2.A  | Raviraj   | Library für MP3-Konvertierung | 2 Stunden | 02.02.2024   |
| 3.A  | Raviraj   | Try-Catch Funktion        | 4 Stunden     | 23.02.2024   |
| 3.B  | Raviraj   | Zusammenführung von Skripts    | 2 Stunden     | 23.02.2024   |
| 4.A  | Raviraj   | Erstellung eines Portfolioeintrags       | 2 Stunden     | 01.03.2024   |




## 3 Entscheiden

Keine

## 4 Realisieren

| AP-№ | Zuständig | Geplante Zeit | Tatsächliche Zeit | Datum      |
| ---- | --------- | ------------- | ----------------- | ---------- |
| 0.0  | Raviraj   | 2 Stunden      | 2 Stunden         | 19.01.2024 |
| 1.A  | Raviraj   | 4 Stunden      | 4 Stunden        | 19.01.2024 |
| 1.B  | Raviraj   | 4 Stunden      | 4 Stunden         | 26.01.2024 |
| 1.C  | Raviraj   | 4 Stunden      | 5 Stunden         | 02.02.2024 |
| 2.A  | Raviraj   | 2 Stunden      | 1 Stunden         | 02.02.2024 |
| 3.A  | Raviraj   | 4 Stunden      | 4 Stunden         | 23.02.2024 |
| 3.B  | Raviraj   | 2 Stunden      | 3 Stunden         | 23.02.2024 |
| 4.A  | Raviraj   | 2 Stunden      | 2 Stunde          | 01.03.2024 |




## 5 Kontrollieren

### 5.1 Testprotokoll

| Testfall-№ | Resultat | Tester  | Datum     |
| -----------| ---------| --------| ----------|
| 0.1        | OK       | Raviraj | 01.03.2024|
| 0.2        | OK       | Raviraj | 01.03.2024|
| 1.1        | OK       | Raviraj | 01.03.2024|
| 1.2        | OK       | Raviraj | 01.03.2024|
| 1.3        | OK       | Raviraj | 01.03.2024|
| 1.4        | OK       | Raviraj | 01.03.2024|
| 2.1        | OK       | Raviraj | 01.03.2024|
| 3.1        | OK       | Raviraj | 01.03.2024|
| 3.2        | OK       | Raviraj | 01.03.2024|
| 3.3        | OK       | Raviraj | 01.03.2024|
| 3.4        | OK       | Raviraj | 01.03.2024|
| 4.1        | OK       | Raviraj | 01.03.2024|
| 4.2        | OK       | Raviraj | 01.03.2024|






