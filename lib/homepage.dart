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
        title: Text('Bank Cards'),
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

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;

            return CardItem(
              cardNumber: data['cardNumber'],
              cardHolderName: data['cardHolderName'],
              expiryDate: data['expiryDate'],
              cardType: data['cardType'] == 'visa' ? CardType.visa : CardType.mastercard,
            );
          }).toList(),
        );
      },
    );
  }
}

enum CardType { visa, mastercard }

class CardItem extends StatelessWidget {
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final CardType cardType;

  const CardItem({
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cardType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCardTypeIcon(),
            SizedBox(height: 16.0),
            Text(
              cardNumber,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Card Holder',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
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
                  'Expires',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
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
    );
  }

  Icon _buildCardTypeIcon() {
    switch (cardType) {
      case CardType.visa:
        return Icon(Icons.payment, color: Colors.blue, size: 40.0);
      case CardType.mastercard:
        return Icon(Icons.payment, color: Colors.orange, size: 40.0);
      default:
        return Icon(Icons.payment, color: Colors.grey, size: 40.0);
    }
  }
}