import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/modules/counter_screen/cubit/states.dart';

class CounterCubit extends Cubit<CounterStates>
{
  CounterCubit() : super(CounterInitialState());
  static CounterCubit get(context) => BlocProvider.of(context);
  //get it without creating object from CounterCubit

  //CounterCubit cu = BlocProvider.of(context);

  int counter = 3;

  void increment() {
    counter++;
    emit(CounterPlusState(
      'Hello from Cubit...Plus'
    ));
  }

  void decrement() {
    counter--;
    emit(CounterMinusState());
  }

  void reset() {
    counter = 0;
    emit(CounterResetState());
  }

}