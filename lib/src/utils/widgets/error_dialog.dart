import '/src/env/environment.dart';
import '/src/route_generator.dart';
import '/src/utils/constants/colors.dart';
import '/src/utils/constants/fonts.dart';
import '/src/utils/widgets/cta_button.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String description;
  final String buttonLabel;
  final String logMessage;
  final Function()? onTap;

  const ErrorDialog({
    super.key,
    this.title = 'An error occured',
    this.description = '',
    this.buttonLabel = 'Take me back',
    this.logMessage = '',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        env != Stage.prod
            ? InkWell(
                onTap: () {
                  if (env != Stage.prod) {
                    RouteGenerator.showModal(
                      context: context,
                      builder: (BuildContext context) => Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Text(
                              logMessage,
                              style: BRFontStyle.body(),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
                child: _buildBody(context),
              )
            : _buildBody(context)
      ],
    );
  }

  Padding _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      child: Container(
        decoration: const BoxDecoration(
          color: BRColors.lightBrown,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(
            Radius.circular(28),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
              child: Text(title, style: BRFontStyle.h2()),
            ),
            _buildDescription(),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(15),
              child: CtaButton(
                colorScheme: BRColorScheme.black,
                text: buttonLabel,
                onPressed: () {
                  if (onTap != null) onTap!();
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDescription() {
    if (description.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
        child: Text(
          description,
          style: BRFontStyle.body(),
        ),
      );
    } else {
      return Container();
    }
  }
}
