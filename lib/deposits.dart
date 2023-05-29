import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Deposits extends StatelessWidget {
  final String? idCard;

  Deposits({Key? key, required this.idCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Вклады'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('deposits')
            .where('idCard', isEqualTo: idCard)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Произошла ошибка'));
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<DocumentSnapshot> deposits = snapshot.data!.docs;

          return ListView.builder(
            itemCount: deposits.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> depositData =
                  deposits[index].data() as Map<String, dynamic>;
              String depositName = depositData['name'];
              int depositBalance = depositData['balance'];

              return ListTile(
                title: Text(depositName),
                subtitle: Text('Баланс: $depositBalance'),
              );
            },
          );
        },
      ),
    );
  }
}
