import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:qlns/screens/login/login_page.dart';
import 'package:qlns/screens/root_screen.dart';

class AuthenticController with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Đăng nhập người dùng với email và mật khẩu
  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email và mật khẩu không được để trống.')),
      );
      return;
    }

    try {
      // Hiển thị snackbar đang tải
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Đang đăng nhập...')));

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RootScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'Người dùng không tồn tại.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Sai mật khẩu.';
      } else {
        errorMessage = 'Đăng nhập thất bại: ${e.message}';
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đăng nhập thất bại: ${e.toString()}')),
      );
    }
  }

  // Tạo người dùng mới với email và mật khẩu
  Future<void> createUserWithEmailAndPassword(BuildContext context) async {
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (emailController.text.trim().isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email và mật khẩu không được để trống.')),
      );
      return;
    }

    // Kiểm tra xem mật khẩu và mật khẩu xác nhận có giống nhau không
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mật khẩu và xác nhận mật khẩu không khớp.'),
        ),
      );
      return;
    }

    try {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Đang tạo tài khoản...')));

      // Tạo người dùng mới với email và mật khẩu
      final credential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: password,
      );

      // Làm sạch các trường nhập liệu
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'weak-password') {
        errorMessage = 'Mật khẩu bạn nhập quá yếu.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'Tài khoản đã tồn tại với email này.';
      } else {
        errorMessage = 'Có lỗi xảy ra: ${e.message}';
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Có lỗi xảy ra: ${e.toString()}')));
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Ensure the user is not null
      if (googleUser == null) {
        // User cancelled the sign-in
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đăng nhập bằng Google bị hủy.')),
        );
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with the credential
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      // Once signed in, navigate to the BottomNavigation page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RootScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đăng nhập bằng Google thất bại: ${e.toString()}'),
        ),
      );
    }
  }

  // Đăng xuất người dùng
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  const LoginPage(), // Đổi thành màn hình đăng nhập của bạn
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đăng xuất thất bại: ${e.toString()}')),
      );
    }
  }

  // Giải phóng tài nguyên của các controller
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
