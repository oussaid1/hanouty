// enum FilterType {
//   all(),
//   month(),
//   custom(dateRange: dateRange);

//   const FilterType({this.dateRange});

//   /// range of dates
//   final MDateRange? dateRange;
// }

import 'package:flutter/material.dart';
enum DateFilter {
  all(),
  month(),
  custom(),
  Custom(), 
  final MDateRange? dateRange;
}

@immutable
class Custom {
 

  const Custom({this.dateRange});
}
