
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalDatabase {
  static const ACCESS_TOKEN = "user";
  static const USER_CART = "user_cart";
  final GetStorage _box = GetStorage();

  static LocalDatabase? _instance;

  LocalDatabase._();

  static Future<LocalDatabase> get instance async {
    if (_instance == null) {
      _instance = LocalDatabase._();
      await _instance!.init();
    }
    return _instance!;
  }

  factory LocalDatabase(){
    return _instance??=LocalDatabase._();
  }

  Future<void> init() async {
    await GetStorage.init();
  }

/*  Future<void> saveUser(StakeHolder user) async {
    await _box.write(ACCESS_TOKEN, user.toLocalMap());
  }

  Future<void> removeUser() async {
    await _box.remove(ACCESS_TOKEN);
  }

  StakeHolder? getUserToken() {
    StakeHolder? user;
    var map = _box.read(ACCESS_TOKEN);
    print("user local map: $map");
    if (map != null) {
      String type = map["user_type"];
      if (type == StakeHolder.TYPE_USER) {
        user = User.fromLocalMap(map);
      } else if (type == StakeHolder.TYPE_BUSINESS) {
        user = Business.fromLocalMap(map);
      }
    }
    return user;
  }*/

  Map<String, dynamic>? getUserCart(String user_id) {
    return _box.read(USER_CART)?[user_id];
  }

  Future<void> saveCartMap(String user_id, Map<String, dynamic> new_map) async {
    var map = _box.read(USER_CART);
    if (map != null) {
      map[user_id] = new_map;
    } else {
      map = {user_id: new_map};
    }
    await _box.write(USER_CART, map);
  }
}
