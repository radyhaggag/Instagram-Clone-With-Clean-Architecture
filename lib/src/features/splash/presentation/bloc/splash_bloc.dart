import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/person/person.dart';
import '../../../../core/domain/usecase/base_usecase.dart';
import '../../domain/usecases/splash_get_current_user_usecase.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SplashGetCurrentUserUseCase splashGetCurrentUserUseCase;
  SplashBloc({required this.splashGetCurrentUserUseCase})
      : super(SplashInitial()) {
    on<SplashEvent>((event, emit) async {
      if (event is SplashGetCurrentUser) {
        await _getUser(event, emit);
      }
    });
  }

  Future<void> _getUser(
    SplashGetCurrentUser event,
    Emitter<SplashState> emit,
  ) async {
    final result = await splashGetCurrentUserUseCase(NoParams());
    result.fold(
      (left) => emit(SplashGetUserFailed()),
      (right) => emit(SplashGetUserSuccessfully(right)),
    );
  }
}
