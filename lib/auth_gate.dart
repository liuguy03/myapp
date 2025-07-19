import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lib/auth_service.dart'; // 替换为你的路径
import 'package:lib/home_screen.dart';   // 替换为你的路径
import 'package:lib/login_screen.dart';  // 替换为你的路径

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      // 监听认证状态的实时变化
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        // 1. 如果正在等待（比如网络慢），显示加载动画
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // 2. 如果流中有用户数据（即用户已登录）
        if (snapshot.hasData) {
          return const HomeScreen(); // 显示主页
        }
        
        // 3. 如果流中没有用户数据（即用户未登录）
        return const LoginScreen(); // 显示登录页
      },
    );
  }
}