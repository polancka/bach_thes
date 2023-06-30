import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

/* This is where global variables are stored */
final db = FirebaseFirestore.instance;

int nextUserId = 1;

incrementNextUserId() {
  nextUserId = nextUserId + 1;
}

var currentHiker;
