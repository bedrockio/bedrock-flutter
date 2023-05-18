import 'package:bedrock_flutter/src/auth/cubit/auth_cubit.dart';
import 'package:bedrock_flutter/src/base_view.dart';
import 'package:bedrock_flutter/src/profile/cubit/profile_cubit.dart';
import 'package:bedrock_flutter/src/utils/constants/colors.dart';
import 'package:bedrock_flutter/src/utils/constants/fonts.dart';
import 'package:bedrock_flutter/src/utils/constants/padding.dart';
import 'package:bedrock_flutter/src/utils/widgets/cta_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: BRColors.black,
          centerTitle: true,
          title: const Text('Profile', style: TextStyle(color: BRColors.white)),
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
          if (state is ProfileLoaded) {
            return Padding(
                padding: const EdgeInsets.all(BRPadding.small),
                child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Text('Logged in as:', style: BRFontStyle.body()),
                  Text(state.user.firstName, style: BRFontStyle.h1()),
                  const Spacer(),
                  BlocListener<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is LoggedOut) {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamedAndRemoveUntil(BaseView.route, (route) => false);
                        }
                      },
                      child: CtaButton(
                          onPressed: () {
                            BlocProvider.of<AuthCubit>(context).performLogout();
                          },
                          text: 'Log out'))
                ]));
          }

          return const Center(child: CircularProgressIndicator(color: BRColors.brown));
        }));
  }
}
