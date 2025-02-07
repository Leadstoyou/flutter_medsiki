import 'package:flutter/material.dart';
import 'package:untitled/widgets/common.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildCommonAppBar(context, 'Thông báo'),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF990011), // Màu nền
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Độ bo tròn
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                  ),
                  child: Text(
                    'Hôm nay',
                    style: TextStyle(
                      color: Colors.white, // Màu chữ
                      fontSize: 16,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Xử lý khi nhấn nút đánh dấu đã đọc tất cả
                  },
                  child: Text(
                    'Đánh dấu đã đọc tất cả',
                    style: TextStyle(color: Color(0xFF990011)),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey, // Màu của Divider
            thickness: 0.4, // Độ dày của Divider
            indent: 20, // Lùi vào từ mép trái
            endIndent: 20, // Lùi vào từ mép phải
          ),
          NotificationItem(
            icon: 'assets/images/noti_calendar.png',
            title: 'Đến giờ học rồi!',
            content:
                'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.',
            time: '2m',
          ),
          NotificationItem(
            icon: 'assets/images/noti_calendar.png',
            title: 'Đến giờ học rồi!',
            content:
                'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.',
            time: '2m',
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Màu nền
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color:  Color(0xFF990011), // Màu viền
                          width: 1.5, // Độ dày viền
                        )
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                  ),
                  child: Text(
                    'Hôm qua',
                    style: TextStyle(
                      color: Colors.black, // Màu chữ
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey, // Màu của Divider
            thickness: 0.4, // Độ dày của Divider
            indent: 20, // Lùi vào từ mép trái
            endIndent: 20, // Lùi vào từ mép phải
          ),
          NotificationItem(
            icon: 'assets/images/noti_calendar.png',
            title: 'Tin Tức',
            content:
            'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.',
            time: '2m',
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Màu nền
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color:  Color(0xFF990011), // Màu viền
                          width: 1.5, // Độ dày viền
                        )
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                  ),
                  child: Text(
                    '20 Tháng 10',
                    style: TextStyle(
                      color: Colors.black, // Màu chữ
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey, // Màu của Divider
            thickness: 0.4, // Độ dày của Divider
            indent: 20, // Lùi vào từ mép trái
            endIndent: 20, // Lùi vào từ mép phải
          ),
          NotificationItem(
            icon: 'assets/images/noti_message.png',
            title: 'Tin nhắn mới',
            content:
            'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.',
            time: '2m',
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatefulWidget {
  final String icon;
  final String title;
  final String content;
  final String time;

  const NotificationItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.content,
    required this.time,
  }) : super(key: key);

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isPressed = !isPressed;
        });
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: isPressed ? Color(0xFFFFD1D6) : Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 10,
                children: [
                  Image.asset(
                    widget.icon,
                    width: 60,
                    height: 60,
                  ),
                  SizedBox(
                    width: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 20, fontFamily: 'Manrope SemiBold'),
                        ),
                        Text(widget.content,
                            overflow: TextOverflow.ellipsis, maxLines: 2)
                      ],
                    ),
                  ),
                ],
              ),

                  Text(widget.time),
            ],
          ),
        ),
      ),
    );
  }
}
