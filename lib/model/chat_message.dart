import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String id;
  final String senderId;
  final String senderName;
  final String profileUrl;
  final String countryFlagUrl;
  final String? recieverId;
  final String? recieverName;
  final String? recieverProfileUrl;
  final String message;
  final String messageType;
  final DateTime timestamp;
  final bool? read;
  final bool? isReported;
  final String? recieverFcmToken;
  final String? senderFcmToken;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.profileUrl,
    this.recieverId,
    this.recieverName,
    this.recieverProfileUrl,
    required this.countryFlagUrl,
    required this.message,
    required this.messageType,
    required this.timestamp,
    this.read,
    this.isReported,
    this.recieverFcmToken,
    this.senderFcmToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderName': senderName,
      'profileUrl': profileUrl,
      'recieverId': recieverId,
      'recieverName': recieverName,
      'recieverProfileUrl': recieverProfileUrl,
      'countryFlagUrl': countryFlagUrl,
      'message': message,
      'messageType': messageType,
      'timestamp': timestamp,
      'read': read,
      'isReported': isReported,
      'recieverFcmToken': recieverFcmToken,
      'senderFcmToken': senderFcmToken,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map, String id) {
    return ChatMessage(
      id: id,
      senderId: map['senderId'] ?? '',
      senderName: map['senderName'] ?? '',
      profileUrl: map['profileUrl'] ?? '',
      recieverId: map['recieverId'] ?? '',
      recieverName: map['recieverName'] ?? '',
      recieverProfileUrl: map['recieverProfileUrl'] ?? '',
      countryFlagUrl: map['countryFlagUrl'] ?? '',
      message: map['message'] ?? '',
      messageType: map['messageType'] ?? 'text',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      read: map['read'] ?? false,
      isReported: map['isReported'] ?? false,
      recieverFcmToken: map['recieverFcmToken'] ?? '',
      senderFcmToken: map['senderFcmToken'] ?? '',
    );
  }
}
