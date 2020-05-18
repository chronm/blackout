// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'de';

  static m0(amount, date) => "${date} ${amount} hinzugefügt";

  static m1(amount) => "${amount} ist kein gültiger Wert";

  static m2(amount) => "Verfügbar: ${amount}";

  static m3(create) => "${create} erstellt";

  static m4(days) => "${Intl.plural(days, one: '1 Tag', other: '${days} Tage')}";

  static m5(field, from) => "${field} (${from}) deaktiviert";

  static m6(field, to) => "${field} (${to}) aktiviert";

  static m7(time) => "lief ${time} ab";

  static m8(time) => "läuft ${time} ab";

  static m9(hours) => "${Intl.plural(hours, one: '1 Stunde', other: '${hours} Stunden')}";

  static m10(months) => "{months, plural, one{in ${months} Monat} other{{in ${months} Monaten}}";

  static m11(weeks) => "{weeks, plural, one{in ${weeks} Woche} other{{in ${weeks} Wochen}}";

  static m12(minutes) => "${Intl.plural(minutes, one: '1 Minute', other: '${minutes} Minuten')}";

  static m13(field, from, to) => "Änderung von ${field} von ${from} zu ${to}";

  static m14(months) => "${Intl.plural(months, one: '1 Monat', other: '${months} Monate')}";

  static m15(time) => "benachrichtige ${time}";

  static m16(amount, date) => "${date} ${amount} entnommen";

  static m17(seconds) => "${Intl.plural(seconds, one: '1 Sekunde', other: '${seconds} Sekunden')}";

  static m18(weeks) => "${Intl.plural(weeks, one: '1 Woche', other: '${weeks} Wochen')}";

  static m19(years) => "${Intl.plural(years, one: '1 Jahr', other: '${years} Jahre')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "_locale" : MessageLookupByLibrary.simpleMessage("de"),
    "added" : m0,
    "amountCouldNotBeParsed" : m1,
    "available" : m2,
    "changes" : MessageLookupByLibrary.simpleMessage("Änderungen"),
    "create" : MessageLookupByLibrary.simpleMessage("Erstellen"),
    "createHome" : MessageLookupByLibrary.simpleMessage("Wie möchten Sie Ihren Haushalt nennen? Sie können ihn später ändern"),
    "created" : MessageLookupByLibrary.simpleMessage("Erstellt"),
    "createdAt" : m3,
    "days" : m4,
    "description" : MessageLookupByLibrary.simpleMessage("Beschreibung"),
    "descriptionMustNotBeEmpty" : MessageLookupByLibrary.simpleMessage("Beschreibung darf nicht leer sein"),
    "disabledField" : m5,
    "ean" : MessageLookupByLibrary.simpleMessage("Produktcode (ean)"),
    "enabledField" : m6,
    "expired" : m7,
    "expires" : m8,
    "finish" : MessageLookupByLibrary.simpleMessage("Fertig"),
    "future" : MessageLookupByLibrary.simpleMessage("weit in der Zukunft"),
    "hours" : m9,
    "inMonths" : m10,
    "inWeeks" : m11,
    "join" : MessageLookupByLibrary.simpleMessage("Beitreten"),
    "joinHome" : MessageLookupByLibrary.simpleMessage("Scanne einfach den QR Code auf einem anderen Gerät um dem Haushalt beizutreten."),
    "longAgo" : MessageLookupByLibrary.simpleMessage("Vor einiger Zeit"),
    "minimumAmount" : MessageLookupByLibrary.simpleMessage("Mindestmenge"),
    "minutes" : m12,
    "modifiedField" : m13,
    "modifyCategory" : MessageLookupByLibrary.simpleMessage("Kategorie bearbeiten"),
    "modifyProduct" : MessageLookupByLibrary.simpleMessage("Produkt bearbeiten"),
    "months" : m14,
    "nameMustNotBeEmpty" : MessageLookupByLibrary.simpleMessage("Name darf nicht leer sein"),
    "nameOfYourHousehold" : MessageLookupByLibrary.simpleMessage("Name deines Haushaltes"),
    "notify" : m15,
    "plural" : MessageLookupByLibrary.simpleMessage("Wenn es eine Pluralform hat, geben Sie hier ein"),
    "removed" : m16,
    "seconds" : m17,
    "setYourHome" : MessageLookupByLibrary.simpleMessage("Wollen Sie einem bestehenden Haushalt beitreten oder einen neuen gründen?"),
    "setYourUsername" : MessageLookupByLibrary.simpleMessage("Wie möchten Sie genannt werden? Dies ist für jeden Haushalt, zu dem Sie gehören, gleich und wird verwendet, um Sie zu identifizieren, z.B. wenn Sie Gegenstände hinzufügen oder entfernen. Sie können dies später ändern."),
    "setup" : MessageLookupByLibrary.simpleMessage("Einrichtung"),
    "singular" : MessageLookupByLibrary.simpleMessage("Wie lautet der Name dieser Kategorie?"),
    "today" : MessageLookupByLibrary.simpleMessage("heute"),
    "tomorrow" : MessageLookupByLibrary.simpleMessage("morgen"),
    "username" : MessageLookupByLibrary.simpleMessage("Benutzername"),
    "warnMe" : MessageLookupByLibrary.simpleMessage("Warne mich vor Ablauf"),
    "weeks" : m18,
    "welcomeMessage" : MessageLookupByLibrary.simpleMessage("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam"),
    "years" : m19,
    "yesterday" : MessageLookupByLibrary.simpleMessage("gestern")
  };
}
