import 'package:equatable/equatable.dart';

import '../../components.dart';
import '../../database/database.dart';
import '../../models/user/user_model.dart';
import '../../services/auth_service.dart';

part 'user_model_state.dart';

class UserModelCubit extends Cubit<UserModelState> {
  UserModelCubit() : super(const UserModelInitial()) {
    _database = GetIt.I<Database>();

    _authService = GetIt.I<AuthService>();

    _authService.currentUser.listen((event) async {
      _database.uid = event?.uid;
    });
    loadUser();
  }
  late final AuthService _authService;
  late final Database _database;
  static const String key = "user";
  late String uid = '';

  loadUser() async {
    // log("loadUser token: $token");
    await _database.getUser().then((value) {
      // log("loadUser value: $value");
      if (value != null) {
        emit(UserModelLoaded(user: value));
      }
      // emit(UserModelLoaded(user: value!.copyWith(name: 'oussaid2')));
    });
    //emit(UserModelLoaded(user:value.copyWith(name: 'oussaid')));
  }

  void updateUser({UserModel? user}) {
    if (user != null) {
      _database.updateUser(user);
      emit(UserModelLoaded(user: user));
    }
    emit(state);
  }

  /// load user from shared preferences
  void loadFromCache() async {
    // var box = await Hive.openBox(key);
    // // emit(UserLoading());
    // try {
    //   final UserModel user = box.get(key);

    //   emit((user));
    // } catch (e) {
    //   emit(null);
    // }
  }

  /// save user to cache
  /// [user] is the user to be saved
  /// cache  if true, save to cache
  void cacheUSer({User? user}) async {
    // var box = await Hive.openBox(key);
    // //emit(UserLoading());
    // await box.put(key, user ?? state);
    // loadFromCache();
    //emit(const UserLoaded(user: UserModel.empty));
  }

  /// remove user from shared preferences
  void removeUserFromCache() async {
    // var box = await Hive.openBox(key);
    // await box.delete(key);
    // emit(null);
  }
}
