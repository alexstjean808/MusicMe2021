import 'package:bloc/bloc.dart';
import 'package:musicme/features/music_app/core/methods/connect_to_spotify.dart';
import 'package:musicme/features/music_app/data/entities/user.dart';
import 'package:musicme/features/music_app/presentation/bloc/user_event.dart';
// GLOBAL VARIABLE in use called userGLOBAL

class UserBloc extends Bloc<UserEvent, User> {
  UserBloc(User initialState) : super(initialState);
  @override
  Stream<User> mapEventToState(UserEvent event) async* {
    User user = await connectToSpotify();
    yield user;
  }
}
