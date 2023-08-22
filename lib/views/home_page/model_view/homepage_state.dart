// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:grocery_store_app/network/remote/models/product_data.dart';

enum HomeDataState { initState, isLoading, isLoaded }

class HomepageState {
  final HomeDataState dataState;
  final List<ProductData> productList;
  final List<ProductData> filteredProductList;
  final List<ProductData> initialProductList;
  final bool isSearchFocused;
  final bool isSearching;
  HomepageState({
    required this.dataState,
    required this.productList,
    required this.filteredProductList,
    required this.initialProductList,
    required this.isSearchFocused,
    required this.isSearching,
  });

  HomepageState copyWith({
    HomeDataState? dataState,
    List<ProductData>? productList,
    List<ProductData>? filteredProductList,
    List<ProductData>? initialProductList,
    bool? isSearchFocused,
    bool? isSearching,
  }) {
    return HomepageState(
        dataState: dataState ?? this.dataState,
        productList: productList ?? this.productList,
        isSearchFocused: isSearchFocused ?? this.isSearchFocused,
        filteredProductList: filteredProductList ?? this.filteredProductList,
        initialProductList: initialProductList ?? this.initialProductList,
        isSearching: isSearching ?? this.isSearching);
  }
}
