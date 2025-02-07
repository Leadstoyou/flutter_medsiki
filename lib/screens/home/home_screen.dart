import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:untitled/base/base._repository.dart';
import 'package:untitled/screens/home/e_learning/course_list_screen.dart';
import 'package:untitled/screens/home/mom_and_child/mom_and_child_screen.dart';
import 'package:untitled/screens/home/onboarding/home_onboarding_screen.dart';
import 'package:untitled/screens/home/payment/payment.dart';
import 'package:untitled/screens/home/record/medical_record_screen.dart';
import 'package:untitled/screens/profile/notification.dart';
import 'package:untitled/screens/profile/profile_screen.dart';
import 'package:untitled/screens/profile/settings.dart';
import 'package:untitled/utils/common.dart';
import 'dart:ui';

import 'package:untitled/widgets/common.dart';

import '../../models/my_user.dart';
import '../../utils/local_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<MyUser?> _userData;
  final BaseRepository<Map<String, dynamic>> courseRepository =
      BaseRepository<Map<String, dynamic>>('courses');
  final BaseRepository<Map<String, dynamic>> newsRepository =
      BaseRepository<Map<String, dynamic>>('news');

  dynamic listSuggestCourses;
  dynamic listSuggestNews;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    getListSuggestCourses();
    _userData = getUserFromLocalStorage();
  }

  Future<void> getListSuggestCourses() async {
    setState(() {
      _isLoading = true;
    });

    final courses = await courseRepository.findAll();
    final news = await newsRepository.findAll();

    setState(() {
      listSuggestCourses = courses;
      listSuggestNews = news;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (_isLoading) {
    //   return Container(
    //     color: Color(0xFFFFD1D6),
    //     child: Center(
    //       child: LoadingAnimationWidget.twoRotatingArc(
    //           color: Colors.white, size: 200),
    //     ),
    //   );
    // }

    return UserDataWidget(
        userDataFuture: _userData,
        builder: (user) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: Row(
                children: [
                  Expanded(child: _userCard(user)),
                ],
              ),
              leadingWidth: 200,
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    reusableIcon(
                      imagePath: 'assets/images/noti.png',
                      onTap: () {
                        navigate(context, NotificationScreen());
                      },
                    ),
                    reusableIcon(
                      imagePath: 'assets/images/settings.png',
                      onTap: () {
                        navigate(context, SettingsScreen());
                      },
                    ),
                    reusableIcon(
                      imagePath: 'assets/images/search.png',
                      onTap: () {
                        print('Search Icon tapped!');
                      },
                    ),
                  ],
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: Colors.grey[100],
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage('assets/images/cpr.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Cơ hội thực hành\nkỹ năng sơ cấp cứu',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF990011),
                                      fontFamily: 'Manrope Bold'),
                                ),
                                const SizedBox(height: 10),
                                const Divider(
                                  color: Color(0xFF990011),
                                  thickness: 1,
                                  indent: 0,
                                  endIndent: 0,
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Góp phần phòng tránh tai nạn thương tích và '
                                  'giảm thiểu hậu quả tai nạn ở cộng đồng',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF990011),
                                      fontFamily: 'Manrope Regular'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () {
                              navigate(context, HomeOnboardingScreen());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFC62E2E),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                            child: const Text(
                              'Tìm hiểu thêm',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Manrope Bold',
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Khóa học',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF990011),
                      fontFamily: 'Manrope SemiBold',
                    ),
                  ),
                  const Divider(
                    color: Color(0xFFFFD1D6),
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                  ),
                  const SizedBox(height: 10),
                  // Grid of categories
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1.2,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CourseListScreen(0)),
                          );
                        },
                        child: _buildCategoryCard(
                          'Thường gặp',
                          'assets/images/bandage.png',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CourseListScreen(1)),
                          );
                        },
                        child: _buildCategoryCard(
                          'Bệnh nền',
                          'assets/images/heart_rate.png',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CourseListScreen(2)),
                          );
                        },
                        child: _buildCategoryCard(
                          'Phân biệt',
                          'assets/images/brain.png',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CourseListScreen(3)),
                          );
                        },
                        child: _buildCategoryCard(
                          'Bệnh nhi',
                          'assets/images/body.png',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Gợi ý section
                  SizedBox(
                    height: 35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Gợi ý',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Manrope SemiBold',
                              color: const Color(0xFF990011)),
                        ),
                        TextButton(
                          onPressed: () {
                            // Handle "Khác" button press
                          },
                          child: const Text(
                            'Khác',
                            style: TextStyle(
                                color: Color(0xFF93000A),
                                fontFamily: 'Manrope SemiBold',
                                decoration: TextDecoration.underline,
                                decorationColor: Color(0xFF93000A)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Color(0xFFFFD1D6),
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                  ),
                  const SizedBox(height: 10),
                  for (var course in (listSuggestCourses ?? []).take(2))
                    _buildSuggestionCard(
                      course['title'],
                      course['description'],
                      course['thumbnail'],
                    ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Dịch vụ',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Manrope SemiBold',
                              color: Color(0xFF990011))),
                      TextButton(
                        onPressed: () {
                          // Handle "Khác" button press
                        },
                        child: const Text(
                          'Khác',
                          style: TextStyle(
                              fontFamily: 'Manrope SemiBold',
                              color: Color(0xFF93000A),
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0xFF93000A)),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Color(0xFFFFD1D6),
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildServiceItem('assets/images/home_road.png',
                          'Lộ trình theo\nyêu cầu',
                      onTapFunc: () => {
                        navigate(context, Home('title'))
                      },),
                      _buildServiceItem(
                          'assets/images/overweight.png', 'Mẹ và bé',
                          onTapFunc: () {
                        navigate(context, MomAndChildScreen());
                      }),
                      _buildServiceItem(
                        'assets/images/home_record.png',
                        'Bản ghi',
                        onTapFunc: () {
                          navigate(context, MedicalRecordScreen());
                        },
                      ),
                      _buildServiceItem(
                          'assets/images/home_progress.png', 'Tiến độ',
                          onTapFunc: () {
                        navigate(context, CourseListScreen(100));
                      }),
                    ],
                  ),

                  // Tin tức section
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tin tức',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Manrope SemiBold',
                            color: Color(0xFF990011)),
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle "Khác" button press
                        },
                        child: const Text(
                          'Khác',
                          style: TextStyle(
                              fontFamily: 'Manrope SemiBold',
                              color: Color(0xFF93000A),
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0xFF93000A)),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Color(0xFFFFD1D6),
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                  ),
                  const SizedBox(height: 10),
                  for (var news in (listSuggestNews ?? []).take(2))
                    _buildSuggestionCard(
                      news['title'],
                      news['description'],
                      news['thumbnail'],
                    ),
                  // Cập nhật thông tin section
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: 350,
                      child: Card(
                        color: Color(0xFF990011), // Màu nền của card
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Cập nhật thông tin\n',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        height: 2,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Giúp bạn theo dõi sức khỏe',
                                      style: TextStyle(
                                          fontSize: 16,
                                          height: 2.25,
                                          color: Color(0xFFFFD1D6)),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFD1D6),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    color: Color(0xFF93000A),
                                  ),
                                ),
                                onPressed: () {
                                  // Handle button press
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Image.asset('assets/images/subscribes.png')
                ],
              ),
            ),
            bottomNavigationBar: buildBottomNavigationBar(context, 0),
          );
        });
  }

  Widget _buildSuggestionCard(
      String title, String description, String imagePath) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Color(0xFF990011),
          width: 1.4,
        ),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.memory(
                  base64ToBytes(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$title\n',
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Manrope SemiBold',
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: description,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Manrope ExtraLight',
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem(String imagePath, String text,
      {VoidCallback? onTapFunc}) {
    return InkWell(
      onTap: onTapFunc,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFFFD1D6),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                imagePath,
                width: 40,
                height: 40,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'Manrope SemiBold',
                  color: Color(0xFF990011)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _userCard(MyUser? user) {
    return InkWell(
      onTap: () {
        navigate(context, ProfileScreen());
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: (user?.avatar != null
                      ? MemoryImage(base64Decode(user!.avatar!))
                      : AssetImage('assets/images/default_avatar.png')
                          as ImageProvider),
                ),
                Positioned(
                  bottom: -4,
                  right: -1,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.pink,
                    child: Icon(Icons.edit, size: 12, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Xin Chào",
                  style: TextStyle(
                    color: Color(0xFF93000A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user?.fullName ?? '',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, String imagePath) {
    return Card(
      color: const Color(0xFF93000A),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontFamily: 'Manrope Regular',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget reusableIcon({
    required String imagePath,
    required VoidCallback onTap,
    double width = 35.0,
    double height = 35.0,
    EdgeInsetsGeometry margin = const EdgeInsets.only(right: 10.0),
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
