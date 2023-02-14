import '../../../domain/entities/product.dart';
import '../../../domain/entities/shopping_item.dart';

abstract class BaseLocalShoppingDatasource {
  List<ShoppingItem>? getProducts();
  Product? getProduct(String productLink);
}
