import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../theme/theme_cubit.dart';
part 'home_state.dart';
bool superTema = false;
int upgradeCountLite=1;
int upgradeCountDark=2;
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  int clickCount = 0;
  List<String> messages = [];
  String message = '';

  void handleUpgrade()
  {
    clickCount -= 30;
    emit(ClickState(clickCount));
    upgradeCountDark*=2;
    upgradeCountLite*=2;
  }
  void handleAuto(ThemeMode themeMode) async
  {
    if(superTema == true)
    {
      while(superTema == true)
      {
        if(themeMode == ThemeMode.light)
          {
            await Future.delayed(const Duration(seconds: 1));
            clickCount+=upgradeCountLite;
            emit(ClickState(clickCount));
          }
        else if(themeMode == ThemeMode.dark)
          {
            await Future.delayed(const Duration(seconds: 1));
            clickCount+=upgradeCountDark;
            emit(ClickState(clickCount));
          }
        message = "Счет: $clickCount. Тема: ${themeMode.name}";
        messages.add(message);
      }
    }
  }

  void handlePlus(ThemeMode themeMode) {
    if (themeMode == ThemeMode.dark) {
      clickCount +=upgradeCountDark;
      emit(ClickState(clickCount));
    } else {
      clickCount+=upgradeCountLite;
      emit(ClickState(clickCount));
    }
    message = "Счет: $clickCount. Тема: ${themeMode.name}";
    messages.add(message);
  }

  void handleMinus(ThemeMode themeMode) {
    if (themeMode == ThemeMode.dark) {
      clickCount -= 2;
    } else {
      clickCount--;
    }
    message = "Счет: $clickCount. Тема: ${themeMode.name}";
    emit(ClickState(clickCount));
    messages.add(message);
  }

  void themeSwitched(BuildContext context) {
    messages.add(
        'Тема: ${context.read<ThemeCubit>().themeMode.name}');
  }
}
