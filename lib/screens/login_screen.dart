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
        children: [
          
          // 메인 콘텐츠
          Column(
            children: [
              const SizedBox(height: 44), // 상태바 높이만큼 여백
              
              // 로고 영역
              Expanded(
                child: Center(
                  child: _buildLogo(),
                ),
              ),
              
              const SizedBox(height: 40),
            ],
          ),

          // 로그인 버튼들 (Figma 절대좌표 비율 기반 위치)
          // Kakao: x=15, y=467, w=343, h=50 on 375x812
          Positioned(
            left: size.width * (15 / 375),
            top: size.height * (467 / 812),
            width: size.width * (343 / 375),
            height: 50,
            child: _buildKakaoLoginButton(),
          ),
          // Naver: x=15, y=534, w=343, h=50 on 375x812
          Positioned(
            left: size.width * (15 / 375),
            top: size.height * (534 / 812),
            width: size.width * (343 / 375),
            height: 50,
            child: _buildNaverLoginButton(),
          ),
          
          // 하단 홈 인디케이터
          _buildHomeIndicator(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 132,
      height: 132,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD1D6E6).withOpacity(0.25),
            offset: const Offset(0, 4),
            blurRadius: 10,
            spreadRadius: 7,
          ),
        ],
      ),
      child: Stack(
        children: [
          // 메인 로고 배경
          Center(
            child: Container(
              width: 110,
              height: 110,
              child: Image.asset(
                'assets/images/app_icon.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          // 작은 원
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: const Color(0xFF63C2F1).withOpacity(0.8),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          // 카카오 로그인 버튼
          _buildKakaoLoginButton(),
          
          const SizedBox(height: 17),
          
          // 네이버 로그인 버튼
          _buildNaverLoginButton(),
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
        width: 343,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFFF8E049), // 카카오 노란색
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 카카오 아이콘
            Container(
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
        width: 343,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFF66BD59), // 네이버 초록색
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 네이버 아이콘
            Container(
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
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 34,
        color: Colors.white,
        child: Center(
          child: Container(
            width: 134,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }
}

