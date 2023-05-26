import 'package:bank_flutter/pageCard.dart';
import 'package:bank_flutter/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank'),
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 91, 0, 157), //change your color here
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings, color: Color.fromARGB(255, 76, 0, 130),size: 30,),
            onPressed: () {
               Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsPage1(),
                            ),
                          );
            },
          ),
        ],
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
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('cards').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        List<DocumentSnapshot> documents = snapshot.data!.docs;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: documents.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> data =
                      documents[index].data() as Map<String, dynamic>;

                  String cardTypeString = data['cardType'];
                  CardType cardType;

                  if (cardTypeString == "visa") {
                    cardType = CardType.visa;
                  } else {
                    cardType = CardType.mastercard;
                  }

                  return Container(
                    width: 365, // Set the width for each card
                    child: CardItem(
                        cardNumber: data['cardNumber'],
                        cardHolderName: data['cardHolderName'],
                        expiryDate: data['expiryDate'],
                        cardType: cardType),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 10),
              child: Text(
                "Сервисы",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(top: 20, left: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CardPage(),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Container(
                            height: 150,
                            width:
                                155, // Установите желаемую высоту для карточки
                            padding: EdgeInsets.only(top: 15, bottom: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Icon(
                                    Icons.add_circle_outline,
                                    size: 35,
                                    color: Color.fromARGB(255, 76, 0, 130),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 20)),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  padding: EdgeInsets.only(left: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Оформить",
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "Карту и тд.",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CardPage(),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Container(
                            height: 150,
                            width:
                                155, // Установите желаемую высоту для карточки
                            padding: EdgeInsets.only(top: 15, bottom: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Icon(
                                    Icons.add_circle_outline,
                                    size: 35,
                                    color: Color.fromARGB(255, 76, 0, 130),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 20)),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  padding: EdgeInsets.only(left: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Оформить",
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "Карту и тд.",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CardPage(),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Container(
                            height: 150,
                            width:
                                155, // Установите желаемую высоту для карточки
                            padding: EdgeInsets.only(top: 15, bottom: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Icon(
                                    Icons.add_circle_outline,
                                    size: 35,
                                    color: Color.fromARGB(255, 76, 0, 130),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 20)),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  padding: EdgeInsets.only(left: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Оформить",
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "Карту и тд.",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            )
          ],
        );
      },
    );
  }
}

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
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CardPage(),
                  ),
                );
              },
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
