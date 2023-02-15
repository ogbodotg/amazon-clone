import 'package:amazon_clone/admin/products/add_product_screen.dart';
import 'package:amazon_clone/admin/services/backend_services.dart';
import 'package:amazon_clone/constants/globals.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/products/product.dart';
import 'package:amazon_clone/services/services.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  static const String routeName = '/product-screen';

  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final AdminServices _adminServices = AdminServices();
  List<Product>? productLists;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
  }

  getProducts() async {
    productLists = await _adminServices.getAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    _adminServices.deleteProduct(
        context: context,
        product: product,
        onSuccess: () {
          productLists!.removeAt(index);
          setState(() {});
        });
  }

  void navigateToAddProductScreen() {
    Navigator.pushNamed(context, AddProduct.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Services.CustomAdminAppBar(title: 'Products'),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddProductScreen,
        child: Icon(Icons.add),
        tooltip: 'Add Product',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: productLists == null
          ? Globals.loader()
          : GridView.builder(
              itemCount: productLists!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final productData = productLists![index];
                return Column(
                  children: [
                    SizedBox(
                      height: 140,
                      child: ProductWidget(image: productData.productImages[0]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            productData.productName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              deleteProduct(productData, index);
                            },
                            icon: const Icon(Icons.delete_outline))
                      ],
                    )
                  ],
                );
              }),
    );
  }
}
