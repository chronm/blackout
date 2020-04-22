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

  static m0(amount) => "Verfügbar: ${amount}";

  static m1(days) => "${Intl.plural(days, one: '1 Tag', other: '${days} Tage')}";

  static m2(field, from) => "${field} mit ${from} deaktiviert";

  static m3(field, to) => "${field} mit ${to} aktiviert";

  static m4(hours) => "${Intl.plural(hours, one: '1 Stunde', other: '${hours} Stunden')}";

  static m5(minutes) => "${Intl.plural(minutes, one: '1 Minute', other: '${minutes} Minuten')}";

  static m6(field, from, to) => "Änderung von ${field} von ${from} zu ${to}";

  static m7(months) => "${Intl.plural(months, one: '1 Monat', other: '${months} Monate')}";

  static m8(seconds) => "${Intl.plural(seconds, one: '1 Sekunde', other: '${seconds} Sekunden')}";

  static m9(weeks) => "${Intl.plural(weeks, one: '1 Woche', other: '${weeks} Wochen')}";

  static m10(years) => "${Intl.plural(years, one: '1 Jahr', other: '${years} Jahre')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "_locale" : MessageLookupByLibrary.simpleMessage("de"),
    "available" : m0,
    "changes" : MessageLookupByLibrary.simpleMessage("Änderungen"),
    "create" : MessageLookupByLibrary.simpleMessage("Erstellen"),
    "createHome" : MessageLookupByLibrary.simpleMessage("Wie soll der Name Ihres Haushalts lauten?"),
    "created" : MessageLookupByLibrary.simpleMessage("Erstellt"),
    "days" : m1,
    "deleted" : MessageLookupByLibrary.simpleMessage("Gelöscht"),
    "disabledField" : m2,
    "enabledField" : m3,
    "finish" : MessageLookupByLibrary.simpleMessage("Fertig"),
    "hours" : m4,
    "join" : MessageLookupByLibrary.simpleMessage("Beitreten"),
    "joinHome" : MessageLookupByLibrary.simpleMessage("Scanne einfach den QR Code auf einem anderen Gerät um dem Haushalt beizutreten."),
    "minutes" : m5,
    "modifiedField" : m6,
    "modifyCategory" : MessageLookupByLibrary.simpleMessage("Kategorie bearbeiten"),
    "months" : m7,
    "nameOfYourHousehold" : MessageLookupByLibrary.simpleMessage("Name deines Haushaltes"),
    "plural" : MessageLookupByLibrary.simpleMessage("Mehrzahl"),
    "seconds" : m8,
    "setYourHome" : MessageLookupByLibrary.simpleMessage("Möchtest du einem bestehenden Haushalt beitreten oder einen neuen erstellen?"),
    "setYourUsername" : MessageLookupByLibrary.simpleMessage("Wie möchtest du genannt werden? Dies dient dazu, dich in deinem Haushalt zu identifizieren."),
    "setup" : MessageLookupByLibrary.simpleMessage("Einrichtung"),
    "singular" : MessageLookupByLibrary.simpleMessage("Einzahl"),
    "username" : MessageLookupByLibrary.simpleMessage("Benutzername"),
    "weeks" : m9,
    "welcomeMessage" : MessageLookupByLibrary.simpleMessage("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam"),
    "years" : m10
  };
}
