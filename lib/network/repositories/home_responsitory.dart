import 'package:grocery_store_app/network/data_state/data_state.dart';
import 'package:grocery_store_app/network/remote/models/product_data.dart';

abstract class HomeResponsitory {
  Future<DataState<GetProductListItemResponse>> getProductListItem();
}
