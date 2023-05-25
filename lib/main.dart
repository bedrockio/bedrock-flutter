import 'dart:async';

import '/src/auth/auth_repository.dart';
import '/src/auth/cubit/auth_cubit.dart';
import '/src/base_view.dart';
import '/src/env/environment.dart';
import '/src/navigation/cubit/bottom_nav_cubit.dart';
import '/src/network/api_error.dart';
import '/src/network/api_service.dart';
import '/src/products/cubit/product_cubit.dart';
import '/src/products/cubit/product_repository.dart';
import '/src/profile/cubit/profile_cubit.dart';
import '/src/profile/cubit/profile_repository.dart';
import '/src/route_generator.dart';
import '/src/utils/auth_storage.dart';
import '/src/utils/error_helper.dart';
import '/src/utils/widgets/dismiss_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  Environment().load();

  ErrorHelper.errorStream = StreamController<ApiError>.broadcast();

  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(
                AuthRepository(ApiService.shared), AuthStorage(const FlutterSecureStorage()), StreamController())
              ..isLoggedIn()),
        BlocProvider<ProductCubit>(create: (context) => ProductCubit(ProductRepository(ApiService.shared))),
        BlocProvider<ProfileCubit>(create: (context) => ProfileCubit(ProfileRepository(ApiService.shared))),
        BlocProvider<BottomNavCubit>(
          create: (context) => BottomNavCubit(),
        ),
      ],
      child:
          const DismissKeyboard(child: MaterialApp(home: BaseView(), onGenerateRoute: RouteGenerator.generateRoute))));
}
