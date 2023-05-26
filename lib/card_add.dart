import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';

class Card_Add extends StatefulWidget {
  const Card_Add({super.key});

  @override
  State<Card_Add> createState() => _Card_AddState();
}

class _Card_AddState extends State<Card_Add> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank'),
       
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: CardList(),
      ),
    );
  }
}

class CardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
