import 'package:dghome3d/business_logic/common.dart';
import 'package:dghome3d/business_logic/inside_screen/inside_cubit.dart';
import 'package:dghome3d/data/data_provider.dart';
import 'package:dghome3d/screens/ui/generals.dart';
import 'package:dghome3d/screens/ui/texts.dart';
import 'package:dghome3d/screens/ui/ui_helper.dart';
import 'package:dghome3d/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InsideScreen extends StatefulWidget {
  const InsideScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => InsideScreenState();

}

class InsideScreenState extends State<InsideScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InsideCubit(DataProvider())..getData(),
      child: BlocConsumer<InsideCubit, InsideState>(
        listener: (context, state) {
          if (state.signedOut) {
            if (state.errorText != null && state.errorText!.isNotEmpty) {
              showAlertDialog(
                  context,
                  state.errorText!,
                  onPressed: () {
                    go(const WelcomeScreen());
                  },
              );
            } else {
              go(const WelcomeScreen());
            }
          }
        },
        builder: (context, state) {
          InsideCubit cubit = context.read<InsideCubit>();
          cubit.setupSignOutTimer();
          return appScaffold(context,
            onAppBarLeadingTap: () {
              if (state.appUser != null) {
                exitApp();
              } else {
                Navigator.maybePop(context);
              }
            },
            body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    titleText('INSIDE'),
                    dataRow('Name: ', state.appUser?.name ?? ""),
                    dataRow('Email: ', state.appUser?.email ?? ""),
                    dataRow('Phone number: ', state.appUser?.phoneNumber ?? ""),
                    dataRow('Expired at: ', state.appUser?.expirationDateTime ?? ""),
                    SizedBox(height: 36,),
                    ElevatedButton(
                      style: ButtonStyle(),
                      onPressed: () => cubit.signOut(),
                      child: Text('Sign out!')
                    ),
                  ],
            ),
          ));
        },
      ),
    );
  }

  go(Widget screen) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => screen,
        ));
  }

  dataRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(key),
          value.isNotEmpty
              ? highlightText(value)
              : Text('(Không có dữ liệu)')
        ],
      ),
    );
  }
}