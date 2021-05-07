import 'package:flutter/material.dart';
import 'package:flutter_app/layout/new_app/cubit/cubit.dart';
import 'package:flutter_app/layout/new_app/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(NewsCubit.get(context)
                .title[NewsCubit.get(context).currentIndex]),
            actions: [
              IconButton(icon: Icon(Icons.brightness_6_outlined), onPressed: () {
                NewsCubit.get(context).changeThemeMode();
              }),
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
            ],
          ),
          body: NewsCubit.get(context)
              .screen[NewsCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: NewsCubit.get(context).currentIndex,
            onTap: (index) {
              NewsCubit.get(context).changeIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Business',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sports_baseball),
                label: 'Sports',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.science),
                label: 'Science',
              ),
            ],
          ),
        );
      },
    );
  }
}
