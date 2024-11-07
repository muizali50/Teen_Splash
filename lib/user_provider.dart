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

  Future<void> sendPrivateTextMessage(
    String chatId,
    String senderId,
    String senderName,
    String profileUrl,
    String countryFlagUrl,
    String message,
    String otherUserId,
    String recieverId,
    String recieverName,
    String recieverProfileUrl,
    String type,
  ) async {
    if (user == null || message.trim().isEmpty) return;

    final newMessage = ChatMessage(
      id: '', // Firestore will auto-generate the ID
      senderId: senderId,
      senderName: senderName,
      profileUrl: profileUrl,
      recieverId: recieverId,
      recieverName: recieverName,
      recieverProfileUrl: recieverProfileUrl,
      countryFlagUrl: countryFlagUrl,
      message: message,
      messageType: 'text',
      timestamp: DateTime.now(),
      read: false,
    );

    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(newMessage.toMap());

    // Update the chatId document with last message details
    await _firestore.collection('chats').doc(chatId).set(
      {
        'lastMessage': message,
        'lastTimestamp': DateTime.now(),
        'messageCount': FieldValue.increment(1),
        'participants': FieldValue.arrayUnion([senderId, otherUserId]),
        'lastMessageType': type,
        'unreadCount.$recieverId': FieldValue.increment(1),
        'unreadCount.$senderId': 0,
      },
      SetOptions(merge: true),
    );
  }

  Future<void> sendPrivateImageMessage(
    String chatId,
    String senderId,
    String senderName,
    String profileUrl,
    String countryFlagUrl,
    File imageFile,
    String otherUserId,
    String recieverId,
    String recieverName,
    String recieverProfileUrl,
    String type,
  ) async {
    if (user == null) return;
    final fileRef = FirebaseStorage.instance
        .ref()
        .child('private_chat_images')
        .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
    await fileRef.putFile(imageFile);
    final imageUrl = await fileRef.getDownloadURL();

    final newMessage = ChatMessage(
      id: '',
      senderId: senderId,
      senderName: senderName,
      profileUrl: profileUrl,
      recieverId: recieverId,
      recieverName: recieverName,
      recieverProfileUrl: recieverProfileUrl,
      countryFlagUrl: countryFlagUrl,
      message: imageUrl,
      messageType: 'image',
      timestamp: DateTime.now(),
      read: false,
    );

    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(newMessage.toMap());

    await _firestore.collection('chats').doc(chatId).set(
      {
        'lastMessage': imageUrl,
        'lastTimestamp': DateTime.now(),
        'messageCount': FieldValue.increment(1),
        'participants': FieldValue.arrayUnion([senderId, otherUserId]),
        'lastMessageType': type,
        'unreadCount.$recieverId': FieldValue.increment(1),
        'unreadCount.$senderId': 0,
      },
      SetOptions(merge: true),
    );
  }

  String getChatId(String userId, String otherUserId) {
    return userId.compareTo(otherUserId) < 0
        ? '${userId}_$otherUserId'
        : '${otherUserId}_$userId';
  }
}
