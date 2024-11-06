import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String id;
  final String senderId;
  final String senderName;
  final String profileUrl;
  final String countryFlagUrl;
  final String message;
  final String messageType;
  final DateTime timestamp;
  final bool? read;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.profileUrl,
    required this.countryFlagUrl,
    required this.message,
    required this.messageType,
    required this.timestamp,
    this.read,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderName': senderName,
      'profileUrl': profileUrl,
      'countryFlagUrl': countryFlagUrl,
      'message': message,
      'messageType': messageType,
      'timestamp': timestamp,
      'read': read,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map, String id) {
    return ChatMessage(
      id: id,
      senderId: map['senderId'] ?? '',
      senderName: map['senderName'] ?? '',
      profileUrl: map['profileUrl'] ?? '',
      countryFlagUrl: map['countryFlagUrl'] ?? '',
      message: map['message'] ?? '',
      messageType: map['messageType'] ?? 'text',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      read: map['read'] ?? false,
    );
  }
}
