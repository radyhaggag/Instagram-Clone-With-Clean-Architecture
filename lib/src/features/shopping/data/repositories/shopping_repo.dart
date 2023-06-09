import '../../../../core/error/error_handler.dart';
import '../../../../core/error/error_messages.dart';
import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/connectivity_checker.dart';
import '../datasources/remote/base_remote_shopping_datasource.dart';
import '../../domain/entities/shopping_item.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/base_shopping_repo.dart';

import '../datasources/local/base_local_shopping_datasource.dart';

class ShoppingRepo implements BaseShoppingRepo {
  final BaseRemoteShoppingDatasource baseRemoteShoppingDatasource;
  final BaseLocalShoppingDatasource baseLocalShoppingDatasource;
  final BaseCheckInternetConnectivity baseCheckInternetConnectivity;
  ShoppingRepo({
    required this.baseRemoteShoppingDatasource,
    required this.baseLocalShoppingDatasource,
    required this.baseCheckInternetConnectivity,
  });

  @override
  Future<Either<Failure, Product>> getProduct(String productLink) async {
    try {
      if (await baseCheckInternetConnectivity.isConnected()) {
        final res = await baseRemoteShoppingDatasource.getProduct(productLink);
        return Right(res);
      } else {
        final res = baseLocalShoppingDatasource.getProduct(productLink);
        if (res == null) {
          const failure = Failure(ErrorMessages.networkConnectionFailed);
          return const Left(failure);
        }
        return Right(res);
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, List<ShoppingItem>>> getProducts() async {
    try {
      if (await baseCheckInternetConnectivity.isConnected()) {
        final res = await baseRemoteShoppingDatasource.getProducts();
        return Right(res);
      } else {
        final res = baseLocalShoppingDatasource.getProducts();
        if (res == null) {
          const failure = Failure(ErrorMessages.networkConnectionFailed);
          return const Left(failure);
        }
        return Right(res);
      }
    } catch (e) {
      final failure = ErrorHandler.handle(e).failure;
      return Left(failure);
    }
  }
}
