# Blackout
Blackout hilft dir dabei deine Vorräte im Blick zu behalten.

[English translation](./README.md)

## Videos
- [Einrichtung][YoutubeSetup]
- [Produkt einer Gruppe hinzufügen][YoutubeGroupForProduct]
- [Barcode scannen][YoutubeScanning]

## Was musst du dafür tun?
Lade dir die App [hier][ReleaseApk] herunter und öffne sie. Möglicherweise musst du noch die Einstellung ["Apps aus unbekannten Quellen zulassen"][AppsFromUnknownSources] aktivieren, da Blackout nicht über den Google Play Store installiert wird.

Blackout benötigt einige Informationen vom Benutzer:
* zunächst wird die Berechtigung auf den Speicher angefordert. Mit dieser wird die Datenbank in einem für den Benutzer zugänglichen Speicherort abgelegt. Dadurch kann die Datenbank einfach gesichert und wiederhergestellt werden.
* mit dem Passwort im nächsten Schritt wird die Datenbank verschlüsselt
* Benutzername und Haushaltsname sind zurzeit reine Formalität, werden aber in Zukunft benötigt, wenn sich mehrere Teilnehmer einen Haushalt teilen
  
## Wie funktioniert das ganze?
Alle deine Vorräte werden in Gruppen, Produkten und Chargen organisiert.

In was?

### Produkte
Ein Produkt *kann* die folgenden Eigenschaften besitzen:
* Produktbeschreibung
* Produktcode (Barcode)
* Warnzeitraum
* Einheit
* gewünschte Mindestmenge
* [Gruppe](#Gruppen)

Wenn du ein Produkt einer Gruppe hinzufügst, übernimmt das Produkt Warnzeitraum und Einheit der Gruppe und die Mindestmenge wird deaktiviert.

### Gruppen
Gruppen sind aufgebaut aus:
* Name
* Pluralname
* Warnzeitraum
* Einheit
* Mindestmenge

### Chargen
Eine Charge ist das, was du physisch gekauft, gekocht oder gebacken hast. Sie besteht lediglich aus einem Mindesthaltbarkeitsdatum.

### Beispiel gefällig?
Du kaufst Eier im Supermarkt:

+- [Gruppe](#Gruppen)  
&nbsp;&nbsp;+- Name: Ei  
&nbsp;&nbsp;+- Pluralname: Eier  
&nbsp;&nbsp;+- Warnzeitraum: P1W  
&nbsp;&nbsp;+- Einheit: einheitenlos  
&nbsp;&nbsp;+- Mindestmenge: 5  
&nbsp;&nbsp;+- [Produkt](#Produkte)  
&nbsp;&nbsp;&nbsp;&nbsp;+- Beschreibung: Freilandeier 10 Größe M  
&nbsp;&nbsp;&nbsp;&nbsp;+- Produktcode: 1234567891011  
&nbsp;&nbsp;&nbsp;&nbsp;+- [Charge](#Charge)  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+- Mindesthaltbarkeitsdatum: 11.11.2022  
 
Du willst also mindestens 5 Eier haben und wirst 1 Woche vor dem Mindesthaltbarkeitsdatum über dieses informiert.

### Der tägliche Gebrauch
Im Startbildschirm kannst du einfach einen Barcode einscannen und kommst automatisch zum entsprechenden Produkt. Dort fügst du entweder eine Charge hinzu oder wählst eine bestehende aus. Anschließend kannst du etwas zu der Charge hinzufügen oder ihr etwas entnehmen.

[//]: Links

[AppsFromUnknownSources]: https://www.tutonaut.de/anleitung-android-apps-unbekannten-quellen-installieren/
[ReleaseApk]: https://github.com/chronm/blackout-mobile/releases/download/v0.3.0/Blackout.apk
[YoutubeSetup]: https://youtu.be/HOT-Ulg2F5Y
[YoutubeGroupForProduct]: https://youtu.be/1XfV_ERdzXQ
[YoutubeScanning]: https://youtu.be/tfTFRvXBfPA
