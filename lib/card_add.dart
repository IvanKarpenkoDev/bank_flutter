import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:intl/intl.dart';
import 'package:faker/faker.dart';

class Card_Add extends StatefulWidget {
  const Card_Add({Key? key}) : super(key: key);

  @override
  State<Card_Add> createState() => _Card_AddState();
}

class _Card_AddState extends State<Card_Add> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Создать карту'),
        ),
        body: CardList());
  }
}

class CardList extends StatelessWidget {
  final TextEditingController cardHolderController = TextEditingController();

  late String cardType;

  void _addCardToCollection() {
    final String cardHolder = cardHolderController.text;
    // final String cardNumber = cardNumberController.text.replaceAll(RegExp(r'\s+\b|\b\s'), '');
    final String cardNumber = generateRandomCardNumber();
    final String currentDate = DateFormat('dd/MM').format(DateTime.now());

    FirebaseFirestore.instance.collection('cards').add({
      'cardHolderName': cardHolder,
      'cardNumber': cardNumber,
      'cardType': cardType,
      'expiryDate': currentDate,
      'balance': 0
    });
  }

  String generateRandomCardNumber() {
    final faker = Faker();
    String cardNumber = '';

    for (int i = 0; i < 16; i++) {
      if (i > 0 && i % 4 == 0) {
        cardNumber += ' ';
      }
      cardNumber += faker.randomGenerator.integer(9).toString();
    }

    return cardNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: Column(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Создание карты",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 300,
                  child: TextFormField(
                    controller: cardHolderController,
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                      hintText: "Владелец карты",
                      labelStyle: TextStyle(fontSize: 15),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 0.5),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 300,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                      hintText: "Тип карты",
                      labelStyle: TextStyle(fontSize: 15),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 0.5),
                      ),
                    ),
                    items: ["visa", "mastercard"]
                        .map((type) => DropdownMenuItem<String>(
                              value: type,
                              child: Text(type),
                            ))
                        .toList(),
                    onChanged: (value) {
                      cardType = value!;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Дата: ${DateFormat('dd/MM').format(DateTime.now())}",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: _addCardToCollection,
                  style: ElevatedButton.styleFrom(
                    backgroundColor : Color.fromARGB(255, 76, 0, 130),
                  ),
                  child: Container(
                     color: const Color.fromARGB(255, 76, 0, 130),
                    height: 50,
                    width: 200,
                    child: const Center(child: Text('Добавить карту', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
