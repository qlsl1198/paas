import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool showBackButton;
  final bool showNotificationIcon;
  final VoidCallback? onBackPressed;
  final VoidCallback? onNotificationPressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showBackButton = false,
    this.showNotificationIcon = false,
    this.onBackPressed,
    this.onNotificationPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white,
      child: Stack(
        children: [
          // 중앙 제목
          Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          // 왼쪽 영역
          Positioned(
            left: 16,
            top: 0,
            bottom: 0,
            child: Row(
              children: [
                if (showBackButton)
                  GestureDetector(
                    onTap: onBackPressed ?? () => Navigator.pop(context),
                    child: Container(
                      width: 24,
                      height: 24,
                      padding: const EdgeInsets.all(2),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                        color: Color(0xFF4A4A4A),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // 오른쪽 영역
          Positioned(
            right: 16,
            top: 0,
            bottom: 0,
            child: Row(
              children: [
                if (showNotificationIcon)
                  GestureDetector(
                    onTap: onNotificationPressed,
                    child: Container(
                      width: 24,
                      height: 24,
                      child: const Icon(
                        Icons.notifications_outlined,
                        size: 20,
                        color: Color(0xFF4A4A4A),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
