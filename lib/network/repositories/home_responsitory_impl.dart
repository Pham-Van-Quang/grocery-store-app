import 'package:grocery_store_app/network/data_state/data_state.dart';
import 'package:grocery_store_app/network/remote/apis/homepage_api.dart';
import 'package:grocery_store_app/network/remote/models/product_data.dart';
import 'package:grocery_store_app/network/repositories/home_responsitory.dart';

class HomeResponsitoryImpl implements HomeResponsitory {
  @override
  Future<DataState<GetProductListItemResponse>> getProductListItem() async {
    final response = await HomeApi().getProductListItem();
    if (response.responseCode == 200) {
      return DataSuccess(data: response);
    } else {
      return DataFailed();
    }
  }
}
