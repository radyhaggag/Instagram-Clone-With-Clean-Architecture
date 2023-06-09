import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/product.dart';

import '../entities/shopping_item.dart';

abstract class BaseShoppingRepo {
  Future<Either<Failure, List<ShoppingItem>>> getProducts();
  Future<Either<Failure, Product>> getProduct(String productLink);
}
