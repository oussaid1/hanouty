// import 'package:hanouty/components.dart';
// import 'package:hanouty/models/product/product.dart';
// import 'package:hanouty/providers/product_search_list_provider.dart';
// import 'package:hanouty/widgets/charts/product_categories.dart';
// import 'package:flutter/material.dart';

// import '../../product/products_listview.dart';

// class SellProduct extends ConsumerWidget {
//   const SellProduct({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final List<ProductModel> filteredProductList =
//         ref.watch(searchfilteredProductListProvider);

//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Wrap(
//                 children: [
//                   SizedBox(
//                     width: 700,
//                     height: 700,
//                     child: ProductListView(
//                       productsList: filteredProductList,
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 420,
//                     height: 400,
//                     child: ProductCategoriesStockPieChart(),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
