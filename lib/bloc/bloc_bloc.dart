import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_labour9/repository.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UsersInitial()) {
    on<FetchUsersEvent>(_onFetchUsersEvent);
  }

  Future<void> _onFetchUsersEvent(
      FetchUsersEvent event, Emitter<UserState> emit) async {
    try {
      final users = await userRepository.fetchUsers();
      emit(UsersLoaded(users: users));
    } catch (error) {
      emit(UsersError(message: error.toString()));
    }
  }
}
