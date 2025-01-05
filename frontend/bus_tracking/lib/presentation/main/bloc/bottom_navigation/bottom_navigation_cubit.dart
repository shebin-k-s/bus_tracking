import 'dart:developer';

import 'package:bloc/bloc.dart';

part 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(BottomNavigationState(selectedIndex: 0));

  void updateIndex(int index) {
    emit(
      BottomNavigationState(selectedIndex: index),
    );
  }

  void reset() {
    log("called");
    emit(
      BottomNavigationState(selectedIndex: 0),
    );
  }
}
