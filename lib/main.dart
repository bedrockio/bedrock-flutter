import 'dart:async';

import 'package:bedrock_flutter/src/auth/auth_repository.dart';
import 'package:bedrock_flutter/src/auth/cubit/auth_cubit.dart';
import 'package:bedrock_flutter/src/base_view.dart';
import 'package:bedrock_flutter/src/env/environment.dart';
import 'package:bedrock_flutter/src/navigation/cubit/bottom_nav_cubit.dart';
import 'package:bedrock_flutter/src/network/api_error.dart';
import 'package:bedrock_flutter/src/network/api_service.dart';
import 'package:bedrock_flutter/src/products/cubit/product_cubit.dart';
import 'package:bedrock_flutter/src/products/cubit/product_repository.dart';
import 'package:bedrock_flutter/src/route_generator.dart';
import 'package:bedrock_flutter/src/utils/auth_storage.dart';
import 'package:bedrock_flutter/src/utils/error_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  Environment().load();

  ErrorHelper.errorStream = StreamController<ApiError>.broadcast();

  runApp(MultiBlocProvider(providers: [
    BlocProvider<AuthCubit>(
        create: (context) =>
            AuthCubit(AuthRepository(ApiService.shared), AuthStorage(const FlutterSecureStorage()), StreamController())
              ..isLoggedIn()),
    BlocProvider<ProductCubit>(create: (context) => ProductCubit(ProductRepository(ApiService.shared))),
    BlocProvider<BottomNavCubit>(
      create: (context) => BottomNavCubit(),
    ),
  ], child: const MaterialApp(home: BaseView(), onGenerateRoute: RouteGenerator.generateRoute)));
}
