import 'package:bedrock_flutter/src/utils/logger.dart';

import '/src/network/api_service_interceptor.dart';
import '/src/utils/auth_storage.dart';
import '/src/utils/constants/colors.dart';
import '/src/utils/constants/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum LogScreenType {
  network,
  error,
  console;

  String get title {
    switch (this) {
      case network:
        return 'Network logs';
      case console:
        return 'Console logs';
      case error:
        return 'Error logs';
    }
  }
}

class LogsScreen extends StatefulWidget {
  static const route = '/logs_screen';

  final LogScreenType type;

  const LogsScreen({super.key, this.type = LogScreenType.network});

  @override
  State<LogsScreen> createState() => _NetworkLogsScreen();
}

class _NetworkLogsScreen extends State<LogsScreen> {
  final ScrollController _scrollController = ScrollController();

  List<String> get logs {
    switch (widget.type) {
      case LogScreenType.network:
        return DioLogger.collectedLogs;
      case LogScreenType.error:
        return DioLogger.errorLogs;
      case LogScreenType.console:
        return BRLogger.logs;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.type.title),
          backgroundColor: Colors.red,
          actions: [
            TextButton(
                onPressed: () {
                  switch (widget.type) {
                    case LogScreenType.network:
                      DioLogger.collectedLogs.clear();
                      break;
                    case LogScreenType.error:
                      DioLogger.errorLogs.clear();
                      break;
                    case LogScreenType.console:
                      BRLogger.clearLogs();
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
                    controller: _scrollController,
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
                                color: logItem == 'null' ? Colors.grey : BRColors.primaryText),
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                          ));
                    },
                    separatorBuilder: (context, _) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(vertical: BRPadding.small),
                          child: Divider(color: BRColors.primaryText.withOpacity(0.6), thickness: 2));
                    },
                    itemCount: logs.length,
                  );
                })));
  }
}
