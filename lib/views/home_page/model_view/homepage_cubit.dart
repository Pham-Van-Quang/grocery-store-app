// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_store_app/network/data_state/data_state.dart';
import 'package:grocery_store_app/network/remote/models/product_data.dart';

import 'package:grocery_store_app/network/repositories/home_responsitory_impl.dart';
import 'package:grocery_store_app/views/home_page/model_view/homepage_state.dart';

class HomepageCubit extends Cubit<HomepageState> {
  TextEditingController search = TextEditingController();
  final HomeResponsitoryImpl _homeResponsitoryImpl;
  HomepageCubit(
    this._homeResponsitoryImpl,
  ) : super(HomepageState(
            dataState: HomeDataState.initState,
            productList: [],
            isSearchFocused: false,
            filteredProductList: [],
            isSearching: true,
            initialProductList: []));

  void getItems() async {
    emit(state.copyWith(dataState: HomeDataState.isLoading));
    final response = await _homeResponsitoryImpl.getProductListItem();
    if (response is DataSuccess) {
      emit(state.copyWith(
        productList: response.data?.productListItem ?? [],
        initialProductList: response.data?.productListItem ?? [],
      ));
    }
    emit(state.copyWith(dataState: HomeDataState.isLoaded));
  }

  void isSearchFocused() {
    emit(state.copyWith(
        isSearchFocused: !state.isSearchFocused, isSearching: true));
  }

  void filterProducts(String keyword) {
    List<ProductData> filteredList = [];

    if (keyword.isEmpty) {
      filteredList = state.initialProductList;
    } else {
      filteredList = state.initialProductList.where((item) {
        bool containsKeyword =
            item.name?.toLowerCase().contains(keyword.toLowerCase()) ?? false;
        return containsKeyword;
      }).toList();
    }
    emit(state.copyWith(
        filteredProductList: filteredList, isSearching: keyword.isNotEmpty));
  }
}
