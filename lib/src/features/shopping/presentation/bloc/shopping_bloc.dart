import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/get_products_usecase.dart';

import '../../domain/entities/product.dart';
import '../../domain/entities/shopping_item.dart';
import '../../domain/usecases/get_product_usecase.dart';

part 'shopping_event.dart';
part 'shopping_state.dart';

class ShoppingBloc extends Bloc<ShoppingEvent, ShoppingState> {
  final GetProductsUseCase getProductsUseCase;
  final GetProductUseCase getProductUseCase;
  ShoppingBloc({
    required this.getProductsUseCase,
    required this.getProductUseCase,
  }) : super(ShoppingInitial()) {
    on<ShoppingEvent>((event, emit) async {
      if (event is GetShoppingItems) await _getShoppingItems(event, emit);
      if (event is GetProduct) await _getProduct(event, emit);
    });
  }

  _getShoppingItems(GetShoppingItems event, Emitter<ShoppingState> emit) async {
    emit(ShoppingItemsLoading());
    final res = await getProductsUseCase(null);
    res.fold(
      (l) => emit(ShoppingItemsLoadingFailed(l.message)),
      (r) => emit(ShoppingItemsLoadingSuccess(r)),
    );
  }

  _getProduct(GetProduct event, Emitter<ShoppingState> emit) async {
    emit(ProductLoading());
    final res = await getProductUseCase(event.productLink);
    res.fold(
      (l) => emit(ProductLoadingFailed(l.message)),
      (r) => emit(ProductLoadingSuccess(r)),
    );
  }
}
