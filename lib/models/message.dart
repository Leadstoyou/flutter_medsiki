import 'package:json_annotation/json_annotation.dart';

import 'Model.dart';

part 'message.g.dart';

@JsonSerializable()
class Message implements Model {
  final String sender;
  final String receiver;
  final String text;
  final int timestamp;

  Message({
    required this.sender,
    required this.receiver,
    required this.text,
    required this.timestamp,
  });

  @override
  String toString() {
    return 'Message{sender: $sender, receiver: $receiver, text: $text, timestamp: $timestamp}';
  }

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
