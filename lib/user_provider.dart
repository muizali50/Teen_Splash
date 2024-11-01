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

  Stream<List<ChatMessage>> getChatMessages() {
    return _firestore
        .collection('chat')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatMessage.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<void> sendTextMessage(String senderId, String senderName,
      String profileUrl, String countryFlagUrl, String message) async {
    await _firestore.collection('chat').add(
      {
        'senderId': senderId,
        'senderName': senderName,
        'profileUrl': profileUrl,
        'countryFlagUrl': countryFlagUrl,
        'message': message,
        'messageType': 'text',
        'timestamp': Timestamp.now(),
      },
    );
  }

  Future<void> sendFileMessage(
    String senderId,
    String senderName,
    String profileUrl,
    String countryFlagUrl,
    File file,
    String messageType,
  ) async {
    final fileRef = FirebaseStorage.instance.ref().child('chat_files').child(
          '${DateTime.now().toIso8601String()}_${file.path.split('/').last}',
        );
    final uploadTask = fileRef.putFile(file);
    final fileUrl = await (await uploadTask).ref.getDownloadURL();

    await _firestore.collection('chat').add(
      {
        'senderId': senderId,
        'senderName': senderName,
        'profileUrl': profileUrl,
        'countryFlagUrl': countryFlagUrl,
        'message': fileUrl,
        'messageType': messageType,
        'timestamp': Timestamp.now(),
      },
    );
  }

  Future<void> sendCameraMedia(
    String senderId,
    String senderName,
    String profileUrl,
    String countryFlagUrl,
    File cameraFile,
    bool isVideo,
  ) async {
    await sendFileMessage(
      senderId,
      senderName,
      profileUrl,
      countryFlagUrl,
      cameraFile,
      isVideo ? 'video' : 'image',
    );
  }
}
