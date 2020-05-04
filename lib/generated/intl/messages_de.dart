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

  static m2(create) => "${create} erstellt";

  static m3(days) => "${Intl.plural(days, one: '1 Tag', other: '${days} Tage')}";

  static m4(field, from) => "${field} (${from}) deaktiviert";

  static m5(field, to) => "${field} (${to}) aktiviert";

  static m6(time) => "lief ${time} ab";

  static m7(time) => "läuft ${time} ab";

  static m8(hours) => "${Intl.plural(hours, one: '1 Stunde', other: '${hours} Stunden')}";

  static m9(months) => "{months, plural, one{in ${months} Monat} other{{in ${months} Monaten}}";

  static m10(weeks) => "{weeks, plural, one{in ${weeks} Woche} other{{in ${weeks} Wochen}}";

  static m11(minutes) => "${Intl.plural(minutes, one: '1 Minute', other: '${minutes} Minuten')}";

  static m12(field, from, to) => "Änderung von ${field} von ${from} zu ${to}";

  static m13(months) => "${Intl.plural(months, one: '1 Monat', other: '${months} Monate')}";

  static m14(time) => "benachrichtige ${time}";

  static m15(seconds) => "${Intl.plural(seconds, one: '1 Sekunde', other: '${seconds} Sekunden')}";

  static m16(weeks) => "${Intl.plural(weeks, one: '1 Woche', other: '${weeks} Wochen')}";

  static m17(years) => "${Intl.plural(years, one: '1 Jahr', other: '${years} Jahre')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "_locale" : MessageLookupByLibrary.simpleMessage("de"),
    "amountCouldNotBeParsed" : m0,
    "available" : m1,
    "changes" : MessageLookupByLibrary.simpleMessage("Änderungen"),
    "create" : MessageLookupByLibrary.simpleMessage("Erstellen"),
    "createHome" : MessageLookupByLibrary.simpleMessage("Wie möchten Sie Ihren Haushalt nennen? Sie können ihn später ändern"),
    "created" : MessageLookupByLibrary.simpleMessage("Erstellt"),
    "createdAt" : m2,
    "days" : m3,
    "deleted" : MessageLookupByLibrary.simpleMessage("Gelöscht"),
    "disabledField" : m4,
    "enabledField" : m5,
    "expired" : m6,
    "expires" : m7,
    "finish" : MessageLookupByLibrary.simpleMessage("Fertig"),
    "future" : MessageLookupByLibrary.simpleMessage("weit in der Zukunft"),
    "hours" : m8,
    "inMonths" : m9,
    "inWeeks" : m10,
    "join" : MessageLookupByLibrary.simpleMessage("Beitreten"),
    "joinHome" : MessageLookupByLibrary.simpleMessage("Scanne einfach den QR Code auf einem anderen Gerät um dem Haushalt beizutreten."),
    "longAgo" : MessageLookupByLibrary.simpleMessage("Vor einiger Zeit"),
    "minimumAmount" : MessageLookupByLibrary.simpleMessage("Mindestmenge"),
    "minutes" : m11,
    "modifiedField" : m12,
    "modifyCategory" : MessageLookupByLibrary.simpleMessage("Kategorie bearbeiten"),
    "months" : m13,
    "nameMustNotBeEmpty" : MessageLookupByLibrary.simpleMessage("Name darf nicht leer sein"),
    "nameOfYourHousehold" : MessageLookupByLibrary.simpleMessage("Name deines Haushaltes"),
    "notify" : m14,
    "plural" : MessageLookupByLibrary.simpleMessage("Wenn es eine Pluralform hat, geben Sie hier ein"),
    "seconds" : m15,
    "setYourHome" : MessageLookupByLibrary.simpleMessage("Wollen Sie einem bestehenden Haushalt beitreten oder einen neuen gründen?"),
    "setYourUsername" : MessageLookupByLibrary.simpleMessage("Wie möchten Sie genannt werden? Dies ist für jeden Haushalt, zu dem Sie gehören, gleich und wird verwendet, um Sie zu identifizieren, z.B. wenn Sie Gegenstände hinzufügen oder entfernen. Sie können dies später ändern."),
    "setup" : MessageLookupByLibrary.simpleMessage("Einrichtung"),
    "singular" : MessageLookupByLibrary.simpleMessage("Wie lautet der Name dieser Kategorie?"),
    "today" : MessageLookupByLibrary.simpleMessage("heute"),
    "tomorrow" : MessageLookupByLibrary.simpleMessage("morgen"),
    "username" : MessageLookupByLibrary.simpleMessage("Benutzername"),
    "warnMe" : MessageLookupByLibrary.simpleMessage("Warne mich vor Ablauf"),
    "weeks" : m16,
    "welcomeMessage" : MessageLookupByLibrary.simpleMessage("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam"),
    "years" : m17,
    "yesterday" : MessageLookupByLibrary.simpleMessage("gestern")
  };
}
