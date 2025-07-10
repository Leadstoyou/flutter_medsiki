import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/route/route_item.dart';
import 'package:untitled/screens/auth/welcome_screen.dart';
import 'package:untitled/screens/onboarding/onboarding_screen.dart';
import 'package:untitled/screens/payment/payment_screen.dart';
import 'package:untitled/screens/payment/result_screen.dart';
import 'package:untitled/screens/splash_screen/splash_screen.dart';
class RoutePaths {
  static const String root = '/';
  static const String payment = '/payment';
  static const String result = '/result';
  static const String onboardingFirstScreen = '/onboardingFirstScreen';
  static const String welcomeScreen = '/welcomeScreen';
}
final List<RouteItem> routeList = [
  RouteItem(
    path: RoutePaths.root,
    builder: (BuildContext context, GoRouterState state) {
      return  SplashScreen();
    },
  ),
  RouteItem(
    path: RoutePaths.payment,
    builder: (BuildContext context, GoRouterState state) {
      Map<String, String> orderInfo = state.queryParams;
      print(orderInfo);
      return PaymentSreen(
          orderCode: orderInfo["orderCode"]!,
          accountName: orderInfo["accountName"]!,
          accountNumber: orderInfo["accountNumber"]!,
          amount: orderInfo["amount"]!,
          bin: orderInfo["bin"]!,
          description: orderInfo["description"]!,
          qrCode: orderInfo["qrCode"]!,
          courseId: orderInfo["courseId"]!)
      ;
    },
  ),
  RouteItem(
    path: RoutePaths.result,
    builder: (BuildContext context, GoRouterState state) {
      String orderCode = state.queryParams["orderCode"] ?? "";
      return ResultScreen(orderCode: orderCode);
    },
  ),
  RouteItem(
    path: RoutePaths.onboardingFirstScreen,
    builder: (BuildContext context, GoRouterState state) {
      return  OnboardingFirstScreen();
    },
  ),
  RouteItem(
    path: RoutePaths.welcomeScreen,
    builder: (BuildContext context, GoRouterState state) {
      return  WelcomeScreen();
    },
  ),
];

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: routeList.map((route) => route.toGoRoute()).toList(),
);