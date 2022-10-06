part of 'pages.dart';

abstract class Routes {
  static const ROOT = '/';

  static const HOME = _Paths.HOME;
  static const Login = _Paths.Login;
  static const Signup = _Paths.Signup;

}

abstract class _Paths {
  static const HOME = '/home';
  static const Login = '/login';
  static const Signup = '/signup';
}
