import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit(): super(LocalizationState(appLocal:"uz" ));
  void changeLocal(LangCodes langCode) async {
    // await DBService.storeLocal(langCode.name);
    // emit(LocalizationState(appLocal: langCode.name));
  }
}
