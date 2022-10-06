
import 'package:get/get.dart';
import 'package:techtest/screen/auth/login.dart';
import 'package:techtest/screen/auth/signup.dart';

import '../screen/home.dart';

part 'routes.dart';

class Pages {
  static final List<GetPage> routes = [
  

    GetPage(name: _Paths.HOME, page: () => HomeView(),),
    GetPage(
      name: _Paths.Login,
      page: () => LoginView(),
    ),
     GetPage(
      name: _Paths.Signup,
      page: () => SignUpView(),
    ),
  ];
}
