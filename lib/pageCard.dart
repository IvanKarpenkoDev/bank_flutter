import 'package:bank_flutter/depositPage.dart';
import 'package:bank_flutter/deposits.dart';
import 'package:bank_flutter/perevodPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

class CardPage extends StatefulWidget {
  final String? IdCard;

  CardPage({Key? key, required this.IdCard}) : super(key: key);

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card'),
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 91, 0, 157), //change your color here
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: CardList1(IdCard: widget.IdCard),
      ),
    );
  }
}

class CardList1 extends StatelessWidget {
  final String? IdCard;

  CardList1({required this.IdCard});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('cards')
          .doc(IdCard)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        Map<String, dynamic>? data =
            snapshot.data?.data() as Map<String, dynamic>?;

        if (data == null) {
          return Text('No data found for the specified UID.');
        }

        String cardTypeString = data['cardType'];
        CardType cardType;

        if (cardTypeString == "visa") {
          cardType = CardType.visa;
        } else {
          cardType = CardType.mastercard;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 220,
              child: GestureDetector(
                onTap: () {
                  cong.flipcard();
                  cong1.flipcard();
                },
                child: CardItem(
                  cardNumber: data['cardNumber'],
                  cardHolderName: data['cardHolderName'],
                  expiryDate: data['expiryDate'],
                  cardType: cardType,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 20, left: 15),
                child: Center(
                  child: Text(
                    data['balance'].toString() + " ₽",
                    style: TextStyle(fontSize: 20),
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 15),
              child: Text(
                "Сервисы",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(top: 20, left: 0),
                    child: Column(
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TransferPage(IdCard: IdCard),
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: 4.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Container(
                                    height: 165,
                                    width:
                                        170, // Установите желаемую высоту для карточки
                                    padding:
                                        EdgeInsets.only(top: 15, bottom: 30),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Icon(
                                            Icons.compare_arrows_outlined,
                                            size: 35,
                                            color:
                                                Color.fromARGB(255, 76, 0, 130),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 20)),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          padding: EdgeInsets.only(left: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Перевести",
                                                style: TextStyle(fontSize: 17),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                "Перевод денег на другие счета и тд.",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _showBottomSheet(context);
                                },
                                child: Card(
                                  elevation: 4.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Container(
                                    height: 165,
                                    width:
                                        170, // // Установите желаемую высоту для карточки
                                    padding:
                                        EdgeInsets.only(top: 15, bottom: 30),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Icon(
                                            Icons.add_circle_outline,
                                            size: 35,
                                            color:
                                                Color.fromARGB(255, 76, 0, 130),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 20)),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          padding: EdgeInsets.only(left: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Пополнить",
                                                style: TextStyle(fontSize: 17),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                "Пополнить баланс карты",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DepositPage(IdCard: IdCard),
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: 4.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Container(
                                    height: 165,
                                    width:
                                        170, // // Установите желаемую высоту для карточки
                                    padding:
                                        EdgeInsets.only(top: 15, bottom: 30),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Icon(
                                            Icons.add_circle_outline,
                                            size: 35,
                                            color:
                                                Color.fromARGB(255, 76, 0, 130),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 20)),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          padding: EdgeInsets.only(left: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Вклад",
                                                style: TextStyle(fontSize: 17),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                "Оформление вклада по счеты",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Deposits(idCard: IdCard),
                          ),
                        );
                      },
                      child: Container(
                          width: 200,
                          height: 50,
                          child: Center(child: Text("Вклады"))))
                ],
              ),
            )
          ],
        );
      },
    );
  }

  void updateBalance() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collectionReference = firestore.collection('cards');
    DocumentReference documentReference = collectionReference.doc(IdCard);

    try {
      // Get the document snapshot
      DocumentSnapshot documentSnapshot = await documentReference.get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Get the document data
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;

        // Check if the 'balance' field exists in the data
        if (data != null && data.containsKey('balance')) {
          // Get the value from _balanceUser
          String balanceText =
              _balanceUser.text.trim(); // Remove leading/trailing white spaces

          // Validate the input value
          if (isPositiveInteger(balanceText)) {
            // Get the current value of the 'balance' field
            int currentBalance = data['balance'] as int;

            // Parse the value from _balanceUser
            int balanceToAdd = int.tryParse(balanceText) ??
                0; // Use `tryParse()` to handle invalid integer input gracefully

            // Calculate the new balance value
            int newBalance = currentBalance + balanceToAdd;

            // Update the 'balance' field in Firestore with the new value
            await documentReference.update({'balance': newBalance});

            print('Balance successfully updated');
          } else {
            print('Invalid balance input');
          }
        } else {
          print('Field "balance" not found');
        }
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error updating balance: $e');
    }
  }

// Check if a string is a positive integer
  bool isPositiveInteger(String str) {
    final regExp = RegExp(r'^[1-9]\d*$');
    return regExp.hasMatch(str);
  }

  int balanceCount = 0;
  TextEditingController _balanceUser = TextEditingController();
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(12), topLeft: Radius.circular(12)),
          ),
          height: 500,
          padding: EdgeInsets.all(26.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Пополнить баланс',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 26.0),
              TextFormField(
                controller: _balanceUser,
                decoration: InputDecoration(
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                  ),
                  hintText: "Введите сумму пополнения",
                  labelStyle: TextStyle(fontSize: 15),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 0.5),
                  ),
                ),
              ),
              SizedBox(height: 26.0),
              FractionallySizedBox(
                widthFactor:
                    0.6, // Установите желаемый ширина кнопки (например, 80% от доступной ширины)
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 76, 0, 130)),
                    ),
                    onPressed: () {
                      updateBalance();
                    },
                    child: Text(
                      'Пополнить',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

final con = FlipCardController();
final con1 = FlipCardController();
final cong = GestureFlipCardController();
final cong1 = GestureFlipCardController();

enum CardType { visa, mastercard }

class CardItem extends StatelessWidget {
  // final String str = _buildCardTypeIcon();
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final CardType cardType;

  CardItem({
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cardType,
  });
  String get cardTypeIcon {
    switch (cardType) {
      case CardType.visa:
        return 'lib/icons/visa2.png';
      case CardType.mastercard:
        return 'lib/icons/master_card2.png';
      default:
        return 'lib/icons/visa2.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          child: GestureFlipCard(
            controller: cong1,
            axis: FlipAxis.vertical,
            enableController: true,
            animationDuration: const Duration(milliseconds: 1000),
            // elevation: 4.0,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(12.0),
            // ),
            frontWidget: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(155, 14, 0, 35),
                      Color.fromARGB(120, 58, 0, 100),
                      Color.fromARGB(159, 81, 0, 138),
                      Color.fromARGB(168, 57, 0, 97),
                      Color.fromARGB(142, 17, 0, 34),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding:
                    EdgeInsets.only(bottom: 16, top: 10, left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      cardTypeIcon,
                      width: 53,
                      height: 53,
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      cardNumber,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 3),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Владелец',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      cardHolderName,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Срок действия',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          expiryDate,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 11,
                    ),
                  ],
                ),
              ),
            ),
            backWidget: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(155, 14, 0, 35),
                      Color.fromARGB(120, 58, 0, 100),
                      Color.fromARGB(159, 81, 0, 138),
                      Color.fromARGB(168, 57, 0, 97),
                      Color.fromARGB(142, 17, 0, 34),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: EdgeInsets.only(
                  bottom: 16,
                  top: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15.0),
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(color: Colors.black),
                    ),
                    SizedBox(height: 16.0),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        children: [
                          Container(
                              width: 200,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 86, 86, 86),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [Text("200")],
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 60,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 148, 148, 148),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'lib/icons/bank.png',
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "ВаноБанк",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }

  String _buildCardTypeIcon() {
    switch (cardType) {
      case CardType.visa:
        return 'lib/icons/visa.png';
      case CardType.mastercard:
        return 'lib/icons/master_card2.png';
      default:
        return 'lib/icons/visa2.png';
    }
  }
}
