import 'package:flutter/material.dart';
import 'package:untitled/base/base._repository.dart';
import 'package:untitled/screens/store/product_info_screen.dart';
import 'package:untitled/utils/common.dart';
import 'package:untitled/widgets/common.dart';
import 'package:intl/intl.dart';
class StoreScreen extends StatefulWidget {
  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final BaseRepository<Map<String, dynamic>> productsRepository =
  BaseRepository<Map<String, dynamic>>('products');

  // Khởi tạo listProducts là Future
  late Future<List<Map<String, dynamic>>> listProducts;

  @override
  void initState() {
    super.initState();
    listProducts = getProductData();
  }

  Future<List<Map<String, dynamic>>> getProductData() async {
    try {
      return await productsRepository.findAll();
    } catch (e) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF990011),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Cửa Hàng',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: 'Manrope'),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: listProducts,  // Truyền Future vào
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Lỗi khi tải dữ liệu'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Không có sản phẩm nào'));
            } else {
              var listProducts = snapshot.data!;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  childAspectRatio: 0.7,
                ),
                itemCount: listProducts.length,
                itemBuilder: (context, index) {
                  var product = listProducts[index];
                  return Container(
                    height: 900,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFD1D6),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, 4),
                          blurRadius: 6,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          width: 170,
                          height: 150,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Color(0xFF990011),
                                width: 2,
                              ),
                              image: DecorationImage(
                                image: MemoryImage(base64ToBytes(product['thumbnail'])),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: -1,
                                  left: -24,
                                  child: Image.asset(
                                    'assets/images/sale_tag.png',
                                    height: 50,
                                    width: 100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(product['title'],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Manrope Medium',
                              color: Colors.black,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Flexible(
                          child: SizedBox(
                            width: 170,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                 Text(
                                   "${NumberFormat.currency(locale: 'vi_VN', symbol: '').format(product['individualPrice'])}₫ -\n${NumberFormat.currency(locale: 'vi_VN', symbol: '').format(product['familyPrice'])}₫",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Manrope Regular',

                                    color: Colors.black,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    navigate(context, ProductInfoScreen(product));
                                  },
                                  child: Image.asset(
                                    'assets/images/bag.png',
                                    width: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context, 1),
    );
  }
}
