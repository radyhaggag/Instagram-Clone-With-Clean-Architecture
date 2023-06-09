import 'package:dartz/dartz.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../../../core/error/failure.dart';
import '../entities/shopping_item.dart';
import '../repositories/base_shopping_repo.dart';

class GetProductsUseCase extends BaseUseCase<List<ShoppingItem>, void> {
  final BaseShoppingRepo shoppingRepo;

  GetProductsUseCase(this.shoppingRepo);

  @override
  Future<Either<Failure, List<ShoppingItem>>> call(void params) async {
    return await shoppingRepo.getProducts();
  }
}
