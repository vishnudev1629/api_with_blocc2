import 'package:api_with_blocc/Bloc/product_event.dart';
import 'package:api_with_blocc/Bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Product_link.dart';


class UserBloc extends Bloc<UserEvent, UserState> {
  final productRepositort _userRepository;

  UserBloc(this._userRepository) : super(UserLoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final users = await _userRepository.fetchData();
        emit(UserLoadedState(users!));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}
