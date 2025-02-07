import 'package:flutter/material.dart';
import 'package:untitled/screens/auth/welcome_screen.dart';
import 'package:untitled/screens/chat/chat_screen.dart';
import 'package:untitled/screens/emergency/emergency_screen.dart';
import 'package:untitled/screens/home/home_screen.dart';
import 'package:untitled/screens/profile/profile_screen.dart';
import 'package:untitled/screens/store/store_screen.dart';
import 'package:untitled/utils/common.dart';

import '../utils/local_storage.dart';

final List<Map<String, dynamic>> listNavBottom = [
  {
    'index': 0,
    'title': 'Trang Chủ',
    'redirect': HomeScreen(),
  },
  {
    'index': 1,
    'title': 'Cửa hàng',
    'redirect': StoreScreen(),
  },
  {
    'index': 2,
    'title': 'Gọi',
    'redirect': EmergencyScreen(),
  },
  {
    'index': 3,
    'title': 'Hỏi Đáp',
    'redirect': ChatScreen(),
  },
  {
    'index': 4,
    'title': 'Hồ sơ',
    'redirect': ProfileScreen(),
  },
];

Widget buildBottomNavigationBar(BuildContext context, int currentIndex) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFFFD1D6),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5), // Màu của shadow
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, -3),
        ),
      ],
    ),
    child: BottomNavigationBar(
      selectedItemColor:
          currentIndex == 2 ? Colors.white : const Color(0xFF93000A),
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedLabelStyle: const TextStyle(
        fontFamily: 'Manrope SemiBold',
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: 'Manrope Medium',
      ),
      currentIndex: currentIndex,
      onTap: (int index) {
        if (index == currentIndex) return;
        var redirectScreen = listNavBottom.firstWhere(
          (item) => item['index'] == index,
        )?['redirect'];

        navigate(context, redirectScreen);
      },
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Trang chủ',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.storefront),
          label: 'Cửa hàng',
        ),
        BottomNavigationBarItem(
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: -40,
                top: -47,
                child: Container(
                  width: 85,
                  height: 85,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF93000A),
                    border: Border.all(
                      color: Color(0xFFFFD1D6),
                      width: 8,
                    ),
                  ),
                  child: const Icon(
                    Icons.phone,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
              ),
              const Icon(
                Icons.phone,
                size: 1,
                color: Color(0xFF93000A),
              ),
            ],
          ),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.question_answer),
          label: 'Hỏi đáp',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Hồ sơ',
        ),
      ],
    ),
  );
}

PreferredSizeWidget buildCommonAppBar(BuildContext context,String appTitle,{bool isBack= true}){
  return (
      AppBar(
        backgroundColor: Color(0xFF990011),
        elevation: 0,
        leading: isBack ? IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ) : null,
        title:  Text(
          appTitle,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: 'Manrope'),
        ),
        centerTitle: true,
        automaticallyImplyLeading: isBack,
      )
  );
}
void showAuthToast(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: Color(0xFFFFE9EC),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Đăng ký để tiếp tục',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Đóng toast
                  },
                  child: const Text('Hủy'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF93000A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () {
                    // Xử lý khi nhấn nút "Đăng ký"
                  },
                  child: const Text('Đăng ký'),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

void showLogoutToast(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: Color(0xFFFFE9EC),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Bạn có chắc muốn đăng xuất không?',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Hủy'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF93000A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () async {
                  await deleteUser();
                  navigate(context, WelcomeScreen());
                  },
                  child: const Text('Đăng xuất'),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}