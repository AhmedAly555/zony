// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get account => 'Account';

  @override
  String get myPodus => 'My PODUs';

  @override
  String get allParcels => 'All Parcels';

  @override
  String get unread => 'Unread';

  @override
  String get error => 'Error: ';

  @override
  String get noPodusFound => 'No PODUs found';

  @override
  String get noAddressAvailable => 'No address available';
}
