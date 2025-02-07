import 'package:untitled/models/message.dart';
import 'package:untitled/utils/common.dart';
import 'base._repository.dart'; // Import Model Message

class ChatRepository extends BaseRepository<Message> {
  ChatRepository() : super('messages');

  Future<void> listenToMessages(
      String userId, Function(List<Message>) onDataChanged) async {
    await databaseReference
        .orderByKey()
        .equalTo(userId)
        .onValue
        .listen((event) {
      if (event.snapshot.exists) {
        List<Map<String, dynamic>> results = [];
        Map? data = (event.snapshot.value as Map<dynamic, dynamic>)[userId] as Map<dynamic, dynamic>?;
        results.addAll(data!.entries.map((entry) {
          return {'id': entry.key, ...entry.value};
        }));
        results.sort((a, b) {
          return b['timestamp'].compareTo(a['timestamp']);
        });
        onDataChanged(List<Message>.from(results.map(
                (messageData) => Message.fromJson(castToMap(messageData)))));
      } else {
        print("No messages found for user: $userId");
      }
    });
  }

  Future<void> sendMessageToUser(String userId, Message message) async {
    try {
      await databaseReference.child(userId).push().set({
        'sender': message.sender,
        'receiver': message.receiver,
        'text': message.text,
        'timestamp': message.timestamp,
      });
    } catch (e) {
      print('Error sending message: $e');
    }
  }
}
