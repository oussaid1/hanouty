// import 'package:hanouty/local_components.dart';
// import 'package:hanouty/components.dart';

// import '../widgets/search_widget.dart';

// enum SearchBy {
//   barcode,
//   name,
//   category,
//   date,
//   quantity,
//   pricein,
//   priceout,
//   suplier,
// }

// final searchfilteredProductListProvider =
//     StateProvider<List<ProductModel>>((ref) {
//   List<ProductModel> productsfilteredByCat = [];

//   String filterText = ref.watch(searchTextProvider.state).state;

//   String? searchBy = ref.watch(selectedSearchCatProvider.state).state;

//   switch (searchBy) {
//     case 'All':
//       return productsfilteredByCat
//           .where((element) => element.productName
//               .toLowerCase()
//               .contains(filterText.toLowerCase()))
//           .toList();

//     case 'Barcode':
//       return productsfilteredByCat
//           .where((element) =>
//               element.barcode!.toLowerCase().contains(filterText.toLowerCase()))
//           .toList();

//     case 'Name':
//       return productsfilteredByCat
//           .where((element) => element.productName
//               .toLowerCase()
//               .contains(filterText.toLowerCase()))
//           .toList();

//     case 'Description':
//       return productsfilteredByCat
//           .where((element) => element.description!
//               .toLowerCase()
//               .contains(filterText.toLowerCase()))
//           .toList();

//     case 'Category':
//       return productsfilteredByCat
//           .where((element) => element.category!
//               .toLowerCase()
//               .contains(filterText.toLowerCase()))
//           .toList();

//     case 'Date':
//       return productsfilteredByCat
//           .where((element) => element.dateIn
//               .ddmmyyyy()
//               .toLowerCase()
//               .contains(filterText.toLowerCase()))
//           .toList();

//     case 'Quantity':
//       return productsfilteredByCat
//           .where((element) => element.quantity
//               .toString()
//               .toLowerCase()
//               .contains(filterText.toLowerCase()))
//           .toList();

//     case 'Price In':
//       return productsfilteredByCat
//           .where((element) => element.priceIn
//               .toString()
//               .toLowerCase()
//               .contains(filterText.toLowerCase()))
//           .toList();

//     case 'Price Out':
//       return productsfilteredByCat
//           .where((element) => element.priceOut
//               .toString()
//               .toLowerCase()
//               .contains(filterText.toLowerCase()))
//           .toList();

//     case 'Suplier':
//       return productsfilteredByCat
//           .where((element) => element.suplier
//               .toString()
//               .toLowerCase()
//               .contains(filterText.toLowerCase()))
//           .toList();

//     default:
//       return productsfilteredByCat;
//   }
// });

// final productCategoryListProvider = StateProvider<List<String>>((ref) {
//   var list = <String>[
//     'Phone',
//     'Smart Phone',
//     'Tablet',
//     'Charger',
//     'Cable',
//     'Case',
//     'Glass',
//     'HeadPhone',
//     'Earphone',
//     'Spearker',
//     'Electricity',
//     'Tandeuz',
//     'Pc',
//     'Pc Access',
//     'Accessoire',
//     'Tripods',
//     'Lighting',
//     'Battery',
//     'Recepteur',
//     'Phone Access',
//     'Radio',
//     'Other',
//     'new'
//   ];
//   return list;
// });
