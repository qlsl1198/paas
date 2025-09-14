import 'package:flutter/material.dart';
import 'dart:ui' show lerpDouble; // for double interpolation
import 'login_screen.dart';

// 이미지를 활용한 단계적 스플래시 시퀀스 구현

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 4200),
      vsync: this,
    )..forward();
  }

  double _intervalValue(double t, double begin, double end, [Curve curve = Curves.linear]) {
    if (t <= begin) return 0.0;
    if (t >= end) return 1.0;
    final progress = (t - begin) / (end - begin);
    return curve.transform(progress.clamp(0.0, 1.0));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          
          // 메인 로고 영역
          _buildSequence(),
          
          // 하단 홈 인디케이터
          _buildHomeIndicator(),
        ],
      ),
    );
  }

  Widget _buildSequence() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final size = MediaQuery.of(context).size;
        final t = _controller.value; // 0.0 ~ 1.0

        // 단계별 타이밍
        // 0.00~0.25: splash1 scale pop + fade in
        // 0.20~0.45: splash2 drop from top
        // 0.45~0.60: cross-fade to splash3
        // 0.60~0.85: move+scale to app_icon position/size
        // 0.85~1.00: buttons fade in

        // 공통 기준 위치(중앙) 및 Figma 기준 크기
        final center = Offset(size.width / 2, size.height / 2);
        const baseW = 107.0;
        const baseH = 153.0;

        // splash1
        final s1In = _intervalValue(t, 0.00, 0.20, Curves.easeIn);
        final s1Out = _intervalValue(t, 0.45, 0.55, Curves.easeOut);
        final s1Opacity = (s1In * (1.0 - s1Out)).clamp(0.0, 1.0);
        final s1Scale = 0.8 + 0.2 * _intervalValue(t, 0.00, 0.25, Curves.easeOutBack);

        // splash2
        final s2Vis = _intervalValue(t, 0.20, 0.55, Curves.linear);
        final s2Drop = _intervalValue(t, 0.20, 0.45, Curves.easeOut);
        // splash2는 중앙 위쪽(약 절반 높이)에서 멈춰서 splash1과 합쳐집니다.
        final s2StopDy = -baseH * 0.5 + 40; // 중앙보다 위쪽에 정지(+10px 더 아래)
        final s2Dy = lerpDouble(-size.height * 0.3, s2StopDy, s2Drop) ?? s2StopDy;

        // splash3
        final s3In = _intervalValue(t, 0.45, 0.60, Curves.easeIn);

        // morph to app icon
        final morph = _intervalValue(t, 0.60, 0.85, Curves.easeInOut);
        const icon = 94.0;

        // 최종 아이콘 위치(비율 기반: Figma 812 기준 약 0.257)
        final targetCenter = Offset(size.width / 2, size.height * 0.257);
        final dx = lerpDouble(0, targetCenter.dx - center.dx, morph) ?? 0;
        final dy = lerpDouble(0, targetCenter.dy - center.dy, morph) ?? 0;
        final w = lerpDouble(baseW, icon, morph) ?? baseW;
        final h = lerpDouble(baseH, icon, morph) ?? baseH;

        // app_icon cross-fade (마지막 구간에서 splash3->app_icon 전환)
        final iconFade = _intervalValue(t, 0.80, 0.88, Curves.easeIn);

        // 버튼 페이드인
        final buttonsOpacity = _intervalValue(t, 0.85, 1.00, Curves.easeIn);

        return Stack(
          children: [
            // splash1 (splash3 시작되면 즉시 숨김)
            if (s3In == 0 && s1Opacity > 0)
              Positioned(
                left: center.dx - baseW / 2,
                top: center.dy - baseH / 2,
                child: Opacity(
                  opacity: s1Opacity,
                  child: Transform.scale(
                    scale: s1Scale,
                    child: Image.asset(
                      'assets/images/splash1.png',
                      width: baseW,
                      height: baseH,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

            // splash2 dropping (14px 고정, splash3 시작되면 즉시 숨김)
            if (s3In == 0 && s2Vis > 0)
              Align(
                alignment: Alignment.center,
                child: Opacity(
                  opacity: s2Vis,
                  child: Transform.translate(
                    offset: Offset(0, s2Dy),
                    child: SizedBox(
                      width: 12.0,
                      height: 12.0,
                      child: Image.asset(
                        'assets/images/splash2.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),

            // splash3 appear and morph (splash1 + splash2가 합쳐지는 느낌으로 크로스 페이드)
            if (s3In > 0)
              Positioned(
                left: center.dx - (w / 2) + dx,
                top: center.dy - (h / 2) + dy,
                child: Opacity(
                  // splash1/2에서 splash3로 전환 강조: s3In 값을 직접 반영
                  opacity: (1.0 - iconFade) * s3In,
                  child: Image.asset(
                    'assets/images/splash3.png',
                    width: w,
                    height: h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

            // app_icon cross-fade in at end of morph
            if (s3In > 0)
              Positioned(
                left: center.dx - (w / 2) + dx,
                top: center.dy - (h / 2) + dy,
                child: Opacity(
                  opacity: iconFade,
                  child: Image.asset(
                    'assets/images/app_icon.png',
                    width: w,
                    height: w,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

            // 로그인 버튼들 페이드인
            if (buttonsOpacity > 0)
              Positioned(
                left: 0,
                right: 0,
                bottom: size.height * 0.12,
                child: Opacity(
                  opacity: buttonsOpacity,
                  child: _buildLoginButtonsInline(),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildLoginButtonsInline() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildKakaoButton(),
          const SizedBox(height: 17),
          _buildNaverButton(),
        ],
      ),
    );
  }

  Widget _buildKakaoButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFFF8E049),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.chat_bubble, color: Colors.black, size: 22),
              SizedBox(width: 8),
              Text(
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
      ),
    );
  }

  Widget _buildNaverButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFF66BD59),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.login, color: Colors.white, size: 22),
              SizedBox(width: 8),
              Text(
                '네이버로 로그인',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
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
}

// 스플래시 로고 페인터
class SplashLogoPainter extends CustomPainter {
  final bool hasSmallCircle;
  final int splashIndex;

  SplashLogoPainter({
    required this.hasSmallCircle,
    required this.splashIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 배경 그라데이션
    final backgroundPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          const Color(0xFF63C2F1),
          const Color(0xFF9EDFFF),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // 배경 그리기
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    // 메인 로고 스트로크
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.5;

    // 그라데이션 스트로크
    final gradient = LinearGradient(
      colors: [
        const Color(0xFFB1E5FF).withOpacity(0),
        const Color(0xFFC0EAFF).withOpacity(0.4),
        const Color(0xFFA1E0FF),
        const Color(0xFFE0F5FF).withOpacity(0.4),
      ],
      stops: const [0.0, 0.27, 0.56, 0.92],
    );

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final shader = gradient.createShader(rect);
    strokePaint.shader = shader;

    // 로고 모양 그리기
    final path = Path();
    path.moveTo(size.width * 0.5, 0);
    path.lineTo(size.width * 0.8, size.height * 0.3);
    path.lineTo(size.width * 0.6, size.height * 0.6);
    path.lineTo(size.width * 0.4, size.height * 0.6);
    path.lineTo(size.width * 0.2, size.height * 0.3);
    path.close();

    canvas.drawPath(path, strokePaint);

    // 작은 원 그리기 (조건부)
    if (hasSmallCircle) {
      final circlePaint = Paint()
        ..shader = LinearGradient(
          colors: [
            const Color(0xFF63C2F1).withOpacity(0),
            const Color(0xFF63C2F1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTWH(0, 0, 14, 14));

      canvas.drawCircle(
        Offset(size.width * 0.7, size.height * 0.3),
        7,
        circlePaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// 신호 아이콘 페인터
class SignalIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // 신호 막대들
    canvas.drawRect(Rect.fromLTWH(2, 10, 3, 4), paint);
    canvas.drawRect(Rect.fromLTWH(6.5, 6, 3, 8), paint);
    canvas.drawRect(Rect.fromLTWH(11, 4, 3, 10), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// WiFi 아이콘 페인터
class WifiIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // WiFi 신호 그리기
    final path = Path();
    path.moveTo(8, 12);
    path.arcToPoint(const Offset(4, 8), radius: const Radius.circular(4));
    path.moveTo(8, 12);
    path.arcToPoint(const Offset(2, 6), radius: const Radius.circular(6));
    path.moveTo(8, 12);
    path.arcToPoint(const Offset(0, 4), radius: const Radius.circular(8));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// 배터리 아이콘 페인터
class BatteryIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // 배터리 외곽선
    canvas.drawRect(Rect.fromLTWH(0, 1, 23, 12), paint);
    
    // 배터리 극
    canvas.drawRect(Rect.fromLTWH(24, 5, 1, 4), paint);
    
    // 배터리 내부 (100%)
    final fillPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(2, 3, 19, 8), fillPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
