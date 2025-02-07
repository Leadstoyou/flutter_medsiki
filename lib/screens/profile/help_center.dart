import 'package:flutter/material.dart';
import 'package:untitled/widgets/common.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCommonAppBar(context, 'Help Center'),
      body: SingleChildScrollView(
          child: Column(children: [
        Container(
          width: double.infinity,
          color: Color(0xFF990011),
          padding: EdgeInsets.fromLTRB(0, 16, 0, 30),
          child: Column(
            children: [
              const Text(
                'How Can We',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Manrope SemiBold',
                    color: Colors.white),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 300,
                height: 60,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Tìm...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSectionTitle('FAQ',true),
                    _buildSectionTitle('Contact Us',false),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCategoryButton('Popular Topic',true),
                    _buildCategoryButton('General',false),
                    _buildCategoryButton('Services',false),
                  ],
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 8),
                _buildExpandableItem(
                  'Lorem Ipsum Dolor Sit Amet?',
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                      'Praesent pellentesque congue lorem, vel tincidunt tortor '
                      'placerat a. Proin ac diam quam. Aenean in sagittis '
                      'magna, ut feugiat diam.',
                ),
                _buildExpandableItem('Lorem Ipsum Dolor Sit Amet?', ''),
                _buildExpandableItem('Lorem Ipsum Dolor Sit Amet?', ''),
                _buildExpandableItem('Lorem Ipsum Dolor Sit Amet?', ''),
                _buildExpandableItem('Lorem Ipsum Dolor Sit Amet?', ''),
                _buildExpandableItem('Lorem Ipsum Dolor Sit Amet?', ''),
                _buildExpandableItem('Lorem Ipsum Dolor Sit Amet?', ''),
              ],
            ),
          ),
        ),
      ])),
    );
  }

  Widget _buildSectionTitle(String title, bool isSelected) {
    return ElevatedButton(
      onPressed: () {
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(
              color: isSelected ? Colors.transparent : Color(0xFF990011), // Màu viền
              width: 1.5, // Độ dày viền
            )
        ),
        backgroundColor: isSelected ? Color(0xFF990011) : Colors.white
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: !isSelected ? Colors.black: Colors.white
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String label,bool isSelected) {
    return ElevatedButton(
      onPressed: () {
        // Xử lý khi nhấn vào button
      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(
                color: isSelected ? Colors.transparent : Color(0xFF990011), // Màu viền
                width: 1.5, // Độ dày viền
              )
          ),
          backgroundColor: isSelected ? Color(0xFF990011) : Colors.white
      ),
      child: Text(label,style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: !isSelected ? Colors.black: Colors.white
      )),
    );
  }

  Widget _buildExpandableItem(String title, String content) {
    return ExpansionTile(
      title: Text(title),
      collapsedBackgroundColor: Colors.white,
      textColor: Color(0xFF990011),
      iconColor: Color(0xFF990011),
      collapsedTextColor: Colors.grey[800],
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(content),
        ),
      ],
    );
  }
}
