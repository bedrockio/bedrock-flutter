import 'dart:async';

import '/src/auth/auth_repository.dart';
import '/src/auth/cubit/auth_cubit.dart';
import '/src/auth/otp_screen.dart';
import '/src/auth/login_screen.dart';
import '/src/auth/register_screen.dart';
import '/src/base_view.dart';
import '/src/home/home_screen.dart';
import '/src/main_screen.dart';
import '/src/network/api_service.dart';
import '/src/products/cubit/product_cubit.dart';
import '/src/products/cubit/product_repository.dart';
import '/src/products/products_screen.dart';
import '/src/profile/cubit/profile_cubit.dart';
import '/src/profile/cubit/profile_repository.dart';
import '/src/profile/profile_screen.dart';
import '/src/utils/auth_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static final GlobalKey<NavigatorState> parentNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> homeTabNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> productsTabNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> profileTabNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
      initialLocation: '/',
      navigatorKey: parentNavigatorKey,
      errorBuilder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('route_generator.dart error'),
          ),
          body: Center(
            child: Text(state.error?.message ?? 'An error occurred.'),
          ),
        );
      },
      routes: [
        ShellRoute(
            builder: (context, state, child) => MultiBlocProvider(
                    providers: [
                      BlocProvider<AuthCubit>(
                          create: (context) => AuthCubit(AuthRepository(ApiService.shared),
                              AuthStorage(const FlutterSecureStorage()), StreamController())
                            ..isLoggedIn()),
                      BlocProvider<ProductCubit>(
                          create: (context) => ProductCubit(ProductRepository(ApiService.shared))),
                      BlocProvider<ProfileCubit>(
                          create: (context) => ProfileCubit(ProfileRepository(ApiService.shared))),
                    ],
                    child: BlocListener<AuthCubit, AuthState>(
                        listener: (context, state) {
                          state.maybeWhen(
                              loggedOut: () {
                                context.replace('/login');
                              },
                              orElse: () {});
                        },
                        child: child)),
            routes: [
              StatefulShellRoute.indexedStack(
                branches: [
                  StatefulShellBranch(
                    navigatorKey: homeTabNavigatorKey,
                    routes: [
                      GoRoute(
                        path: '/home',
                        pageBuilder: (context, GoRouterState state) {
                          return MaterialPage(key: state.pageKey, child: HomeScreen());
                        },
                      ),
                    ],
                  ),
                  StatefulShellBranch(
                    navigatorKey: productsTabNavigatorKey,
                    routes: [
                      GoRoute(
                        path: '/products',
                        pageBuilder: (context, state) {
                          return MaterialPage(key: state.pageKey, child: const ProductsScreen());
                        },
                      ),
                    ],
                  ),
                  StatefulShellBranch(
                    navigatorKey: profileTabNavigatorKey,
                    routes: [
                      GoRoute(
                        path: '/profile',
                        pageBuilder: (context, state) {
                          return MaterialPage(key: state.pageKey, child: const ProfileScreen());
                        },
                      ),
                    ],
                  ),
                ],
                pageBuilder: (
                  BuildContext context,
                  GoRouterState state,
                  StatefulNavigationShell navigationShell,
                ) {
                  return CustomTransitionPage<void>(
                    key: state.pageKey,
                    transitionDuration: const Duration(milliseconds: 350),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
                    child: MainScreen(child: navigationShell),
                  );
                },
              ),
              GoRoute(path: '/', builder: (context, state) => const BaseView(), routes: [
                GoRoute(
                    path: 'login',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                          key: state.pageKey,
                          transitionDuration: const Duration(milliseconds: 350),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                          child: LoginScreen(),
                        ),
                    routes: [
                      GoRoute(
                        path: 'otp',
                        builder: (context, state) {
                          final args = state.extra as String;
                          return OtpScreen(phoneNumber: args);
                        },
                      ),
                    ]),
                GoRoute(path: 'register', builder: (context, state) => RegisterScreen(), routes: [
                  GoRoute(
                    path: 'otp',
                    builder: (context, state) {
                      final args = state.extra as String;
                      return OtpScreen(phoneNumber: args);
                    },
                  ),
                ]),
              ]),
            ])
      ]);

  static Future<T?> showModal<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    Color? barrierColor,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    RouteSettings? routeSettings,
    AnimationController? transitionAnimationController,
  }) {
    return showModalBottomSheet(
        context: context,
        builder: builder,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: shape,
        clipBehavior: clipBehavior,
        constraints: constraints,
        barrierColor: barrierColor,
        isScrollControlled: isScrollControlled,
        useRootNavigator: useRootNavigator,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        routeSettings: routeSettings,
        transitionAnimationController: transitionAnimationController);
  }
}
