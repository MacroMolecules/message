import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:message/ui/pages/navigation_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // routes: {
      //   BasisConstant.routeMain: (ctx) => NavigationPage(),
      // },
      home: NavigationPage(),
      // locale: _locale,
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   CustomLocalizations.delegate
      // ],
      // supportedLocales: CustomLocalizations.supportedLocales,
    );
  }
}
