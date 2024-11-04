import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:teen_splash/main.dart';
import 'package:teen_splash/model/app_user.dart';
import 'package:teen_splash/model/chat_message.dart';

class UserProvider extends ChangeNotifier {
  AppUser? user;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void setUser(AppUser user) {
    this.user = user;
    notifyListeners();
  }

  void getUser() async {
    String? userString = prefs.getString(
      'users',
    );
    if (userString != null) {
      user = AppUser.fromMap(
        json.decode(
          userString,
        ),
      );
    }
  }

  // Stream to get chat messages in real-time
  Stream<List<ChatMessage>> getChatMessages() {
    return _firestore
        .collection('chatroom')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => ChatMessage.fromMap(doc.data(), doc.id),
              )
              .toList(),
        );
  }

  // Send a text message
  Future<void> sendTextMessage(String senderId, String senderName,
      String profileUrl, String countryFlagUrl, String message) async {
    final chatMessage = ChatMessage(
      id: '', // Firestore will auto-generate the ID
      senderId: senderId,
      senderName: senderName,
      profileUrl: profileUrl,
      countryFlagUrl: countryFlagUrl,
      message: message,
      messageType: 'text',
      timestamp: DateTime.now(),
    );

    await _firestore.collection('chatroom').add(
          chatMessage.toMap(),
        );
  }

  // Send an image message
  Future<void> sendImageMessage(String senderId, String senderName,
      String profileUrl, String countryFlagUrl, File imageFile) async {
    final fileRef = FirebaseStorage.instance
        .ref()
        .child('chat_images')
        .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
    await fileRef.putFile(imageFile);
    final imageUrl = await fileRef.getDownloadURL();

    final chatMessage = ChatMessage(
      id: '',
      senderId: senderId,
      senderName: senderName,
      profileUrl: profileUrl,
      countryFlagUrl: countryFlagUrl,
      message: imageUrl,
      messageType: 'image',
      timestamp: DateTime.now(),
    );

    await _firestore.collection('chatroom').add(
          chatMessage.toMap(),
        );
  }
}
