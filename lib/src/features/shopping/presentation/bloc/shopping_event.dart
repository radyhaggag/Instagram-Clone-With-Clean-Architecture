part of 'shopping_bloc.dart';

abstract class ShoppingEvent extends Equatable {
  const ShoppingEvent();

  @override
  List<Object> get props => [];
}

class GetShoppingItems extends ShoppingEvent {}

class GetProduct extends ShoppingEvent {
  final String productLink;

  const GetProduct(this.productLink);
}
