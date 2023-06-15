import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;

int nextUserId = 1;

incrementNextUserId() {
  nextUserId = nextUserId + 1;
}
