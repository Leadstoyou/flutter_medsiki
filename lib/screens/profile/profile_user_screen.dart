import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/base/base._repository.dart';
import 'package:untitled/models/my_user.dart';
import 'package:untitled/utils/common.dart';
import 'package:untitled/utils/local_storage.dart';
import 'package:untitled/utils/util.dart';
import 'package:untitled/widgets/common.dart';

class ProfileUserScreen extends StatefulWidget {
  const ProfileUserScreen({Key? key}) : super(key: key);

  @override
  State<ProfileUserScreen> createState() => _ProfileUserScreenState();
}

class _ProfileUserScreenState extends State<ProfileUserScreen> {
  late MyUser _user;
  bool _isLoading = true; // Add a loading state
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String? _avatarPath;
  final BaseRepository<Map<String, dynamic>> _userRepository =
      BaseRepository<Map<String, dynamic>>('users');

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _mobileController.dispose();
    _dobController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> getUser() async {
    var user = await getUserFromLocalStorage();
    print(user);

    if (user != null) {
      setState(() {
        _user = user;
        _fullNameController.text = _user.fullName ?? '';
        _mobileController.text = _user.mobile ?? '';
        _dobController.text = _user.dob ?? '';
        _emailController.text = _user.email ?? '';
        _isLoading = false;
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (pickedFile != null) {
      setState(() {
        _avatarPath = pickedFile.path;
      });
    } else {
      print('No image selected');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _dobController.text =
            "${pickedDate.day} / ${pickedDate.month} / ${pickedDate.year}";
      });
    }
  }

  Future<void> _submitProfileUpdate() async {
    try {
      if (!isValidPhoneNumber(_mobileController.text.trim())) {
        setState(() {
          _isLoading = false;
        });
        showToast(message: 'Số điện thoại không hợp lệ');
        return;
      }
      final updatedUser = {
        'fullName': _fullNameController.text,
        'mobile': _mobileController.text,
        'dob': _dobController.text,
        'email': _emailController.text,
      };
      if (_avatarPath != null) {
        updatedUser['avatar'] = base64Encode( File(_avatarPath!).readAsBytesSync());
      }

      final value = await _userRepository.update(_user.id ?? "", updatedUser);
      await saveUserToLocalStorage(
          MyUser.fromJson(castToMap(value as dynamic)));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hồ sơ đã được cập nhật!')),
      );
    } catch (e) {
      print('Error updating profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Có lỗi xảy ra khi cập nhật hồ sơ.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
          child:
              CircularProgressIndicator()); // Show loading indicator while user is being fetched
    }
    return Scaffold(
      appBar: buildCommonAppBar(context, 'Hồ sơ'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Color(0xFF990011),
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(0, 16, 0, 25),
              child: Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: _avatarPath != null
                          ? FileImage(File(_avatarPath!))
                          : (_user.avatar != null
                              ? MemoryImage(base64Decode(_user.avatar!))
                              : AssetImage('assets/images/default_avatar.png')
                                  as ImageProvider),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Color(0xFF93000A),
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  _inputField('Họ và tên', _fullNameController),
                  _inputField('Số điện thoại', _mobileController),
                  _inputField('Email', _emailController, isEmail: true),
                  _inputField('Ngày sinh', _dobController, isDate: true),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: _submitProfileUpdate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF93000A),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text(
                  'Cập nhật hồ sơ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField(String title, TextEditingController controller,
      {bool isDate = false, bool isEmail = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Manrope Medium',
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          readOnly: isDate,
          enabled: !isEmail,
          onTap: isDate ? () => _selectDate(context) : null,
          // Mở trình chọn ngày nếu là ngày sinh
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFFFD1D6),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            suffixIcon: isDate
                ? const Icon(
                    Icons.calendar_today,
                    color: Color(0xFF93000A),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
