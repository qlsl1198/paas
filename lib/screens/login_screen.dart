import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
          children: [
            // 앱 아이콘: 스플래시와 정확히 동일한 위치
            Positioned(
              left: (size.width / 2) - 47, // center.dx - (w / 2) + dx
              top: size.height * 0.257 - 47, // center.dy - (h / 2) + dy
              width: 94,
              height: 94,
              child: Image.asset(
                'assets/images/app_icon.png',
                fit: BoxFit.contain,
              ),
            ),
            
            // 로그인 버튼들: 하단에 고정 위치
            Positioned(
              left: 16,
              right: 16,
              bottom: 200, // 사용자가 설정한 하단 여백
              child: Column(
                children: [
                  _buildKakaoLoginButton(),
                  const SizedBox(height: 17),
                  _buildNaverLoginButton(),
                ],
              ),
            ),
          ],
      ),
    );
  }


  Widget _buildKakaoLoginButton() {
    return GestureDetector(
      onTap: () {
        // 카카오 로그인 로직
        _navigateToHome();
      },
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFFF8E049), // 카카오 노란색
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 카카오 아이콘
            SizedBox(
              width: 24,
              height: 24,
              child: Image.asset(
                'assets/images/kakao.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 10),
            // 카카오 로그인 텍스트
            const Text(
              '카카오로 로그인',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNaverLoginButton() {
    return GestureDetector(
      onTap: () {
        // 네이버 로그인 로직
        _navigateToHome();
      },
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFF66BD59), // 네이버 초록색
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 네이버 아이콘
            SizedBox(
              width: 24,
              height: 24,
              child: Image.asset(
                'assets/images/naver.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 10),
            // 네이버 로그인 텍스트
            const Text(
              '네이버로 로그인',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeIndicator() {
    return const SizedBox.shrink();
  }

  void _navigateToHome() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/home',
      (route) => false,
    );
  }
}

