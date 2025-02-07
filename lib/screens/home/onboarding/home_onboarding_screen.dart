import 'package:flutter/material.dart';
import 'package:untitled/screens/home/onboarding/home_onboarding_detail_screen.dart';
import 'package:untitled/utils/common.dart';

class HomeOnboardingScreen extends StatefulWidget {
  @override
  _CourseDetailsScreenState createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<HomeOnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  late double _screenHeight;

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFF990011)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Container(
              constraints: BoxConstraints(
                maxHeight: 600,
              ),
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  _buildCourseCard(
                    'assets/images/home_onboarding_1.png',
                    'Đào tạo lý thuyết trực tiếp kết hợp thực hành cơ bản',
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    '1.200.000',
                    '1.100.000',
                    'Ưu đãi người dùng mới',
                  ),
                  _buildCourseCard(
                    'assets/images/home_onboarding_2.png',
                    'Đào tạo lý thuyết trực tiếp kết hợp thực hành cơ bản',
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    '1.200.000',
                    '1.100.000',
                    'Ưu đãi người dùng mới',
                  ),
                  _buildCourseCard(
                    'assets/images/home_onboarding_3.png',
                    'Đào tạo lý thuyết trực tiếp kết hợp thực hành cơ bản',
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    '1.200.000',
                    '1.100.000',
                    'Ưu đãi người dùng mới',
                  ),
                ],
              ),
            ),
            _buildPageIndicator(3),
          ],
        ));
  }

  Widget _buildCourseCard(String imagePath, String title, String description,
      String oldPrice, String salePrice, String discount) {
    return Container(
      child: Stack(children: [
        SizedBox(
            width: double.infinity,
            child: Image.asset(
              'assets/images/home_onboarding_ellipse.png',
              fit: BoxFit.contain,
            )),
        Positioned(
          child: SizedBox(
            height: _screenHeight * 0.65,
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10)),
                        color: Color(0xFF990011)),
                    child: Image.asset(
                      imagePath,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Manrope Medium'),
                        ),
                        const SizedBox(height: 10),
                        // Course description
                        Text(
                          description,
                          style: const TextStyle(
                              fontSize: 14, fontFamily: 'Manrope Regular'),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              spacing: 20,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  spacing: 10,
                                  children: [
                                    Text(
                                      '$oldPriceđ',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0x50090F47),
                                          fontFamily: 'Manrope SemiBold',
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                    Text(
                                      '$salePriceđ',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Manrope SemiBold',
                                        color: Color(0xFF090F47),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  discount,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Manrope Regular',
                                    color: Color(0xFF990011),
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                              // navigate(context, HomeOnboardingDetailScreen(course));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide(
                                          color: Color(
                                              0xFF990011)) // Bo tròn góc 12px
                                      ),
                                  textStyle: const TextStyle(fontSize: 14),
                                  elevation: 0),
                              child: const Text(
                                'Thông tin',
                                style: TextStyle(
                                    color: Color(0xFF990011),
                                    fontFamily: 'Manrope Regular',
                                    fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_currentPage < 2)
        Positioned(
          right: 0,
          top: (MediaQuery.of(context).size.height - 380) / 2,
          child: IconButton(
            onPressed: () {
              if (_currentPage < 2) { // 2 là chỉ số trang cuối cùng
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
            icon: Container(
              padding: EdgeInsets.all(8), // Điều chỉnh kích thước vòng tròn
              decoration: BoxDecoration(
                color: Color(0xFFFFD1D6), // Màu nền vàng
                shape: BoxShape.circle, // Tạo hình vòng tròn
              ),
              child: Icon(
                Icons.arrow_forward,
                color: Color(0xFF990011),
                size: 30,
              ),
            ),
          ),
        ),
        if (_currentPage > 0)
        Positioned(
          left: 0,
          top: (MediaQuery.of(context).size.height - 380) / 2,
          child: IconButton(
            onPressed: () {
              if (_currentPage > 0) {
                _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
            icon: Container(
              padding: EdgeInsets.all(8), // Điều chỉnh kích thước vòng tròn
              decoration: BoxDecoration(
                color: Color(0xFFFFD1D6), // Màu nền vàng
                shape: BoxShape.circle, // Tạo hình vòng tròn
              ),
              child: Icon(
                Icons.arrow_back,
                color: Color(0xFF990011),
                size: 30,
              ),
            ),
          ),
        )
      ]),
    );
  }

  Widget _buildPageIndicator(int pageCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount, // Use the pageCount parameter
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                _currentPage == index ? const Color(0xFF990011) : Color(0xFFFFD1D6),
          ),
        ),
      ),
    );
  }
}
