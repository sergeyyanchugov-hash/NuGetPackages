// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => '.NET Packages';

  @override
  String get searchHint => 'Поиск пакетов...';

  @override
  String get nothingFound => 'Ничего не найдено';

  @override
  String nothingFoundFor(String query) {
    return 'По запросу «$query» ничего не найдено';
  }

  @override
  String get resetSearch => 'Сбросить поиск';

  @override
  String get packageDetails => 'Детали пакета';

  @override
  String error(String error) {
    return 'Ошибка: $error';
  }

  @override
  String get backToHome => 'Вернуться на главный экран';

  @override
  String get availableVersions => 'Доступные версии';

  @override
  String get dependencies => 'Зависимости';
}
