import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/screens/store/pay_info_screen.dart';
import 'package:untitled/utils/common.dart';

class CartScreen extends StatefulWidget {
  dynamic product;
  bool isFamily;
  CartScreen(this.product,this.isFamily,{Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _quantity = 1;
  dynamic product;
  late bool isFamily;
  late int productPrice;
  late int discountVoucher;
  late int itemDiscount;
  @override
  void initState() {
    super.initState();
    isFamily = widget.isFamily;
    product = widget.product;
    productPrice =  isFamily ? product['familyPrice'] : product['individualPrice'];
    discountVoucher= 0;
    itemDiscount= 0;
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
            'Giỏ Hàng',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '1 sản phẩm',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.memory(
                      base64ToBytes(product['thumbnail']), // Chuyển base64 thành bytes
                      height: 90,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          product['title'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                         Text(
                          isFamily ? 'Hộ gia đình' :'Cá nhân',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                         Text(
                          "${NumberFormat.currency(locale: 'vi_VN', symbol: '').format(isFamily ? product['familyPrice'] : product['individualPrice'])}₫",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Manrope SemiBold',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 34,
                        height: 1,
                        child: IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Color(0xFF990011),
                            size: 16,
                          ),
                          onPressed: () {
                            // Xử lý khi nhấn nút xóa sản phẩm
                          },
                        ),
                      ),
                      Container(
                        width: 115,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0x80FFD1D6),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 40,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFD1D6), // Màu nền
                                shape: BoxShape.circle, // Bo tròn
                              ),
                              child: IconButton(
                                icon:
                                    const Icon(Icons.remove, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    if (_quantity > 1) {
                                      _quantity--;
                                    }
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                              child: Text(
                                '$_quantity',
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            Container(
                              width: 40,
                              decoration: BoxDecoration(
                                color: Color(0xFF990011), // Màu nền
                                shape: BoxShape.circle, // Bo tròn
                              ),
                              child: IconButton(
                                icon:
                                    const Icon(Icons.add, color: Colors.white),
                                onPressed: () {
                                  setState(() {
                                    _quantity++;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            const Divider(
              color: Color(0xFFFFD1D6),
              thickness: 1,
              indent: 0,
              endIndent: 0,
              height: 25,
            ),
            const SizedBox(height: 32),
            const Text(
              'Thanh toán',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildBillItem('Tổng tiền hàng', "${NumberFormat.currency(locale: 'vi_VN', symbol: '').format(productPrice * _quantity)}₫"),
            _buildBillItem('Items Discount', '${NumberFormat.currency(locale: 'vi_VN', symbol: '').format(itemDiscount)}₫'),
            _buildBillItem('Phiếu giảm giá', '-${NumberFormat.currency(locale: 'vi_VN', symbol: '').format(discountVoucher)}₫'),
            _buildBillItem('Vận chuyển', 'Miễn phí'),
            const Divider(),
            _buildBillItem('Tổng', "${NumberFormat.currency(locale: 'vi_VN', symbol: '').format(productPrice * _quantity - discountVoucher -itemDiscount) }₫", isTotal: true),
            const SizedBox(height: 32),
            Center(
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    print(product);
                    navigate(context, PaymentInfoScreen({
                      'quantity' : _quantity,
                      'totalProductPrice' : productPrice * _quantity,
                      'itemDiscount' : itemDiscount,
                      'discountVoucher' : discountVoucher,
                      'totalPrice' : productPrice * _quantity - discountVoucher -itemDiscount,
                      'product' : {
                        'id' : product['id'],
                        'title' : product['title'],
                        'price' : product['price']
                      }
                    }));
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
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w900
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillItem(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Manrope Regular',
              color: isTotal ? null : Color(0x50090F47),
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Manrope SemiBold',
              color: isTotal ? null : Color(0xFF090F47),
              fontWeight: isTotal ? FontWeight.w900 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
