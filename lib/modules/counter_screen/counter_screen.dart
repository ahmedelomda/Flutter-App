import 'package:flutter/material.dart';
import 'package:flutter_app/modules/counter_screen/cubit/cubit.dart';
import 'package:flutter_app/modules/counter_screen/cubit/states.dart';
import 'package:flutter_app/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state) {
          // if(state is CounterMinusState){
          //   print('minus');
          // }
          //
          // if(state is CounterPlusState) {
          //   print(state.text);
          // }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Counter',
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120.0,
                        child: defaultButton(
                          whenPress: () {
                            CounterCubit.get(context).decrement();
                          },
                          text: 'minus',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: Text(
                          '${CounterCubit.get(context).counter}',
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                      Container(
                        width: 120.0,
                        child: defaultButton(
                          whenPress: () {
                            CounterCubit.get(context).increment();
                          },
                          text: 'plus',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Container(
                    child: defaultButton(
                      fullWidth: false,
                      whenPress: () {
                        CounterCubit.get(context).reset();
                      },
                      text: 'Reset',
                      background: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// states
// counter screen
