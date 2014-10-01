Quellen
=======

Für die Verwaltung der verwendeten Literatur und referenzierten Medien
ist eine Textdatei im **BibLaTeX**-Format zuständig.

Das Eintragen und Ändern von Inhalten kann, den eigenen Werkzeugen
entsprechend mittels unterschiedlicher Software erledigt werden:

-   Texteditoren für das direkte arbeiten an der Datei (gedit,
    notepad++, ...)
-   Literaturverwaltungsprogramme, welche den Export nach
    BibTeX/BibLaTeX erlauben (Zotero, Mendeley, Citavi, ...)

Eingabe der Daten
-----------------

Für eine *Monografie* benötigen wir beispielsweise folgende Angaben,
wobei der `mein:key` so gewählt wird, damit ein einfaches Merken und
damit Arbeiten und belegen im Text möglich ist.

``` {.bibtex}
@Book{mein:key,
  Author = {Dampf, Hans},
  Title = {Der tolle Titel},
  Publisher = {Derverlag},
  Year = {2014},
  Address = {Derort}
}
```

Beispiel für einen *Artikel in einer Fachzeitschrift*:

``` {.bibtex}
@Article{palmatier:1974,
  Author = {Palmatier, Robert A. and Bennett, John Michael},
  Title = {Notetaking Habits of College Students},
  Journal = {Journal of Reading},
  Year = {1974},
  Volume = {18},
  Number = {3},
  Pages = {215-218}
}
```

Beziehen Sie sich in ihrer Arbeit auf eine *wissenschaftliche
Abschlussarbeit* könnte ein Eintrag folgendermaßen aussehen:

``` {.bibtex}
@MastersThesis{belanger:2010,
  Author = {Bélanger, Marie-Eve},
  Title = {The Annotative Practices of Graduate Students: Tensions \& Negotiations Fostering an Epistemic Practice},
  School = {Faculty of Information},
  Address = {University of Toronto},
  Year = {2010}
}
```

*Online-Quellen* können wir so eintragen:

``` {.bibtex}
@Electronic{oreilly:2005,
  Author = {O'Reilly, Tim},
  Title = {What is Web 2.0: Design Patterns and Business Models for the Next Generation of Software.},
  Url = {http://www.oreillynet.com/pub/a/oreilly/tim/news/2005/09/30/what-is-web-20.html},
  Year = {2005},
  Urldate = {2014-08-30}
}
```

und als Untergruppe Einträge der *Wikipedia* und deren Versionsstand
verzeichnen wir in unserer Quellenverwaltung derart:

``` {.bibtex}
@Electronic{wiki:mewi,
  Author = {Wikipedia},
  Title = {Medienwissenschaft -- Wikipedia{,} Die freie Enzyklopädie},
  Year = {2014},
  Date = {2014-01-30},
  Url = {http://de.wikipedia.org/w/index.php?title=Medienwissenschaft&oldid=130311321},
  Urldate = {2014-09-30},
}
```

Filmmaterial erfassen wir im folgenden Schema:

``` {.bibtex}
@Movie{mein:kuerzel,
  Address = {Produktionsland},
  Author = {Regisseur},
  Pagetotal = {Laufzeit-in-Minuten},
  Shorttitle = {Kurztitel},
  Title = {Originaltitel (dt. Titel)},
  Howpublished = {Vertrieb [Medium/Mediumsjahr]},
  Year = {Produktionsjahr},
  Type = {movie},
  Keywords = {film},
}
```

Das Kürzel ist auch hier frei wählbar. Die Regisseurangaben bringen wir
im `Author`-Feld unter. Die Angabe zur Laufdauer des Films geben wir in
Minuten (ohne Einheit) im Feld `Pagetotal` an. Das Feld `Shorttitle`
enthält den Titel, wie er in den Referenzierungen im Text verwendet
wird; das Feld `Title` enthält die Angaben zum Titel, wie er in der
Filmografie erscheinen soll. Das Feld `Howpublished` beinhaltet Angaben
zur Produktionsfirma und/oder Angaben zum Vertrieb des spezifischen
Mediums, welches für die Filmanalyse genutzt wurde; beispielsweise
handelt es sich um die DVD-Fassung von 2007, wo die Vertriebsrechte bei
XYZ liegen. Die eckigen Klammern bei Informationen zu Fassung und Jahr
sind ein Zugeständnis an den anvisierten Zitierstil. Die manuelle
Eingabe/Formatierung dieses Bereichs ist notwendig, da es sich hier eine
flexible Eingabe erwünscht ist und somit die Spezifika zum Filmobjekt
nach Notwendigkeit für die Filmografie selbst gewählt werden kann. Die
Angabe zum Jahr findet im Feld `Year` statt. Sinnvoll -- wie im Übrigen
auch bei traditioneller Literatur -- kann die Angabe des Jahrs der
Originalausgabe sein, hierfür wird das Feld `Origdate` verwendet. In der
Im-Text-Zitation und der Bibliografie/Filmografie wird daraufhin an der
Stelle des Jahres noch das Originaljahr durch einen Schrägstrich
getrennt angezeigt: 2014/2000.

Die Feldzuweisung `Type = {movie}` und `Keywords = {film}` ist nötig für
die ordentliche Trennung und Aufbereitung hinsichtlich Bibliografie und
Filmografie und die Umschaltung von einer Autor-Jahr geleiteten Zitation
zur abweichenden Titel-Jahr-Zitation für Filme.

``` {.bibtex}
@Movie{kubrick:1968,
  Address = {UK/USA},
  Author = {Kubrick, Stanley},
  Pagetotal = {141},
  Shorttitle = {2001: A Space Odyssey},
  Title = {2001: A Space Odyssey (2001: Odyssee im Weltraum)},
  Howpublished = {Warner Home Video [DVD/2007]},
  Year = {1968},
  Type = {movie},
  Keywords = {film},
}
```

Zitation im Text
----------------

Liegen die Daten zum jeweiligen Werk erst einmal in strukturierter Form
vor können wir uns beim Schreiben des wissenschaftlichen Textes auf den
Inhalt konzentrieren. In unserem Markdown-formatierten Text weben wir
Bezüge auf Autoren, Filmtitel, eben auf unsere Quellen an Stellen ein wo
paraphrasiert wird, neu-zusammegestellte oder eigenen Ideen mit Inhalten
aus den Quellen verwoben werden; und ganz einfach geht dies zudem!

Es lassen sich drei Arten der Notation für unser Dokument unterscheiden:

-   `[@meier:2012, 33-34]`
-   `[-@meier:2012, 33-34]`
-   `@meier:2012 [33-34]`

