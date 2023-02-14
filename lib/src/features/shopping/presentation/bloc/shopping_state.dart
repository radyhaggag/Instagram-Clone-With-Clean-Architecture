part of 'shopping_bloc.dart';

abstract class ShoppingState extends Equatable {
  const ShoppingState();

  @override
  List<Object> get props => [];
}

class ShoppingInitial extends ShoppingState {}

class ShoppingItemsLoading extends ShoppingState {}

class ShoppingItemsLoadingSuccess extends ShoppingState {
  final List<ShoppingItem> items;

  const ShoppingItemsLoadingSuccess(this.items);
}

class ShoppingItemsLoadingFailed extends ShoppingState {
  final String message;

  const ShoppingItemsLoadingFailed(this.message);
}

class ProductLoading extends ShoppingState {}

class ProductLoadingSuccess extends ShoppingState {
  final Product product;

  const ProductLoadingSuccess(this.product);
}

class ProductLoadingFailed extends ShoppingState {
  final String message;

  const ProductLoadingFailed(this.message);
}
