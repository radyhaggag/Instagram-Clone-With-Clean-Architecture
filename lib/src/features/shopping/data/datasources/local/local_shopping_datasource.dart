import '../../../../../core/utils/app_boxes.dart';
import '../../../domain/entities/shopping_item.dart';

import '../../../domain/entities/product.dart';

import 'base_local_shopping_datasource.dart';

class LocalShoppingDatasource implements BaseLocalShoppingDatasource {
  @override
  Product? getProduct(String productLink) {
    try {
      final product = AppBoxes.productsBox.values.firstWhere(
        (e) => e.link == productLink,
      );
      return product;
    } catch (_) {
      rethrow;
    }
  }

  @override
  List<ShoppingItem>? getProducts() {
    try {
      final items = AppBoxes.shoppingItemsBox.values.map((e) => e).toList();
      return items;
    } catch (_) {
      rethrow;
    }
  }
}
