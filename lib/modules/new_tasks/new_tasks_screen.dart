import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/cubit/cubit.dart';
import 'package:flutter_app/layout/cubit/states.dart';
import 'package:flutter_app/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NewTasks extends StatelessWidget {
  var titleController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (context, state) {
        if(state is TodoInsertDatabaseSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state){

        var list = TodoCubit.get(context).newTasks;

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showBottom(context);
              // insertToDb();
              // updateData();
              // deleteData();

              // try
              // {
              //   String name = await getData();
              //   print(name);
              // } catch(e)
              // {
              //   print(e.toString());
              // }

              // getData().then((value)
              // {
              //   print(value);
              // }).catchError((e)
              // {
              //   print(e.toString());
              // });
            },
            child: Icon(
                Icons.add
            ),
          ),
          body: tasksBuilder(list),
        );
      },
    );
  }

  // Future
  // async
  // await

  void showBottom(BuildContext context)
  {
    showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.grey[100],
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                defaultFormField(
                  controller: titleController,
                  type: TextInputType.text,
                  label: 'Task Title',
                  icon: Icons.title,
                  onSubmit: (String value) {},
                  onChange: (String char) {},
                ),
                SizedBox(
                  height: 10.0,
                ),
                defaultFormField(
                  controller: dateController,
                  type: TextInputType.datetime,
                  label: 'Task Date',
                  icon: Icons.date_range,
                  onSubmit: (String value) {},
                  onChange: (String char) {},
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultButton(
                  text: 'add',
                  background: Colors.blue,
                  whenPress: ()
                  {
                    String title = titleController.text;
                    String date = dateController.text;

                    if(title.isEmpty || date.isEmpty)
                    {
                      Fluttertoast.showToast(
                        msg: 'please insert a valid data',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 5,
                        backgroundColor: Colors.amber,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );

                      return;                // stop at here
                    }

                    TodoCubit.get(context).insertToDb(
                      title: title,
                      date: date,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

