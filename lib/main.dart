import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/layout/cubit/cubit.dart';
import 'package:flutter_app/layout/new_app/cubit/cubit.dart';
import 'package:flutter_app/layout/new_app/cubit/states.dart';
import 'package:flutter_app/layout/new_app/news_layout.dart';

import 'package:flutter_app/modules/bmi_screen/bmi_screen.dart';
import 'package:flutter_app/modules/home_screen/column_row.dart';
import 'package:flutter_app/modules/counter_screen/counter_screen.dart';
import 'package:flutter_app/modules/home_screen/login_screen.dart';
import 'package:flutter_app/modules/setting_screen/setting_screen.dart';
import 'package:flutter_app/modules/setting_screen/updateSetting.dart';
import 'package:flutter_app/modules/home_screen/home_screen.dart';
import 'package:flutter_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/home_layout.dart';
import 'modules/contacts_screen/contacts_screen.dart';

import 'package:flutter_app/shared/bloc_observer.dart';
import 'package:bloc/bloc.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  DioHelper.init();
  // run My app method
  // param is object from Widget class
  runApp(MyApp());
}

// 1. stateless
// 2. stateful

// main class extends widget
class MyApp extends StatelessWidget {
  // main method of class to build screen UI
  @override
  Widget build(BuildContext context) {
    // material app object wrap all screens
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => TodoCubit()..openDb(),
        ),
        BlocProvider(
          create: (BuildContext context) => NewsCubit()..getBusiness()..getSports()..getScience(),
        ),
      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                ),
              ),
              primarySwatch: Colors.blue,
              textTheme: TextTheme(
                  subtitle1: TextStyle(
                    fontSize: 18,
                    height: 1.5,
                  )
              ),
            ),    // for light theme
            darkTheme: ThemeData(
              scaffoldBackgroundColor: Colors.white12,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.light,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.white12,
              ),
              textTheme: TextTheme(
                  subtitle1: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    height: 1.5,
                  )
              ),
            ),
            themeMode: NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: Directionality(
              textDirection: TextDirection.ltr,
              child: NewsHomeScreen(),
            ),
          );
        },
      ),
    );
  }
}