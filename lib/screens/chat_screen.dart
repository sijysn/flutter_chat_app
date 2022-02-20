import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chats/bcF7P04sIX66IAXh3gF7/messages')
              .snapshots(),
          builder: (ctx, streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: streamSnapshot.data.docs.length,
              itemBuilder: (ctx, index) => Container(
                padding: const EdgeInsets.all(8),
                child: Text(streamSnapshot.data.docs[index]['text']),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            FirebaseFirestore.instance
              .collection('chats/bcF7P04sIX66IAXh3gF7/messages')
              .add({
                'text': 'This was  added by clicking the button.'
              });
          },
        ));
  }
}
