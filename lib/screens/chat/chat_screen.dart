import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';
import 'package:untitled/base/chat_repository.dart';
import 'package:untitled/models/message.dart';
import 'package:untitled/utils/local_storage.dart';
import 'package:untitled/widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatRepository _chatRepository = ChatRepository();
  List<Message> _messages = [];
  late String userId;

  @override
  void initState() {
    super.initState();
    chat();
  }

  chat() async {
    userId = (await getUserFromLocalStorage())!.id ?? "";
    _chatRepository.listenToMessages(
        (await getUserFromLocalStorage())!.id ?? "", (messages) {
      setState(() {
        print('12345 $messages');
        _messages = messages;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF93000A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Chuyên Gia Y Tế',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true, 
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  Message message = _messages[index];
                  return _buildMessage(
                      message.text, message.sender == userId, message.timestamp);
                },
              ),
            ),
            _buildInputBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(String message, bool isMe, int timestamp) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: BubbleSpecialOne(
        text: message,
        isSender: isMe,
        color: isMe ? const Color(0xFFFFD1D6) : (Colors.grey[300] ?? Colors.grey),
        textStyle: TextStyle(
          fontSize: 15,
          color: Colors.black,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          fontFamily: 'Manrope',
        ),

      ),
    );
  }

  String _formatTimestamp(int timestamp) {
    final DateTime time = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return '${time.hour}:${time.minute}';
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: const Color(0xFF93000A),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.attach_file, color: Colors.white),
            onPressed: () {
              // Xử lý khi nhấn nút đính kèm
            },
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Nhập tin nhắn',
                hintStyle: TextStyle(color: Colors.white),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.mic, color: Colors.white),
            onPressed: () {
              // Xử lý khi nhấn nút micro
            },
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.white),
            onPressed: () async {
              String messageText = _messageController.text;
              String userSender = userId;
              Message message = Message(
                sender: userSender,
                receiver: '-OH8Ji1fTYf0VBeI0Zzy',
                text: messageText,
                timestamp: DateTime.now().millisecondsSinceEpoch,
              );
              if (messageText.isNotEmpty) {
                _chatRepository.sendMessageToUser(userSender, message);
                setState(() {
                  _messages.add(message);
                });
                _messageController.clear(); // Clear input after sending
              }
            },
          ),
        ],
      ),
    );
  }
}
