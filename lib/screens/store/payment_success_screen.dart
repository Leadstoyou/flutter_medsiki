import 'package:flutter/material.dart';
import 'package:untitled/base/base._repository.dart';
import 'package:untitled/screens/home/home_screen.dart';
import 'package:untitled/utils/common.dart';
import 'package:untitled/utils/local_storage.dart';
import 'package:untitled/widgets/Constant.dart';
import 'package:untitled/widgets/common.dart';

class PaymentSuccessScreen extends StatefulWidget {
  final dynamic address;
  final dynamic cartInfo;
  const PaymentSuccessScreen(this.address,this.cartInfo,{super.key});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  int _selectedAddress = 0;
  final BaseRepository<Map<String, dynamic>> cartRepository =
  BaseRepository<Map<String, dynamic>>('carts');


  @override
  void initState() {
    super.initState();
    createCart();
  }
  createCart() async{
    await cartRepository.create({
      'product': widget.cartInfo,
      'user': (await getUserFromLocalStorage())?.id,
      'address': widget.address,
      'orderAt': DateTime.now().toIso8601String(),
      'status' : OrderStatus.pending,
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCommonAppBar(context,  'Thanh Toán',isBack : false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 80, 40, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mua hàng thành công',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Manrope Medium',
                    color: Color(0xFF990011)),
              ),
              SizedBox(height: 18,),
              const Text(
                'Cảm ơn bạn đã mua hàng. Vui lòng chú ý điện thoại để nhận hàng.',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Manrope SemiBold',
                    color: Color(0xFF090F47)),
              ),
              SizedBox(height: 18,),
              Image.asset('assets/images/checkmark.png' ,height: 300,width: 400,),
              SizedBox(height: 18,),
              Center(
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      navigate(context, HomeScreen());
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
                      'Quay về cửa hàng',
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
