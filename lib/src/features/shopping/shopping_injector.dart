import '../../config/container_injector.dart';
import 'data/datasources/remote/base_remote_shopping_datasource.dart';
import 'data/datasources/remote/remote_shopping_datasource.dart';
import 'domain/repositories/base_shopping_repo.dart';
import 'domain/usecases/get_product_usecase.dart';
import 'presentation/bloc/shopping_bloc.dart';

import 'data/datasources/local/base_local_shopping_datasource.dart';
import 'data/datasources/local/local_shopping_datasource.dart';
import 'data/repositories/shopping_repo.dart';
import 'domain/usecases/get_products_usecase.dart';

void initShopping() {
  // init data source
  sl.registerLazySingleton<BaseRemoteShoppingDatasource>(
    () => RemoteShoppingDatasource(),
  );
  sl.registerLazySingleton<BaseLocalShoppingDatasource>(
    () => LocalShoppingDatasource(),
  );

  // init repos
  sl.registerLazySingleton<BaseShoppingRepo>(
    () => ShoppingRepo(
      baseCheckInternetConnectivity: sl(),
      baseLocalShoppingDatasource: sl(),
      baseRemoteShoppingDatasource: sl(),
    ),
  );

  // init usecases
  sl.registerLazySingleton<GetProductUseCase>(
    () => GetProductUseCase(sl()),
  );
  sl.registerLazySingleton<GetProductsUseCase>(
    () => GetProductsUseCase(sl()),
  );

  // init bloc
  sl.registerFactory(() => ShoppingBloc(
        getProductsUseCase: sl(),
        getProductUseCase: sl(),
      ));
}
