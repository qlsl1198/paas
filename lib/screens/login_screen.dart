import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SingleChildScrollView(
        child: Column(
          children: [
            // 상단 여백
            const SizedBox(height: 60),
            
            // 로고 및 앱 이름
            _buildHeader(),
            
            const SizedBox(height: 40),
            
            // 환영 메시지
            _buildWelcomeMessage(),
            
            const SizedBox(height: 60),
            
            // 소셜 로그인 버튼들
            _buildSocialLoginButtons(),
            
            const SizedBox(height: 40),
            
            // 하단 약관 동의
            _buildTermsAgreement(),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // 앱 로고
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: const Color(0xFF00FFAA),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00FFAA).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.cleaning_services,
            size: 60,
            color: Colors.white,
          ),
        ),
        
        const SizedBox(height: 24),
        
        // 앱 이름
        const Text(
          'PAAS',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: 2,
          ),
        ),
        
        const SizedBox(height: 8),
        
        // 앱 설명
        const Text(
          '청소 관리 앱',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF666666),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeMessage() {
    return Column(
      children: [
        const Text(
          '환영합니다!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        
        const SizedBox(height: 12),
        
        const Text(
          '간편하게 로그인하고\n청소 관리를 시작해보세요',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF666666),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLoginButtons() {
    return Column(
      children: [
        // 구글 로그인
        _buildSocialLoginButton(
          'Google로 계속하기',
          const Color(0xFF4285F4),
          onPressed: () => _handleGoogleLogin(),
        ),
        
        const SizedBox(height: 16),
        
        // 카카오 로그인
        _buildSocialLoginButton(
          '카카오로 계속하기',
          const Color(0xFFFEE500),
          onPressed: () => _handleKakaoLogin(),
          textColor: const Color(0xFF3C1E1E),
        ),
        
        const SizedBox(height: 16),
        
        // 네이버 로그인
        _buildSocialLoginButton(
          '네이버로 계속하기',
          const Color(0xFF03C75A),
          onPressed: () => _handleNaverLogin(),
        ),
      ],
    );
  }

  Widget _buildSocialLoginButton(
    String text,
    Color backgroundColor, {
    Color? textColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: Provider.of<AuthService>(context).isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor ?? Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(
            color: backgroundColor == const Color(0xFFFEE500) 
              ? const Color(0xFFE5E5E5) 
              : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 아이콘 (플레이스홀더)
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                _getIconForSocial(text),
                size: 16,
                color: backgroundColor,
              ),
            ),
            
            const SizedBox(width: 12),
            
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor ?? Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForSocial(String text) {
    if (text.contains('Google')) return Icons.g_mobiledata;
    if (text.contains('카카오')) return Icons.chat_bubble;
    if (text.contains('네이버')) return Icons.nat;
    return Icons.person;
  }



  Widget _buildTermsAgreement() {
    return Column(
      children: [
        const Text(
          '로그인하면 다음에 동의하는 것으로 간주됩니다',
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF999999),
          ),
        ),
        
        const SizedBox(height: 8),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _showTermsDialog('이용약관'),
              child: const Text(
                '이용약관',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF00FFAA),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            
            const Text(
              ' 및 ',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF999999),
              ),
            ),
            
            GestureDetector(
              onTap: () => _showTermsDialog('개인정보처리방침'),
              child: const Text(
                '개인정보처리방침',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF00FFAA),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // 소셜 로그인 처리 함수들
  void _handleGoogleLogin() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    
    try {
      final success = await authService.signInWithGoogle();
      
      if (success && mounted) {
        _showSuccessDialog('구글 로그인');
      } else if (mounted) {
        _showErrorDialog('구글 로그인에 실패했습니다.');
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog('구글 로그인 중 오류가 발생했습니다.');
      }
    }
  }

  void _handleKakaoLogin() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    
    try {
      final success = await authService.signInWithKakao();
      
      if (success && mounted) {
        _showSuccessDialog('카카오 로그인');
      } else if (mounted) {
        _showErrorDialog('카카오 로그인에 실패했습니다.');
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog('카카오 로그인 중 오류가 발생했습니다.');
      }
    }
  }

  void _handleNaverLogin() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    
    try {
      final success = await authService.signInWithNaver();
      
      if (success && mounted) {
        _showSuccessDialog('네이버 로그인');
      } else if (mounted) {
        _showErrorDialog('네이버 로그인에 실패했습니다.');
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog('네이버 로그인 중 오류가 발생했습니다.');
      }
    }
  }



  // 다이얼로그 함수들
  void _showSuccessDialog(String loginType) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('로그인 성공'),
        content: Text('$loginType이 완료되었습니다.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/home');
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('로그인 실패'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void _showTermsDialog(String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text('$title 내용이 여기에 표시됩니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
} 