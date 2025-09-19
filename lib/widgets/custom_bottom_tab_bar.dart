import 'package:flutter/material.dart';

class CustomBottomTabBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomTabBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE5E5E5), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTabItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: '홈',
            index: 0,
          ),
          _buildTabItem(
            icon: Icons.map_outlined,
            activeIcon: Icons.map,
            label: '지도',
            index: 1,
          ),
          _buildTabItem(
            icon: Icons.people_outline,
            activeIcon: Icons.people,
            label: '커뮤니티',
            index: 2,
          ),
          _buildTabItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            label: '마이',
            index: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
  }) {
    final isActive = currentIndex == index;
    
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              size: 24,
              color: isActive ? const Color(0xFF2E7DFF) : const Color(0xFF8A8A8A),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? const Color(0xFF2E7DFF) : const Color(0xFF8A8A8A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
