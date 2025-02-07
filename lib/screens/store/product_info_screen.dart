import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/screens/store/cart_screen.dart';
import 'package:untitled/utils/common.dart';

class ProductInfoScreen extends StatefulWidget {
  final dynamic product;

  const ProductInfoScreen(this.product, {super.key});

  @override
  State<ProductInfoScreen> createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {
  late dynamic product;
  bool isFamily = false;

  @override
  void initState() {
    super.initState();
    product = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF93000A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: const Text(
            'Thông tin',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product['title'],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Manrope Medium',

                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: MemoryImage(base64ToBytes(product['thumbnail'])),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  if (product['individualDiscountPrice'] > 0) ...[
                    Text(
                      "${NumberFormat.currency(locale: 'vi_VN', symbol: '').format(product['individualDiscountPrice'])}₫",
                      style: TextStyle(
                          fontFamily: 'Manrope SemiBold',
                          fontSize: 16,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          decorationColor: Colors.grey),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    "${NumberFormat.currency(locale: 'vi_VN', symbol: '').format(isFamily ? product['familyPrice'] : product['individualPrice'])}₫",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Manrope SemiBold',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Giảm giá lần đầu mua hàng',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      fontFamily: 'Manrope Regular',
                    ),
                  ),
                  InkWell(
                      onTap: () {},
                      child: Image.asset(
                        'assets/images/bag.png',
                        width: 30,
                      ))
                ],
              ),
              const Divider(
                color: Color(0xFFFFD1D6),
                thickness: 1,
                indent: 0,
                endIndent: 0,
                height: 25,
              ),
              const SizedBox(height: 5),
              const Text(
                'Tùy chọn',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF090F47),
                  fontFamily: 'Manrope Medium',
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isFamily = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isFamily ? Colors.white : Color(0xFF990011),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: isFamily ? Color(0xFF990011) : Colors.transparent,
                        ),
                      ),
                    ),
                    child:  Text(
                      'Cá nhân',
                      style: TextStyle(
                        color: isFamily ? Color(0xFF990011) : Colors.white,
                        fontFamily: 'Manrope SemiBold',
                        fontSize: 18,

                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isFamily = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isFamily ? Color(0xFF990011) : Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: isFamily ? Colors.transparent : Color(0xFF990011),
                        ),
                      ),
                    ),
                    child: Text(
                      'Hộ gia đình',
                      style: TextStyle(
                        color: isFamily ? Colors.white : Color(0xFF990011),
                        fontFamily: 'Manrope SemiBold',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Giới thiệu sản phẩm',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF090F47),
                  fontFamily: 'Manrope Medium',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product['description'],
                style: TextStyle(fontSize: 16,  color: Color(0xFF252525),
                    fontFamily: 'Manrope ExtraLight',)
              ),
              const SizedBox(height: 32),
              Center(
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      navigate(context, CartScreen(product,isFamily));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF93000A),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(
                        fontSize: 18,
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
}
