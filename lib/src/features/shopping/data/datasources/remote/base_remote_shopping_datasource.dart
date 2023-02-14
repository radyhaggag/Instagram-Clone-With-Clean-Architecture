import '../../../domain/entities/product.dart';

import '../../../domain/entities/shopping_item.dart';

abstract class BaseRemoteShoppingDatasource {
  Future<List<ShoppingItem>> getProducts();
  Future<Product> getProduct(String productLink);
}
