import 'package:Blackout/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whatsnew/flutter_whatsnew.dart';

class Changelog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String locale = S.delegate.isSupported(Localizations.localeOf(context)) ? Localizations.localeOf(context).languageCode : "en";
    return WhatsNewPage.changelog(
      title: Text(S.of(context).CHANGELOG),
      buttonText: Text(S.of(context).CHANGELOG_OKAY),
      path: "documentation/changelog_$locale.md",
      onButtonPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
