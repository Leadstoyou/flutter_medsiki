// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    sender: json['sender'] as String,
    receiver: json['receiver'] as String,
    text: json['text'] as String,
    timestamp: json['timestamp'] as int,
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
  'sender': instance.sender,
  'receiver': instance.receiver,
  'text': instance.text,
  'timestamp': instance.timestamp,
};