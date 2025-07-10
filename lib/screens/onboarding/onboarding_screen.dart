import 'package:flutter/material.dart';
import 'package:untitled/screens/auth/welcome_screen.dart';
import 'package:untitled/utils/common.dart';

class OnboardingFirstScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingFirstScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_currentPage != 2)
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => WelcomeScreen()),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'Skip',
                          style: TextStyle(
                            color: Color(0xFF990011),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: [
                    _buildPage(
                      'assets/images/onboard_1_logo.png',
                      'Bổ sung kiến thức trong trường hợp khẩn cấp',
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    ),
                    _buildPage(
                      'assets/images/onboard_2_logo.png',
                      'Đăng ký khóa học kỹ năng sơ cấp cứu',
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
                    ),
                    _buildPage(
                      'assets/images/onboard_3_logo.png',
                      'Chung tay mỗi nhà đều có hộp sơ cấp cứu chuyên dụng',
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
                    ),
                  ],
                ),
              ),
              _buildPageIndicator(3),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentPage < 2) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    } else {
                      navigate(context, WelcomeScreen());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF93000A),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: Text(
                    (_currentPage != 2) ? 'Tiếp theo' : 'Bắt Đầu',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(String imagePath, String title, String description) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 600,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/onboarding_background.png'),
                fit: BoxFit
                    .cover, // Điều chỉnh cách ảnh nền được hiển thị trong Container
              ),
            ),
            child: Center(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover, // Cover the entire circular area
              ),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Color(0xFF93000A),
                fontFamily: 'Manrope'),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF252525),
                fontFamily: 'League Spartan'),
          ),
        ],
      ),
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
                _currentPage == index ? const Color(0xFF93000A) : Colors.grey,
          ),
        ),
      ),
    );
  }
}
