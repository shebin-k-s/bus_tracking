
import 'package:bloc/bloc.dart';

part 'carousel_state.dart';

class CarouselCubit extends Cubit<CarouselState> {
  CarouselCubit() : super(CarouselState(0));

  void updateIndex(int index) {
    emit(CarouselState(index));
  }

  void reset(){
    emit(CarouselState(0));
  }
}
