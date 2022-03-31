import 'package:dghome3d/screens/ui/generals.dart';
import 'package:dghome3d/screens/ui/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ForgotPasswordScreen extends StatefulWidget{
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ForgotPasswordScreenState();

}
class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
        return emailInputView();
      case 1:
        return verifyCodeView();
      case 2:
        return newPasswordInputView();
    }
  }

  Widget emailInputView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText('Forgot Password?'),
        Text('Recover your password if you forgot your password! '),
        SizedBox(height: 24,),
        textField(
          title: "Email",
          hint: "Ex: abc@example.com",
          leading: Icons.alternate_email
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: ElevatedButton(
              onPressed: () => switchToNextStep(),
              child: Text('Submit')),
        ),
      ],
    );
  }

  Widget verifyCodeView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText('Forgot Password?'),
        Text('We have sent an email to your email account with a verification code!'),
        SizedBox(height: 24,),
        textField(
            title: "Verification Code",
            hint: "123456"
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: ElevatedButton(
              onPressed: () => switchToNextStep(),
              child: Text('Register')),
        ),
      ],
    );
  }

  Widget newPasswordInputView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText('Forgot Password?'),
        Text('Set your password to login into your account!'),
        SizedBox(height: 24,),
        textField(
          title: "Enter New Password",
          isPassword: true,
          leading: Icons.lock_outline_rounded
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: ElevatedButton(
              onPressed: () {},
              child: Text('Confirm')),
        ),
      ],
    );
  }

  switchToNextStep() {
    setState(() {
      _currentIndex++;
    });
  }
}
