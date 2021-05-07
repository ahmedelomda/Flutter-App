abstract class CounterStates  {}    //can't make object from it.

class CounterInitialState extends CounterStates {}
class CounterPlusState extends CounterStates {
  final String text;
  CounterPlusState(this.text);
}

class CounterMinusState extends CounterStates {}
class CounterResetState extends CounterStates {}


