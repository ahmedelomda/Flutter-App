import 'package:flutter/material.dart';
import 'package:flutter_app/layout/new_app/cubit/cubit.dart';
import 'package:flutter_app/layout/new_app/cubit/states.dart';
import 'package:flutter_app/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScienceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return RefreshIndicator(
          onRefresh: () async
          {
            NewsCubit.get(context).getScience();
          },
            child: newsBuilder(NewsCubit.get(context).science, context)
        );
      },
    );
  }
}
