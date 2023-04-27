import 'package:bedrock_flutter/src/network/api_service_interceptor.dart';
import 'package:bedrock_flutter/src/utils/auth_storage.dart';
import 'package:bedrock_flutter/src/utils/constants/colors.dart';
import 'package:bedrock_flutter/src/utils/constants/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum NetworkLogsScreenType { all, error }

class NetworkLogsScreen extends StatelessWidget {
  static const route = '/network_logs_screen';

  final NetworkLogsScreenType type;

  const NetworkLogsScreen({super.key, this.type = NetworkLogsScreenType.all});

  List<String> get logs {
    switch (type) {
      case NetworkLogsScreenType.all:
        return DioLogger.collectedLogs;
      case NetworkLogsScreenType.error:
        return DioLogger.errorLogs;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Network logs'),
          backgroundColor: Colors.red,
          actions: [
            TextButton(
                onPressed: () {
                  switch (type) {
                    case NetworkLogsScreenType.all:
                      DioLogger.collectedLogs.clear();
                      break;
                    case NetworkLogsScreenType.error:
                      DioLogger.errorLogs.clear();
                      break;
                  }
                },
                child: const Text('Clear', style: TextStyle(color: Colors.white)))
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(BRPadding.small),
            child: FutureBuilder(
                future: AuthStorage(const FlutterSecureStorage()).readAuthToken(),
                builder: (context, snapshot) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      final logItem = logs[index];

                      return InkWell(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: logs[index]));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(content: Text('Log entry copied to clipboard.')));
                          },
                          child: Text(
                            logItem == 'null'
                                ? 'No response'
                                : snapshot.hasData
                                    ? logs[index].replaceAll(snapshot.data!, '[TOKEN]')
                                    : logs[index],
                            style: TextStyle(
                                fontFamily: logItem != 'null' ? 'American Typewriter' : null,
                                fontStyle: logItem == 'null' ? FontStyle.italic : null,
                                color: logItem == 'null' ? Colors.grey : BRColors.black),
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                          ));
                    },
                    separatorBuilder: (context, _) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(vertical: BRPadding.small),
                          child: Divider(color: BRColors.black.withOpacity(0.6), thickness: 2));
                    },
                    itemCount: logs.length,
                  );
                })));
  }
}
