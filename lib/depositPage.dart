import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DepositPage extends StatefulWidget {
  final String? IdCard;
  DepositPage({Key? key, required this.IdCard}) : super(key: key);

  @override
  _DepositPageState createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  String? idCard;

  @override
  void initState() {
    super.initState();
    idCard = widget.IdCard;
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();

  Future<void> _createDeposit() async {
    String name = _nameController.text;
    int balance = int.parse(_balanceController.text);

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Get the sender's card document
    DocumentSnapshot? senderCard =
        await firestore.collection('cards').doc(idCard).get();

    if (senderCard != null) {
      int? senderBalance =
          (senderCard.data() as Map<String, dynamic>)['balance'];
      if (senderBalance != null) {
        // Update the sender's card balance
        int newSenderBalance = senderBalance - balance;
        await firestore
            .collection('cards')
            .doc(idCard)
            .update({'balance': newSenderBalance});

        // Create a new deposit
        FirebaseFirestore.instance
            .collection('deposits')
            .add({'name': name, 'balance': balance, 'idCard': idCard}).then((value) {
          // Вклад успешно создан
          // Можете добавить здесь дополнительную обработку или переход на другую страницу
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Успех'),
                content: Text('Вклад успешно создан.'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Можете добавить здесь переход на другую страницу или обновление текущей
                    },
                  ),
                ],
              );
            },
          );
        }).catchError((error) {
          // Обработка ошибок при создании вклада
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Ошибка'),
                content: Text('Не удалось создать вклад: $error'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Оформление вклада'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Название вклада',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _balanceController,
              decoration: InputDecoration(
                labelText: 'Сумма',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Создать вклад'),
              onPressed: _createDeposit,
            ),
          ],
        ),
      ),
    );
  }
}
