import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/screens/home/home_screen.dart';
import 'package:untitled/utils/common.dart';
import 'package:untitled/widgets/common.dart';
import 'package:untitled/widgets/config.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({Key? key}) : super(key: key);

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF93000A),
        title: const Text(
          '115',
          style: TextStyle(color: Colors.white, fontFamily: 'Manrope SemiBold'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Liên lạc bệnh viện gần nhất',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Manrope Medium',
                    color: Colors.black),
              ),
              SizedBox(height: 18),
              const Text(
                'Thành phố của bạn',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Manrope SemiBold',
                    color: Color(0xFF990011)),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Nhập tên của bạn',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Color(0xFF990011),
                        width: 1), // Border khi không focus
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Colors.blue, width: 2), // Border khi focus
                  ),
                ),
                onChanged: (value) {
                  print(
                      'Giá trị nhập: $value'); // Xử lý khi người dùng nhập dữ liệu
                },
              ),
              SizedBox(height: 18),
              const Text(
                'Địa chỉ của bạn',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Manrope SemiBold',
                    color: Color(0xFF990011)),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Nhập tên của bạn',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Color(0xFF990011),
                        width: 1), // Border khi không focus
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Colors.blue, width: 2), // Border khi focus
                  ),
                ),
                onChanged: (value) {
                  print(
                      'Giá trị nhập: $value'); // Xử lý khi người dùng nhập dữ liệu
                },
              ),
              SizedBox(height: 10),
              Center(
                child: const Text(
                  'Hỗ trợ định vị',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Manrope SemiBold',
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 10),
              Container(
                  alignment: Alignment.center,
                  width: 400,
                  height: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: GoogleMapWidget(
                    initialPosition: LatLng(21.0285, 105.8542),
                  ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context, 2),
    );
  }
}
