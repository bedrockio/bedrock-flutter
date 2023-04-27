import 'dart:async';
import 'package:bedrock_flutter/src/network/api_error.dart';
import 'package:bedrock_flutter/src/route_generator.dart';
import 'package:bedrock_flutter/src/utils/constants/colors.dart';
import 'package:bedrock_flutter/src/utils/widgets/error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ErrorHelper {
  static late final StreamController<ApiError> errorStream;

  static void broadcastError(Object e) {
    if (e is ApiError) {
      errorStream.sink.add(e);
      logErrorMessage(e.message);
    } else if (e is DioError) {
      errorStream.sink.add(ApiError(message: e.message!, details: e.error));
    } else {
      errorStream.sink.add(ApiError(message: e.toString()));
      logErrorMessage(e.toString());
    }
  }

  static void logErrorMessage(String e) {
    if (!kDebugMode) {
      // FirebaseCrashlytics.instance.log(e);
    }
  }
}

showErrorBottomSheet(ApiError error, BuildContext context) {
  RouteGenerator.showModal(
    barrierColor: BRColors.brown.withOpacity(0.3),
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) => ErrorDialog(
        title: 'Something went wrong',
        description: error.message,
        logMessage: error.details != null ? error.details['details'][0].toString() : ''),
  );
}