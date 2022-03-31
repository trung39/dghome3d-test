import 'package:dghome3d/assets/images.dart';
import 'package:dghome3d/business_logic/welcome_screen/welcome_cubit.dart';
import 'package:dghome3d/data/data_provider.dart';
import 'package:dghome3d/data/firebase_helper.dart';
import 'package:dghome3d/data/model/app_user.dart';
import 'package:dghome3d/data/submission_status.dart';
import 'package:dghome3d/screens/inside_screen.dart';
import 'package:dghome3d/screens/phone_verify_screen.dart';
import 'package:dghome3d/screens/ui/buttons.dart';
import 'package:dghome3d/screens/ui/generals.dart';
import 'package:dghome3d/screens/ui/texts.dart';
import 'package:dghome3d/screens/ui/ui_helper.dart';
import 'package:dghome3d/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(create: (context) => DataProvider(),
      child: BlocProvider(
        create: (context) =>
            WelcomeCubit(context.read<DataProvider>())..checkLoggedIn(),
        child: BlocConsumer<WelcomeCubit, WelcomeState>(
          listener: (context, state) {
            print('listening: $state');
            if (state.status is Submitting) {
              showProgressDialog(context);
            } else if (state.status is SubmissionSuccess) {
              Navigator.of(context, rootNavigator: true).maybePop();
            }
            if (state.isLoggedIn) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const InsideScreen(),
              ));
            }
          },
          builder: (context, state) {
            print('Start of builder');
            var cubit = context.read<WelcomeCubit>();
            // if (state.status is InitialStatus) {
            //   cubit.checkLoggedIn().whenComplete(() => null);
            // }
            return appScaffold(context,
              appBar: PreferredSize(
                  child: Container(), preferredSize: Size(0, 0)
              ),
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome to', style: TextStyle(fontSize: 20),),
                    titleText('dghome3d'),
                    Text('A place where you can explore our\n'
                        'interior concepts and try it in reality'),
                    SizedBox(height: 12,),
                    loginSelectiveButton(context,
                        iconData: Icons.phone_android_rounded,
                        title: "Continue with phone",
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const PhoneVerifyScreen(),
                            ))
                    ),
                    loginSelectiveButton(context,
                        svgIcon: ImagesResource.icFacebook,
                        title: "Continue with Facebook",
                        onTap: () async {
                          await cubit.loginWithFacebook();
                        }
                    ),
                    loginSelectiveButton(context,
                        svgIcon: ImagesResource.icGoogle,
                        title: "Continue with Google",
                        onTap: () async {
                          await cubit.loginWithGoogle();
                        }
                    ),
                    loginSelectiveButton(context,
                        iconData: Icons.alternate_email,
                        title: "Continue with Email"),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Already have an account?', style: TextStyle(
                            fontSize: 16),),
                        underlineTextButton(
                            text: 'Login',
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ))
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}