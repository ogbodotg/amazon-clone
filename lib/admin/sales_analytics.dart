import 'package:amazon_clone/admin/model/sales.dart';
import 'package:amazon_clone/admin/services/backend_services.dart';
import 'package:amazon_clone/services/services.dart';
import 'package:flutter/material.dart';

class SalesAnalytics extends StatefulWidget {
  const SalesAnalytics({super.key});

  @override
  State<SalesAnalytics> createState() => _SalesAnalyticsState();
}

class _SalesAnalyticsState extends State<SalesAnalytics> {
  final AdminServices _adminServices = AdminServices();
  int? totalSales;
  List<Sales>? sales;

  @override
  void initState() {
    super.initState();
    getSales();
  }

  getSales() async {
    var salesData = await _adminServices.getSalesAnalytics(context);
    totalSales = salesData['totalSales'];
    sales = salesData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return sales == null || totalSales == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: Services.CustomAdminAppBar(title: 'Your Sales Records'),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Total Sales: $totalSales',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
