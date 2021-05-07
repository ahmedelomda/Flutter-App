import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/cubit/cubit.dart';
import 'package:flutter_app/layout/cubit/states.dart';
import 'package:flutter_app/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoneTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (context, state) {
      },
      builder: (context, state){

        var list = TodoCubit.get(context).doneTasks;

        return Scaffold(
          body: tasksBuilder(list),
        );
      },
    );
  }
}

