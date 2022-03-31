import 'package:dghome3d/screens/ui/buttons.dart';
import 'package:dghome3d/screens/ui/generals.dart';
import 'package:dghome3d/screens/ui/texts.dart';
import 'package:dghome3d/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget{
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RegisterScreenState();

}
class RegisterScreenState extends State<RegisterScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return appScaffold(context,
      onAppBarLeadingTap: () {
        if (_currentIndex > 0) {
          setState(() {
            _currentIndex--;
          });
        } else {
          Navigator.maybePop(context);
        }
      },
      body: SingleChildScrollView(
        child: _buildRegisterContent(),
      ),
    );
  }

  _buildRegisterContent() {
    switch (_currentIndex) {
      case 0:
        return inputInfoView();
      case 1:
        return verifyCodeView();
    }
  }

  Widget inputInfoView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText('Register'),
        Wrap(
          children: [
            Text('Create an account to get better support from '),
            highlightText('dghome3d'),
          ],
        ),
        SizedBox(height: 24,),
        textField(
            title: "Email",
            leading: Icons.alternate_email,
            hint: "Ex: abc@example.com"
        ),
        SizedBox(height: 24,),
        textField(
            title: "Your name",
            leading: Icons.person_outline_rounded,
            hint: "Ex: John Wick"
        ),
        SizedBox(height: 24,),
        textField(
            title: "Your password",
            leading: Icons.lock_outline_rounded,
            hint: "Ex: abc@example.com"
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: ElevatedButton(
              onPressed: () => setState(() {
                _currentIndex = 1;
              }),
              child: Text('Register')),
        ),
        Center(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text('Already have an account?', style: TextStyle(fontSize: 16),),
              underlineTextButton(
                  text: 'Login',
                  onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ))
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget verifyCodeView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText('Register'),
        Text('We have sent an email to your email account with a verification code! '),
        SizedBox(height: 24,),
        textField(
          title: "Verification Code",
          hint: "123456"
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: ElevatedButton(
              onPressed: () {},
              child: Text('Register')),
        ),
      ],
    );
  }
}