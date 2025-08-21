import 'package:bedrock_flutter/env/environment.dart';
import 'package:bedrock_flutter/src/utils/logger.dart';

import '/src/auth/cubit/auth_cubit.dart';
import '/src/_debug/change_location_screen.dart';
import 'logs_screen.dart';
import '/src/network/api_error.dart';
import '/src/network/api_service_interceptor.dart';
import '/src/utils/auth_storage.dart';
import '/src/utils/constants/padding.dart';
import '/src/utils/error_helper.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DebugScreen extends StatelessWidget {
  static const route = '/debug';

  final ValueNotifier<String> _appVersion = ValueNotifier('-');
  final ValueNotifier<bool> _collectingLogs = ValueNotifier(DioLogger.collectLogs);

  DebugScreen({super.key}) {
    PackageInfo.fromPlatform().then((value) {
      _appVersion.value = 'Version ${value.version} (${value.buildNumber})';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(useMaterial3: false),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: const Text('Debug Screen'),
            centerTitle: true,
          ),
          body: Padding(
              padding: const EdgeInsets.all(BRPadding.small),
              child: SingleChildScrollView(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _general(context),
                const SizedBox(height: BRPadding.large),
                _envData(context),
                const SizedBox(height: BRPadding.large),
                _storedData(context)
              ])))),
    );
  }

  Widget _general(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('general', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        TextButton(
            onPressed: () {
              DioLogger.collectLogs = !DioLogger.collectLogs;
              _collectingLogs.value = DioLogger.collectLogs;
            },
            child:
                const Text('Collect network logs', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700))),
        ValueListenableBuilder<bool>(
            valueListenable: _collectingLogs,
            builder: (_, value, __) =>
                Text(value ? 'On' : 'Off', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700)))
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        TextButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LogsScreen(type: BRLogType.network),
                )),
            child: const Text('Show network logs', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700))),
        const Icon(Icons.chevron_right, color: Colors.red)
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        TextButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LogsScreen(type: BRLogType.error),
                )),
            child: const Text('Show error logs', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700))),
        const Icon(Icons.chevron_right, color: Colors.red)
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        TextButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LogsScreen(type: BRLogType.console),
                )),
            child: const Text('Show console logs', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700))),
        const Icon(Icons.chevron_right, color: Colors.red)
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        TextButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeLocationScreen(),
                )),
            child: const Text('Mock GPS', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700))),
        const Icon(Icons.chevron_right, color: Colors.red)
      ]),
      TextButton(
          onPressed: () {
            ErrorHelper.broadcastError(ApiError(message: 'This is a test. Nothing to see here!'));
          },
          child: const Text('Test error handler', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700))),
      TextButton(
          onPressed: () {
            DefaultCacheManager().emptyCache();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Caches cleared.')));
          },
          child: const Text('Clear caches', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700))),
      TextButton(
          onPressed: () {
            BlocProvider.of<AuthCubit>(context).performLogout();
          },
          child: const Text('Logout', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700))),
    ]);
  }

  Widget _storedData(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('stored variables', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
        const SizedBox(height: BRPadding.small),
        const Text('ENVIRONMENT', style: TextStyle(fontWeight: FontWeight.w700)),
        const Text(Environment.isDev ? 'DEVELOPMENT' : 'PRODUCTION'),
        const SizedBox(height: BRPadding.small),
        const Text('ACCESS TOKEN', style: TextStyle(fontWeight: FontWeight.w700)),
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
        const Text('APP VERSION', style: TextStyle(fontWeight: FontWeight.w700)),
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

  Widget _envData(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('env.json variables', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: BRPadding.small),
        ...Environment.values.entries.map(
          (e) => InkWell(
            onTap: () {
              Clipboard.setData(ClipboardData(text: e.value.toString()));
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Value for ${e.key.toUpperCase()} copied to clipboard.')));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(e.key.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold)),
                Text(e.value.toString()),
                const SizedBox(height: BRPadding.xsmall),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
