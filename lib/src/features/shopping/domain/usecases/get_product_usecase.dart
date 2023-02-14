import 'package:dartz/dartz.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/base_shopping_repo.dart';

class GetProductUseCase extends BaseUseCase<Product, String> {
  final BaseShoppingRepo shoppingRepo;

  GetProductUseCase(this.shoppingRepo);

  @override
  Future<Either<Failure, Product>> call(String params) async {
    return await shoppingRepo.getProduct(params);
  }
}
