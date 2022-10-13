import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HoldingTaxPage extends StatelessWidget {
  final Uri login_url = Uri.parse(
      "https://taxai.auth.ap-northeast-2.amazoncognito.com/login?client_id=165n75nfnnvlphe5vlom6lsu9q&response_type=token&scope=aws.cognito.signin.user.admin&redirect_uri=https://tyjeon24.github.io/rktmen/callback");
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () => launchUrl(login_url,
            mode: LaunchMode.platformDefault, webOnlyWindowName: '_self'),
        child: Text('로그인'));
  }
}
