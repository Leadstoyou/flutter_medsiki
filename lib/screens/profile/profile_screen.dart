import 'package:flutter/material.dart';
import 'package:untitled/models/my_user.dart';
import 'package:untitled/screens/profile/help_center.dart';
import 'package:untitled/screens/profile/profile_user_screen.dart';
import 'package:untitled/screens/profile/purchase_list_screen.dart';
import 'package:untitled/screens/profile/settings.dart';
import 'package:untitled/utils/common.dart';
import 'package:untitled/utils/local_storage.dart';
import 'package:untitled/widgets/common.dart';
import 'package:untitled/widgets/menu_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late  MyUser _user;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getUser();
  }

  Future<void> getUser() async {
    var user = await getUserFromLocalStorage();
    print(user);
    setState(() {
      _user = user!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF93000A),
        automaticallyImplyLeading: false,
        title: const Text(
          'Hồ sơ',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        // Cho phép cuộn khi nội dung quá dài
        child: Column(
          children: [
            Container(
              color: Color(0xFF93000A),
              padding: EdgeInsets.fromLTRB(20, 16, 0, 30),
              child: Row(
                children: [
                  Stack(children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: _user.avatar != null
                          ? MemoryImage(base64ToBytes(_user.avatar!))
                          : AssetImage('assets/images/default_avatar.png')
                              as ImageProvider,
                    ),
                  ]),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        _user.fullName ?? "",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _user.mobile ?? "",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _user.email ?? "",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  buildMenuItem('Hồ sơ', Icons.person, () {
                    navigate(context, ProfileUserScreen(), callback: () async {
                      setState(() {
                        getUser();
                      });
                    });
                  }),
                  buildMenuItem('Đã lưu', Icons.favorite, () {
                    // Xử lý khi nhấn vào mục "Đã lưu"
                  }),
                  buildMenuItem('Thanh toán', Icons.payment, () {
                    navigate(context, PurchaseListScreen());
                  }),
                  buildMenuItem('Chính sách', Icons.privacy_tip, () {
                    // Xử lý khi nhấn vào mục "Privacy Policy"
                  }),
                  buildMenuItem('Cài đặt', Icons.settings, () {
                    navigate(context, SettingsScreen());
                  }),
                  buildMenuItem('Trợ giúp', Icons.help, () {
                    navigate(context, HelpCenterScreen());
                  }),
                  const Divider(),
                  buildMenuItem('Đăng xuất', Icons.logout, () {
                    showLogoutToast(context);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context, 4),
    );
  }
}
