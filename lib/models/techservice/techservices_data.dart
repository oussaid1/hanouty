part of 'techservice.dart';

class TechServicesData {
  List<TechServiceModel> techServices;
  TechServicesData({
    required this.techServices,
  });

  /// get count of techserviceSales
  int get salesCount => techServices.length;

// total product priceIn of all items in stock
  double get totalPriceInInStock {
    double mcount = 0;
    for (var element in techServices) {
      mcount += (element.priceIn);
    }
    return mcount;
  }

// total product priceOut of all items in stock
  double get totalPriceOutInStock {
    double mcount = 0;
    for (var element in techServices) {
      mcount += (element.priceOut);
    }
    return mcount;
  }

// get a list of distinct categories
  List<String> get distinctCategories {
    List<String> mcategories = [];
    for (var element in techServices) {
      if (!mcategories.contains(element.category)) {
        mcategories.add(element.category.toString());
      }
    }
    return mcategories;
  }

// get chartData of category counts in stock
  List<ChartData> get serviceCategorySumCounts {
    List<ChartData> mchartData = [];

    for (var element in distinctCategories) {
      mchartData.add(ChartData(
        label: element,
        count: techServices.where((e) => e.category == element).length,
      ));
    }
    return mchartData;
  }
}
