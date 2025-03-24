import 'package:flutter/material.dart';
import 'package:qlns/apps/utils/box_login.dart';
import 'package:qlns/controllers/authentic_Controller.dart';
import 'package:qlns/screens/signup/sinup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthenticController controller =
      AuthenticController(); // Khởi tạo controller trực tiếp

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Đăng nhập',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 25),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  children: const <TextSpan>[
                    TextSpan(text: 'Chào mừng bạn trở lại\n'),
                    TextSpan(text: 'chúng tôi đã nhớ bạn!'),
                  ],
                ),
              ),
              const SizedBox(height: 68),
              BoxSign(
                controller: controller.emailController,
                hintText: 'Email',
              ),
              const SizedBox(height: 30),
              BoxSign(
                controller: controller.passwordController,
                hintText: 'Mật khẩu',
                obscureText: true,
              ),
              const SizedBox(height: 30),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 30),
                child: Text(
                  'Bạn quên mật khẩu?',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () => controller.signInWithEmailAndPassword(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  width: 357,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Text(
                    'Đăng Nhập',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignupPage()),
                  );
                },
                child: const Text(
                  'Tạo tài khoản mới',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 75),
              const Text(
                'Hoặc tiếp tục với',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => controller.signInWithGoogle(context),
                    child: Container(
                      height: 44,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 2,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.g_mobiledata, size: 40),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
