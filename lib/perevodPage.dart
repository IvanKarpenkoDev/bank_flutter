import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransferPage extends StatefulWidget {
  final String? IdCard;
  TransferPage({Key? key, required this.IdCard}) : super(key: key);

  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  String? idCard;

  @override
  void initState() {
    super.initState();
    idCard = widget.IdCard;
  }

  TextEditingController _valueController = TextEditingController();
  TextEditingController _cardNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Value',
              ),
            ),
            TextField(
              controller: _cardNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Card Number',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                performTransfer();
              },
              child: Text('Transfer'),
            ),
          ],
        ),
      ),
    );
  }

  void performTransfer() async {
    String value = _valueController.text;
    String cardNumber = _cardNumberController.text;

    // Connect to Firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Get the sender's card document
    DocumentSnapshot? senderCard =
        await firestore.collection('cards').doc(idCard).get();

    if (senderCard != null) {
      int? senderBalance =
          (senderCard.data() as Map<String, dynamic>)['balance'];
      if (senderBalance != null) {
        // Query Firestore to find the recipient's card document with the matching card number
        QuerySnapshot recipientQuerySnapshot = await firestore
            .collection('cards')
            .where('cardNumber', isEqualTo: cardNumber)
            .get();

        if (recipientQuerySnapshot.docs.isNotEmpty) {
          // Retrieve the recipient's card document
          DocumentSnapshot recipientDocument = recipientQuerySnapshot.docs[0];
          String recipientCardDocumentId = recipientDocument.id;

          // Get the recipient's card document
          DocumentSnapshot? recipientCard = await firestore
              .collection('cards')
              .doc(recipientCardDocumentId)
              .get();

          if (recipientCard != null) {
            int? recipientBalance =
                (recipientCard.data() as Map<String, dynamic>)['balance'];
            if (recipientBalance != null) {
              int transferValue = int.parse(value);
              int newSenderBalance = senderBalance - transferValue;
              int newRecipientBalance = recipientBalance + transferValue;

              // Update the sender's card balance
              await firestore
                  .collection('cards')
                  .doc(idCard)
                  .update({'balance': newSenderBalance});

              // Update the recipient's card balance
              await firestore
                  .collection('cards')
                  .doc(recipientCardDocumentId)
                  .update({'balance': newRecipientBalance});
            }
          }
        }
      }
    }

    // Clear the input fields
    _valueController.clear();
    _cardNumberController.clear();
  }
}
