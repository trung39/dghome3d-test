
import 'package:dghome3d/screens/forgot_password_screen.dart';
import 'package:dghome3d/screens/register_screen.dart';
import 'package:dghome3d/screens/ui/buttons.dart';
import 'package:dghome3d/screens/ui/generals.dart';
import 'package:dghome3d/screens/ui/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginScreenState();

}
class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return appScaffold(context,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleText('Login'),
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 32),
              child: Text('Login now to track all you expenses and income at a place!'),
            ),
            textField(
              title: 'Email',
              hint: 'Ex: abc@example.com',
              leading: Icons.alternate_email),
            SizedBox(height: 24,),
            textField(
              title: 'Your Password',
              isPassword: true,
              leading: Icons.lock_outline_rounded),
            underlineTextButton(
                text: 'Forgot Password?',
                isBoldText: false,
                onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const ForgotPasswordScreen(),
                ))
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: ElevatedButton(
                onPressed: (){},
                child: Text("Login"),
              ),
            ),

            Text("Don't have an account?"),
            SizedBox(height: 8,),
            underlineTextButton(
                  text: 'Register',
                  onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ))
            ),
            underlineTextButton(text: 'Try other login method', onTap: () => Navigator.maybePop(context)),
          ],
        ),
      )
    );
  }

}