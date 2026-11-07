// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => '.NET Packages';

  @override
  String get searchHint => 'Search packages...';

  @override
  String get nothingFound => 'Nothing found';

  @override
  String nothingFoundFor(String query) {
    return 'Nothing found for \"$query\"';
  }

  @override
  String get resetSearch => 'Reset search';

  @override
  String get packageDetails => 'Package Details';

  @override
  String error(String error) {
    return 'Error: $error';
  }

  @override
  String get backToHome => 'Back to Home';

  @override
  String get availableVersions => 'Available Versions';

  @override
  String get dependencies => 'Dependencies';
}
