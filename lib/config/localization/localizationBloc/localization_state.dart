part of 'localization_cubit.dart';

enum LangCodes { uz, ru,en }

class LocalizationState extends Equatable {
  const LocalizationState({required String appLocal}) : _appLocal = appLocal;
  final String _appLocal;
  @override
  List<Object?> get props => [_appLocal];
  Locale get appLocal {
    late final Locale locale;
    if( _appLocal == 'uz' ) {
      locale = const Locale('uz', 'UZ');
    } else if( _appLocal == 'en' ) {
      locale = const Locale('en', 'EN');
    } else {
      locale = const Locale('ru', 'RU');
    }

    return locale;
  }

  String get appLocalName => _appLocal;
}
