import 'users.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'dashboard_screen.dart';
import 'custom_route.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/auth';
  int id;
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String> _loginUser(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      for(var i = 0; i < mockUsers.length; i++){
        if(mockUsers[i]['email'].contains(data.name)){
          id = i;
          return null;
        }
      }
      return "E-Posta ya da şifre yanlış";
    });
  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      /*if (!mockUsers.containsKey(name)) {
        return 'Böyle bir kullanıcı yok';
      }*/
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
  
    return Container(
      color: const Color(0xFF66BB6A),
      child: Padding(
        padding: EdgeInsets.only(top: 40),
        child:   FlutterLogin(
          title: "Dirty Paws",
          logo: 'assets/images/paws.png',
          logoTag: 'anim.ai.logo',
          messages: LoginMessages(
            usernameHint: 'E-Posta',
            passwordHint: 'Şifre',
            confirmPasswordHint: 'Şifreyi tekrar girin',
            loginButton: 'Giriş Yap',
            signupButton: 'Kayıt Ol',
            forgotPasswordButton: 'Şifreni mi unuttun?',
            recoverPasswordButton: 'Kurtar',
            goBackButton: 'Geri git',
            confirmPasswordError: 'Şifreler uyuşmuyor!',
            recoverPasswordIntro: 'Üzülme, bu her zaman başımıza geliyor.',
            recoverPasswordDescription: 'Şifreni sıfırlayabilmen için sana bir link göndereceğiz.',
            recoverPasswordSuccess: 'Şifre başarıyla kurtarıldı.',
          ),
          emailValidator: (value) {
            if (!value.contains('@') || !value.endsWith('.com')) {
              return "Gerçek bir e-Posta adresi girin";
            }
            return null;
          },
          passwordValidator: (value) {
            if (value.isEmpty) {
              return 'Şifrenizi girin';
            }
            return null;
          },
          onLogin: (loginData) {
            return _loginUser(loginData);
          },
          onSignup: (loginData) {
            return _loginUser(loginData);
          },
          onSubmitAnimationCompleted: () {
            Navigator.of(context).pushReplacement(FadePageRoute(
              builder: (context) => MyApp(),
            ));
          },
          onRecoverPassword: (name) {
            return _recoverPassword(name);
          },
          //showDebugButtons: true,
        )
      )
    );
  }
}