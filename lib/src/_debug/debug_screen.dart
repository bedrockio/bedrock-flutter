import 'package:bedrock_flutter/src/auth/cubit/auth_cubit.dart';
import 'package:bedrock_flutter/src/base_view.dart';
import 'package:bedrock_flutter/src/_debug/change_location_screen.dart';
import 'package:bedrock_flutter/src/_debug/network_log_screen.dart';
import 'package:bedrock_flutter/src/env/environment.dart';
import 'package:bedrock_flutter/src/network/api_error.dart';
import 'package:bedrock_flutter/src/network/api_service_interceptor.dart';
import 'package:bedrock_flutter/src/utils/auth_storage.dart';
import 'package:bedrock_flutter/src/utils/constants/fonts.dart';
import 'package:bedrock_flutter/src/utils/constants/padding.dart';
import 'package:bedrock_flutter/src/utils/error_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DebugScreen extends StatelessWidget {
  static const route = '/debug';

  final ValueNotifier<String> _appVersion = ValueNotifier('-');
  final ValueNotifier<Stage> _selectedEnvironment = ValueNotifier(env);
  final ValueNotifier<bool> _collectingLogs = ValueNotifier(DioLogger.collectLogs);
  final ValueNotifier<bool> _shouldSwitchEnvironment = ValueNotifier(false);

  DebugScreen({super.key}) {
    PackageInfo.fromPlatform().then((value) {
      _appVersion.value = 'Version ${value.version} (${value.buildNumber})';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Debug Screen'),
        centerTitle: true,
      ),
      body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoggedOut) {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamedAndRemoveUntil(BaseView.route, (route) => false);

              if (_shouldSwitchEnvironment.value == true) {
                env = _selectedEnvironment.value;
                Environment().load();
              }
            }
          },
          child: Padding(
              padding: const EdgeInsets.all(BRPadding.small),
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [_general(context), const SizedBox(height: BRPadding.large), _storedData(context)])))),
    );
  }

  Widget _general(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('general', style: BRFontStyle.h2()),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(onPressed: () {}, child: Text('Toggle environment', style: BRFontStyle.bodyMedium())),
          ValueListenableBuilder<Stage>(
              valueListenable: _selectedEnvironment,
              builder: (_, value, __) => CupertinoSegmentedControl(
                    borderColor: Colors.red,
                    selectedColor: Colors.red,
                    pressedColor: Colors.red.withOpacity(0.2),
                    groupValue: value == Stage.uat ? 0 : 1,
                    padding: EdgeInsets.zero,
                    children: const {
                      0: Padding(
                          padding: EdgeInsets.symmetric(horizontal: BRPadding.xsmall, vertical: BRPadding.xxsmall),
                          child: Text('UAT')),
                      1: Padding(
                          padding: EdgeInsets.symmetric(horizontal: BRPadding.xsmall, vertical: BRPadding.xxsmall),
                          child: Text('PROD'))
                    },
                    onValueChanged: (obj) {
                      if (_selectedEnvironment.value == Stage.uat) {
                        _selectedEnvironment.value = Stage.prod;
                      } else {
                        _selectedEnvironment.value = Stage.uat;
                      }

                      _shouldSwitchEnvironment.value = true;

                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Switched to ${_selectedEnvironment.value.name}. Now logging out.')));
                      Future.delayed(const Duration(seconds: 2)).then((value) {
                        BlocProvider.of<AuthCubit>(context).performLogout();
                      });
                    },
                  ))
        ],
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        TextButton(
            onPressed: () {
              DioLogger.collectLogs = !DioLogger.collectLogs;
              _collectingLogs.value = DioLogger.collectLogs;
            },
            child: Text('Collect network logs', style: BRFontStyle.bodyMedium())),
        ValueListenableBuilder<bool>(
            valueListenable: _collectingLogs,
            builder: (_, value, __) => Text(value ? 'On' : 'Off', style: BRFontStyle.bodyMedium()))
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        TextButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(NetworkLogsScreen.route, arguments: NetworkLogsScreenType.all),
            child: Text('Show network logs', style: BRFontStyle.bodyMedium())),
        const Icon(Icons.chevron_right, color: Colors.red)
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        TextButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(NetworkLogsScreen.route, arguments: NetworkLogsScreenType.error),
            child: Text('Show error logs', style: BRFontStyle.bodyMedium())),
        const Icon(Icons.chevron_right, color: Colors.red)
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        TextButton(
            onPressed: () => Navigator.of(context).pushNamed(ChangeLocationScreen.route),
            child: Text('Mock GPS', style: BRFontStyle.bodyMedium())),
        const Icon(Icons.chevron_right, color: Colors.red)
      ]),
      TextButton(onPressed: () {}, child: Text('Component library', style: BRFontStyle.bodyMedium())),
      TextButton(onPressed: () {}, child: Text('Test token refresh', style: BRFontStyle.bodyMedium())),
      TextButton(
          onPressed: () {
            ErrorHelper.broadcastError(ApiError(message: 'This is a test. Nothing to see here!'));
          },
          child: Text('Test error handler', style: BRFontStyle.bodyMedium())),
      TextButton(
          onPressed: () {
            DefaultCacheManager().emptyCache();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Caches cleared.')));
          },
          child: Text('Clear caches', style: BRFontStyle.bodyMedium())),
      TextButton(
          onPressed: () {
            BlocProvider.of<AuthCubit>(context).performLogout();
          },
          child: Text('Logout', style: BRFontStyle.bodyMedium())),
    ]);
  }

  Widget _storedData(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('stored variables', style: BRFontStyle.h2()),
        const SizedBox(height: BRPadding.small),
        Text('ENVIRONMENT', style: BRFontStyle.bodyMedium()),
        Text(env.name),
        const SizedBox(height: BRPadding.small),
        Text('ACCESS TOKEN', style: BRFontStyle.bodyMedium()),
        FutureBuilder(
            future: AuthStorage(const FlutterSecureStorage()).readAuthToken(),
            builder: (context, snapshot) => InkWell(
                onTap: () {
                  if (snapshot.hasData) {
                    Clipboard.setData(ClipboardData(text: snapshot.data!));
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Auth Token copied to clipboard.')));
                  }
                },
                child: Text(
                  snapshot.hasData ? snapshot.data! : '-',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ))),
        const SizedBox(height: BRPadding.small),
        Text('APP VERSION', style: BRFontStyle.bodyMedium()),
        ValueListenableBuilder<String>(
            valueListenable: _appVersion,
            builder: (_, value, __) => InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: value));
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('App Version copied to clipboard.')));
                },
                child: Text(
                  value,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ))),
      ],
    );
  }
}
