import 'dart:developer';

import 'package:bloc/bloc.dart';

part 'carousel_state.dart';

class CarouselCubit extends Cubit<CarouselState> {
  CarouselCubit() : super(CarouselState(3));

  void updateIndex(int index) {
    log("index : ${index}");
    emit(CarouselState(index));
  }
}
