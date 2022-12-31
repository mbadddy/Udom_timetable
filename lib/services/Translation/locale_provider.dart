import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/cupertino.dart';
import 'package:udom_timetable/services/Translation/Locales.dart';

class LocaleProvider extends ChangeNotifier{
   Locale? _locale;
  Locale? get locale=>_locale;
  void setLocale(Locale locale){
    if(!L10n.all.contains(locale)) return;
    _locale=locale;
    notifyListeners();
  }
  void clearLocale(){
    _locale=null;
    notifyListeners();
  }
}