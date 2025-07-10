import 'package:flutter/material.dart';
import 'package:untitled/base/base._repository.dart';
import 'package:untitled/utils/util.dart';
import 'package:untitled/widgets/Constant.dart';
import 'package:untitled/widgets/common.dart';

import '../../utils/local_storage.dart';

class PurchaseListScreen extends StatefulWidget {
  const PurchaseListScreen({super.key});

  @override
  _PurchaseListScreenState createState() => _PurchaseListScreenState();
}

class _PurchaseListScreenState extends State<PurchaseListScreen> {

  late Future<List<dynamic>> _combinedPurchases;
  final BaseRepository<Map<String, dynamic>> paymentsRepository =
  BaseRepository<Map<String, dynamic>>('payments');
  final BaseRepository<Map<String, dynamic>> cartsRepository =
  BaseRepository<Map<String, dynamic>>('carts');


  @override
  void initState() {
    super.initState();
    _combinedPurchases = fetchCombinedPurchases();
  }

  Future<List<dynamic>> fetchCombinedPurchases() async {
    var userId = (await getUserFromLocalStorage())?.id ?? "";
    print(userId);
    var productPurchases = await cartsRepository.search('user', userId);
    print('productPurchases ${productPurchases}');
    var coursePurchases = await  paymentsRepository.search('user', userId);
    print('coursePurchases $coursePurchases');
    List<dynamic> combinedList = [...productPurchases, ...coursePurchases];
    print("combinedList1 ${combinedList}");
    try{
      combinedList.sort((a, b) => b.orderAt.compareTo(a.orderAt));
      
    }catch(e){print('e $e');}
    print("combinedList ${combinedList}");
    return combinedList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCommonAppBar(context, 'Lịch sử giao dịch'),
      body: FutureBuilder<List<dynamic>>(
        future: _combinedPurchases,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Lỗi tải dữ liệu"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Không có dữ liệu"));
          }

          List<dynamic> purchases = snapshot.data!;
          return ListView.builder(
            itemCount: purchases.length,
            itemBuilder: (context, index) {
              var purchase = purchases[index];
              bool isProduct = purchase?['address'] != null;

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(
                    isProduct ? purchase['product']['product']['title'] : "${purchase['course']['title']}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ngày mua: ${formatDateVN(purchase['orderAt'])}"
                            "${isProduct ? "\nSố lượng: ${purchase['product']['quantity']}" : ""}",
                      ),
                      if (isProduct) // ✅ Nếu là `product`, hiển thị trạng thái
                        Text(
                          "Trạng thái: ${getOrderStatusText(purchase['status'])}",
                          style: TextStyle(
                            color: getOrderStatusColor(purchase['status']),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                  trailing: isProduct
                      ? Text(
                    "Giá: ${purchase['product']['totalPrice']} ₫",
                    style: TextStyle(color: Colors.blue),
                  )
                      : Text(
                    "Giá: ${purchase['paid']} ₫",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
