
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/layout/new_app/cubit/states.dart';
import 'package:flutter_app/modules/news_app_screen/business_screen.dart';
import 'package:flutter_app/modules/news_app_screen/science_screen.dart';
import 'package:flutter_app/modules/news_app_screen/sports_screen.dart';
import 'package:flutter_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screen =
  [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
  ];

  List<String> title =
  [
    'Business',
    'Sports',
    'Science'
  ];

  void changeIndex(int index)
  {
    currentIndex = index;
    emit(NewsChangeBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness()
  {
    emit(NewsBusinessLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'business',
          'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
        },
    ).then((response) {
      print(response.data);
      business = response.data['articles'];
      print(business.length);

      emit(NewsBusinessSuccessState());

    }).catchError((error){
      emit(NewsBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports()
  {
    emit(NewsSportsLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country':'eg',
        'category':'sports',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((response) {
      print(response.data);
      sports = response.data['articles'];
      print(sports.length);

      emit(NewsSportsSuccessState());

    }).catchError((error){
      emit(NewsSportsErrorState(error.toString()));
    });
  }


  List<dynamic> science = [];

  void getScience()
  {
    emit(NewsScienceLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country':'eg',
        'category':'science',
        'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((response) {
      print(response.data);
      science = response.data['articles'];
      print(science.length);

      emit(NewsScienceSuccessState());

    }).catchError((error){
      emit(NewsScienceErrorState(error.toString()));
    });
  }

  bool isDark = false;

  void changeThemeMode ()
  {
    isDark = !isDark;
    emit(NewsChangeThemeModeState());
  }

// try
// {
//   Response response = await DioHelper.getData(
//     url: 'v2/top-headlines',
//     query:
//     {
//       'country':'eg',
//       'category':'business',
//       'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
//     },
//   );
//
//   print(response.data);
//   print(response.data['totalResults']);
//
//   emit(NewsBusinessSuccessState());
// } catch(error)
// {
//   print(error.toString());
//   emit(NewsBusinessErrorState(error.toString()));
// }

}