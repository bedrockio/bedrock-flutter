import 'package:bedrock_flutter/src/utils/logger.dart';

import '/src/utils/auth_storage.dart';
import '/src/utils/constants/colors.dart';
import '/src/utils/constants/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LogsScreen extends StatefulWidget {
  static const route = '/logs_screen';

  final BRLogType type;

  const LogsScreen({super.key, this.type = BRLogType.network});

  @override
  State<LogsScreen> createState() => _LogsScreen();
}

class _LogsScreen extends State<LogsScreen> {
  final ScrollController _scrollController = ScrollController();

  List<BRLogItem> get logs {
    return BRLogger.logs.where((e) => e.type == widget.type).toList();
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
                  BRLogger.clearLogs(type: widget.type);
                  setState(() {});
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
                            Clipboard.setData(ClipboardData(text: logs[index].message));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(content: Text('Log entry copied to clipboard.')));
                          },
                          child: Text(
                            logItem.message == 'null'
                                ? 'No response'
                                : snapshot.hasData
                                    ? logs[index].message.replaceAll(snapshot.data!, '[TOKEN]')
                                    : logs[index].message,
                            style: TextStyle(
                                fontFamily: logItem.message != 'null' ? 'American Typewriter' : null,
                                fontStyle: logItem.message == 'null' ? FontStyle.italic : null,
                                color: logItem.message == 'null' ? Colors.grey : BRColors.primaryText),
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
