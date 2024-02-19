// import 'package:Tiara_by_TJ/api/api_service.dart';
// import 'package:http/http.dart' as http;

// class PaymentHelper {
//   List<Map<String, dynamic>>? line_items;
//   List<Map<String, dynamic>>? meta_data;
//   int customerId;
//   Map<String, dynamic> billingData;

//   PaymentHelper(this.billingData, this.customerId, this.line_items, this.meta_data);

//   createDigiGoldOrderHelper() async {
//     http.Response response =
//                           await ApiService.createDigiGoldOrder(
//                               billingData,
//                               customerProvider.customerData[0]["id"],
//                               line_items,
//                               meta_data);
//   }
// }
