import 'package:dghome3d/assets/images.dart';
import 'package:dghome3d/assets/svg_loader.dart';
import 'package:dghome3d/screens/ui/generals.dart';
import 'package:dghome3d/screens/ui/texts.dart';
import 'package:dghome3d/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PhoneVerifyScreen extends StatefulWidget{
  const PhoneVerifyScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PhoneVerifyScreenState();

}
class PhoneVerifyScreenState extends State<PhoneVerifyScreen> {
  int _currentIndex = 0;
  int _otpLength = 5;
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
        child: _buildPhoneVerifyContent(),
      ),
    );
  }

  _buildPhoneVerifyContent() {
    switch (_currentIndex) {
      case 0:
        return _phoneInputView();
      case 1:
        return _verifyCodeView();
    }
  }

  Widget _phoneInputView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText('Phone Number'),
        Text('Enter your phone number to continue'),
        SizedBox(height: 32,),
        textField(
            title: "Phone number",
            hint: "0912345678",
            prefix: _phoneInputPrefix()
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: ElevatedButton(
              onPressed: () => _switchToNextStep(),
              child: Text('Submit')),
        ),
      ],
    );
  }

  Widget _verifyCodeView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText('Verify phone Number'),
        Text('We have sent an email to your email account with a verification code!'),
        SizedBox(height: 32,),
        _pinCodeTextField(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: ElevatedButton(
              onPressed: () {},
              child: Text('Submit')),
        ),
      ],
    );
  }

  _switchToNextStep() {
    setState(() {
      _currentIndex++;
    });
  }

  Widget _phoneInputPrefix() {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: (){},
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26,),
                borderRadius: BorderRadius.circular(4)
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4,2,4,2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.keyboard_arrow_down, color: Colors.black38,),
                    ImageAssets.svgAssets(context, ImagesResource.icVNFlag,
                      height: 20
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 4, right: 4, bottom: 2),
            child: Text('+84',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                  fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pinCodeTextField() {
    double fieldSize = 50;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Verification code", style: TextStyle(fontSize: 16),),
        SizedBox(height: 8,),
        PinCodeTextField(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          appContext: context,
          autoFocus: true,
          length: _otpLength,
          obscureText: false,
          animationType: AnimationType.fade,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderWidth: 1.5,
              borderRadius: BorderRadius.circular(16),
              fieldHeight: fieldSize,
              fieldWidth: fieldSize,
              activeFillColor: Colors.white,
              // activeColor: state.otpError ? Colors.red : Colors.green,
              activeColor: Colors.green,
              inactiveColor: primaryColor,
              inactiveFillColor: Colors.black.withAlpha(10),
              selectedFillColor: Colors.white,
              // selectedColor: state.otpError ? Colors.red : Colors.blue
              selectedColor: primaryColor
          ),
          animationDuration: const Duration(milliseconds: 150),
          enableActiveFill: true,
          errorAnimationDuration: 200,
          // errorAnimationController: otpErrorController,
          // controller: otpTextController,
          autoDismissKeyboard: false,
          onCompleted: (v) {
            // ForgotPasswordBloc.of(context).add(ForgotPasswordOTPSubmitted());
          },
          onChanged: (value) {
            // ForgotPasswordBloc.of(context).add(ForgotPasswordOTPChanged(otp: value));
          },
          beforeTextPaste: (text) {
            print("Allowing to paste $text");
            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
            //but you can show anything you want here, like your pop up saying wrong paste format or etc
            return true;
          },
        ),
      ],
    );
  }
}