import 'package:flutter/material.dart';

class BmiScreen extends StatefulWidget {
  @override
  _BmiScreenState createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('BMI Calculater'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.red,
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children:
                    [
                      Icon(
                          Icons.mark_as_unread,
                        size: 100.0,
                      ),
                      Text('Male')
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.red,
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children:
                    [
                      Icon(
                        Icons.mark_as_unread,
                        size: 100.0,
                      ),
                      Text('Male')
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
