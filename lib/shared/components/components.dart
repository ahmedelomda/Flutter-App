// reuse of components
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/cubit/cubit.dart';
import 'package:flutter_app/modules/contacts_screen/contacts_screen.dart';

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  @required String label,
  @required IconData icon,
  @required Function onSubmit,
  @required Function onChange,
}) =>
    TextField(
      controller: controller,
      keyboardType: type,
      onSubmitted: onSubmit,
      onChanged: onChange,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        prefixIcon: Icon(
          icon,
        ),
      ),
    );

Widget defaultButton({
  @required Function whenPress,
  Color background = Colors.teal,
  @required String text,
  Color textColor = Colors.white,
  bool fullWidth = true,
  double width,
  bool upperCase = true,
}) =>
    Container(
      width: fullWidth ? double.infinity : width ?? null,
      child: MaterialButton(
        height: 40.0,
        onPressed: whenPress,
        color: background,
        child: Text(
          upperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );

Widget contactItem({
  @required ContactsModel model,
}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            child: Text(
              model.code,
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  model.number,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget taskItem(Map item, context) => Dismissible(
      onDismissed: (direction) {
        TodoCubit.get(context).deleteData(item['id']);
      },
      key: Key('${item['id']}'),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text(item['status']),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'],
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        item['data'],
                      ),
                      Spacer(),
                      IconButton(
                          icon: CircleAvatar(
                            radius: 15,
                            child: Icon(
                              Icons.done,
                              size: 14,
                            ),
                          ),
                          onPressed: () {
                            TodoCubit.get(context).updateData(
                              status: 'done',
                              id: item['id'],
                            );
                          }),
                      IconButton(
                          icon: CircleAvatar(
                            radius: 15,
                            child: Icon(
                              Icons.archive_outlined,
                              size: 14,
                            ),
                          ),
                          onPressed: () {
                            TodoCubit.get(context).updateData(
                              status: 'archived',
                              id: item['id'],
                            );
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

Widget tasksBuilder(list) => ConditionalBuilder(
  condition: list != null,
  builder: (context) => ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
      itemBuilder: (context, index) => taskItem(list[index], context),
      separatorBuilder: (context, index) => myDivider(),
      itemCount: list.length,
    ),
    fallback: (context) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        [
          Icon(
            Icons.today_outlined,
            size: 100.0,
            color: Colors.grey,
          ),
          Text(
            'No Tasks Yet, Please Add Some Tasks',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ),
  ),
  fallback: (context) => Center(
    child: CircularProgressIndicator(),
  ),
);

Widget buildNewsItem(article, context) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      children:
      [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10.0,
            ),
            image: DecorationImage(
              image: NetworkImage(
                '${article['urlToImage']}',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${article['title']}',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Spacer(),
              Text(
                '${article['publishedAt']}',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

Widget newsBuilder(list, context) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (context) => ListView.separated(
    physics: BouncingScrollPhysics(),  //shape of scroll
    itemBuilder: (context, index) => buildNewsItem(list[index], context),
    separatorBuilder: (context, index) => myDivider(),
    itemCount: list.length,
  ),
  fallback: (context) => Center(child: CircularProgressIndicator()),
);