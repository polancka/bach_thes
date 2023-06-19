import 'package:cloud_firestore/cloud_firestore.dart';

/* This is where global variables are stored */
final db = FirebaseFirestore.instance;

int nextUserId = 1;

incrementNextUserId() {
  nextUserId = nextUserId + 1;
}
