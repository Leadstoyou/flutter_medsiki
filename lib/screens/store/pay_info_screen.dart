import 'package:flutter/material.dart';
import 'package:untitled/base/base._repository.dart';
import 'package:untitled/models/my_user.dart';
import 'package:untitled/screens/store/payment_success_screen.dart';
import 'package:untitled/utils/common.dart';
import 'package:untitled/utils/local_storage.dart';
import 'package:untitled/utils/util.dart';
import 'package:untitled/widgets/common.dart';

class PaymentInfoScreen extends StatefulWidget {
  final dynamic productInfo;
  const PaymentInfoScreen(this.productInfo,{Key? key}) : super(key: key);

  @override
  State<PaymentInfoScreen> createState() => _PaymentInfoScreenState();
}

class _PaymentInfoScreenState extends State<PaymentInfoScreen> {
  int _selectedAddress = 0;
  int _selectPayMethod = 0;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final BaseRepository<Map<String, dynamic>> userRepository =
      BaseRepository<Map<String, dynamic>>('users');
  late List<Map<String, String>> addresses = [];
  late dynamic productInfo;
  late MyUser _user;

  @override
  void initState() {
    super.initState();
    getUser();
    productInfo = widget.productInfo;
  }

  getUser() async {
    try {
      var user = await getUserFromLocalStorage();
      _user = user!;
      if (user.addresses != null) {
        setState(() {
          addresses = user.addresses!;
        });
      } else {
        print('Không tìm thấy địa chỉ trong dữ liệu người dùng.');
      }
    } catch (e) {
      print('Lỗi khi lấy thông tin người dùng1: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCommonAppBar(context, 'Thông Tin Thanh Toán'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Địa chỉ giao hàng',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Manrope Medium'),
              ),
              const SizedBox(height: 16),
              if (addresses.isNotEmpty)
                SizedBox(
                  height: 320,
                  child: ListView.builder(
                    itemCount: addresses.length,
                    itemBuilder: (context, index) {
                      Map<String, String> address = addresses[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: _buildAddressItem(
                          address['title']!,
                          address['phone']!,
                          address['address']!,
                          index,
                        ),
                      );
                    },
                  ),
                ),
              Align(
                alignment: Alignment.topRight,
                child: IntrinsicWidth(
                  child: ListTile(
                    leading: const Icon(Icons.add, color: Color(0xFF93000A)),
                    title: const Text(
                      'Thêm địa chỉ mới',
                      style: TextStyle(color: Color(0xFF93000A)),
                    ),
                    onTap: () {
                      _showAddAddressDialog();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Phương thức thanh toán',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF090F47),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.red, width: 1.6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Icon trong ô vuông đỏ
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFF93000A),
                        borderRadius: BorderRadius.circular(5), // Bo góc nhẹ
                      ),
                      child: Icon(
                        Icons.local_shipping, // Icon giao hàng
                        color: Colors.white, // Màu trắng
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 12), // Khoảng cách giữa icon và text
                    // Nội dung tiêu đề
                    Expanded(
                      child: Text(
                        'Thanh toán khi nhận hàng',
                        style: TextStyle(
                          color: Color(0xFF001B5E), // Màu chữ
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Radio<int>(
                      value: 0,
                      groupValue: _selectPayMethod,
                      activeColor: Color(0xFF93000A),
                      onChanged: (value) {
                        setState(() {
                          _selectPayMethod = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      navigate(context, PaymentSuccessScreen(addresses[_selectedAddress],productInfo));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF93000A),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text(
                      'Đặt hàng',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressItem(
      String title, String phone, String address, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.red, width: 1.6),
      ),
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      child: Row(
        children: [
          Radio(
            value: index,
            groupValue: _selectedAddress,
            onChanged: (value) {
              setState(() {
                _selectedAddress = value!;
              });
            },
            activeColor: const Color(0xFF93000A),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(phone),
                const SizedBox(height: 4),
                Text(address),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.grey),
            onPressed: () {
              // Khi nhấn nút chỉnh sửa địa chỉ, hiển thị modal với dữ liệu đã có
              _showEditAddressDialog(title, phone, address);
            },
          ),
        ],
      ),
    );
  }

  void _showAddAddressDialog() async {
    _nameController.clear();
    _phoneController.clear();
    _addressController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thêm địa chỉ mới',style:  TextStyle(
            fontFamily: 'Manrope Medium',
          )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Tên địa chỉ'),
              ),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Số điện thoại'),
              ),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Địa chỉ'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () async {
                String name = _nameController.text;
                String phone = _phoneController.text;
                String address = _addressController.text;

                setState(() {
                  addresses.add({
                    'title': name,
                    'phone': phone,
                    'address': address,
                  });
                });
                final updatedData = {
                  'addresses': addresses,
                };
                final value = await updateUser(updatedData);
                saveUserToLocalStorage(MyUser.fromJson(castToMap(value)));
                Navigator.pop(context);
              },
              child: const Text('Lưu'),
            ),
          ],
        );
      },
    );
  }


  Future<dynamic> updateUser(dynamic updatedData) async {
    if (_user.id != null && _user.id!.isNotEmpty) {
      return await userRepository.update(_user.id!, updatedData);
    }
  }
  void _showEditAddressDialog(String title, String phone, String address) {
    _nameController.text = title;
    _phoneController.text = phone;
    _addressController.text = address;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chỉnh sửa địa chỉ'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Tên địa chỉ'),
              ),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Số điện thoại'),
              ),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Địa chỉ'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () async {
                String name = _nameController.text;
                String phone = _phoneController.text;
                String address = _addressController.text;
                if (!isValidPhoneNumber(_phoneController.text.trim())) {
                  showToast(message: 'Số điện thoại không hợp lệ');
                  return;
                }
                setState(() {
                  addresses[_selectedAddress] = {
                    'title': name,
                    'phone': phone,
                    'address': address,
                  };
                });
                final updatedData = {
                  'addresses': addresses,
                };
                final value = await updateUser(updatedData);
                saveUserToLocalStorage(MyUser.fromJson(castToMap(value)));
                Navigator.pop(context);
              },
              child: const Text('Lưu'),
            ),
          ],
        );
      },
    );
  }
}
