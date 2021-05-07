import 'package:flutter/material.dart';
import 'package:flutter_app/shared/components/components.dart';

class ContactsModel {
  final String code;
  final String name;
  final String number;

  ContactsModel({
    this.code,
    this.name,
    this.number,
  });
}

List<ContactsModel> contactsList = [
  ContactsModel(
    code: 'A',
    name: 'Ahmed omda',
    number: '+0102653465',
  ),
  ContactsModel(
    code: 'F',
    name: 'Fady omda',
    number: '+0152553465',
  ),
  ContactsModel(
    code: 'M',
    name: 'Mohamed omda',
    number: '+0153693465',
  ),
  ContactsModel(
    code: 'N',
    name: 'Nader omda',
    number: '+01055521465',
  ),
  ContactsModel(
    code: 'A',
    name: 'Ahmed omda',
    number: '+0102653465',
  ),
  ContactsModel(
    code: 'F',
    name: 'Fady omda',
    number: '+0152553465',
  ),
  ContactsModel(
    code: 'M',
    name: 'Mohamed omda',
    number: '+0153693465',
  ),
  ContactsModel(
    code: 'N',
    name: 'Nader omda',
    number: '+01055521465',
  ),
  ContactsModel(
    code: 'A',
    name: 'Ahmed omda',
    number: '+0102653465',
  ),
  ContactsModel(
    code: 'F',
    name: 'Fady omda',
    number: '+0152553465',
  ),
  ContactsModel(
    code: 'M',
    name: 'Mohamed omda',
    number: '+0153693465',
  ),
  ContactsModel(
    code: 'N',
    name: 'Nader omda',
    number: '+01055521465',
  ),
];

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => contactItem(
            model: contactsList[index],
          ),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: contactsList.length,
      ),
    );
  }
}

// 1. item design.
// 2. create list view.
// 3. create list.
// 4. show items in list view