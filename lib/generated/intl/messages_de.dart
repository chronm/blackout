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

  static m0(amount) => "${amount} ist kein gültiger Wert";

  static m1(amount) => "Verfügbar: ${amount}";

  static m2(days) => "${Intl.plural(days, one: '1 Tag', other: '${days} Tage')}";

  static m3(field, from) => "${field} (${from}) deaktiviert";

  static m4(field, to) => "${field} (${to}) aktiviert";

  static m5(hours) => "${Intl.plural(hours, one: '1 Stunde', other: '${hours} Stunden')}";

  static m6(minutes) => "${Intl.plural(minutes, one: '1 Minute', other: '${minutes} Minuten')}";

  static m7(field, from, to) => "Änderung von ${field} von ${from} zu ${to}";

  static m8(months) => "${Intl.plural(months, one: '1 Monat', other: '${months} Monate')}";

  static m9(seconds) => "${Intl.plural(seconds, one: '1 Sekunde', other: '${seconds} Sekunden')}";

  static m10(weeks) => "${Intl.plural(weeks, one: '1 Woche', other: '${weeks} Wochen')}";

  static m11(years) => "${Intl.plural(years, one: '1 Jahr', other: '${years} Jahre')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "_locale" : MessageLookupByLibrary.simpleMessage("de"),
    "amountCouldNotBeParsed" : m0,
    "available" : m1,
    "changes" : MessageLookupByLibrary.simpleMessage("Änderungen"),
    "create" : MessageLookupByLibrary.simpleMessage("Erstellen"),
    "createHome" : MessageLookupByLibrary.simpleMessage("Wie möchten Sie Ihren Haushalt nennen? Sie können ihn später ändern"),
    "created" : MessageLookupByLibrary.simpleMessage("Erstellt"),
    "days" : m2,
    "deleted" : MessageLookupByLibrary.simpleMessage("Gelöscht"),
    "disabledField" : m3,
    "enabledField" : m4,
    "finish" : MessageLookupByLibrary.simpleMessage("Fertig"),
    "hours" : m5,
    "join" : MessageLookupByLibrary.simpleMessage("Beitreten"),
    "joinHome" : MessageLookupByLibrary.simpleMessage("Scanne einfach den QR Code auf einem anderen Gerät um dem Haushalt beizutreten."),
    "minimumAmount" : MessageLookupByLibrary.simpleMessage("Mindestmenge"),
    "minutes" : m6,
    "modifiedField" : m7,
    "modifyCategory" : MessageLookupByLibrary.simpleMessage("Kategorie bearbeiten"),
    "months" : m8,
    "nameMustNotBeEmpty" : MessageLookupByLibrary.simpleMessage("Name darf nicht leer sein"),
    "nameOfYourHousehold" : MessageLookupByLibrary.simpleMessage("Name deines Haushaltes"),
    "plural" : MessageLookupByLibrary.simpleMessage("Wenn es eine Pluralform hat, geben Sie hier ein"),
    "seconds" : m9,
    "setYourHome" : MessageLookupByLibrary.simpleMessage("Wollen Sie einem bestehenden Haushalt beitreten oder einen neuen gründen?"),
    "setYourUsername" : MessageLookupByLibrary.simpleMessage("Wie möchten Sie genannt werden? Dies ist für jeden Haushalt, zu dem Sie gehören, gleich und wird verwendet, um Sie zu identifizieren, z.B. wenn Sie Gegenstände hinzufügen oder entfernen. Sie können dies später ändern."),
    "setup" : MessageLookupByLibrary.simpleMessage("Einrichtung"),
    "singular" : MessageLookupByLibrary.simpleMessage("Wie lautet der Name dieser Kategorie?"),
    "username" : MessageLookupByLibrary.simpleMessage("Benutzername"),
    "warnMe" : MessageLookupByLibrary.simpleMessage("Warne mich vor Ablauf"),
    "weeks" : m10,
    "welcomeMessage" : MessageLookupByLibrary.simpleMessage("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam"),
    "years" : m11
  };
}
