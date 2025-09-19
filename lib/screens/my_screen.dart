import 'package:flutter/material.dart';
import 'profile_edit_screen.dart';
import 'drain_management_screen.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_svg_icon.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  final String userName = '김솜이';
  final String userLocation = '대한민국, 대구';
  final String profileImageUrl = 'assets/images/character.png';
  final int participationCount = 123;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopNavigationBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildProfileSection(),
                    const SizedBox(height: 24),
                    _buildParticipationCard(),
                    const SizedBox(height: 24),
                    _buildDrainAdoptionSection(),
                    const SizedBox(height: 24),
                    _buildMenuSection(),
                    const SizedBox(height: 24),
                    _buildSettingsSection(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            _buildBottomTabBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopNavigationBar() {
    return CustomAppBar(
      title: '마이페이지',
      showNotificationIcon: true,
      onNotificationPressed: () {
        Navigator.pushNamed(context, '/notification');
      },
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        children: [
          // 프로필 이미지 - 피그마에서 x: 16, y: 110, width: 68, height: 68
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileEditScreen(),
                ),
              );
            },
            child: Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2E7DFF), width: 1),
                image: DecorationImage(
                  image: AssetImage(profileImageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // 사용자 정보 - 피그마에서 x: 100, y: 117, width: 108
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700, // 볼드체
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 14,
                      color: Color(0xFF4A4A4A),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      userLocation,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF111111),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParticipationCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      height: 106,
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 20), // overflow 방지를 위해 패딩 조정
      decoration: BoxDecoration(
        color: const Color(0xFF2E7DFF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '지금까지 참여 횟수',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$participationCount 회',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700, // 볼드체
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // 첫 번째 행
          Row(
            children: [
              // 뱃지 관리
              Expanded(
                child: _buildMenuButton(
                  icon: Icons.emoji_events_outlined,
                  iconColor: const Color(0xFFD9D9D9),
                  title: '뱃지 관리',
                  onTap: () {
                    // 뱃지 관리 화면으로 이동
                  },
                ),
              ),
              const SizedBox(width: 16),
              // 최근 청소 기록
              Expanded(
                child: _buildMenuButton(
                  icon: Icons.cleaning_services,
                  iconColor: const Color(0xFF4A4A4A),
                  title: '최근 청소 기록',
                  onTap: () {
                    // 청소 기록 화면으로 이동
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16), // 메뉴 버튼들 사이 간격
          // 두 번째 행
          Row(
            children: [
              // 내가 쓴 댓글
              Expanded(
                child: _buildMenuButtonWithSvg(
                  svgPath: 'assets/icons/chat_comment.svg',
                  title: '내가 쓴 댓글',
                  onTap: () {
                    // 댓글 목록 화면으로 이동
                  },
                ),
              ),
              const SizedBox(width: 16),
              // 내가 쓴 글
              Expanded(
                child: _buildMenuButtonWithSvg(
                  svgPath: 'assets/icons/list_plus.svg',
                  title: '내가 쓴 글',
                  onTap: () {
                    // 내가 쓴 글 화면으로 이동
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton({
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
    bool hasBackground = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            hasBackground
                ? Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: iconColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      icon,
                      size: 16,
                      color: Colors.white,
                    ),
                  )
                : Icon(
                    icon,
                    size: 24,
                    color: iconColor,
                  ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
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

  Widget _buildMenuButtonWithSvg({
    required String svgPath,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomSvgIcon(
              assetPath: svgPath,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
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

  Widget _buildDrainAdoptionSection() {
    return Container(
      margin: const EdgeInsets.only(left: 40, right: 16),
      child: _buildSpecialSettingsItemWithSvg(
        svgPath: 'assets/icons/drain_management.svg',
        title: '내가 입양한 하수구',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DrainManagementScreen(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Container(
      child: Column(
        children: [
          // 구분선 - 피그마에서 x: 16, y: 507, width: 343, height: 8
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 8,
            color: const Color(0xFFF6F6F6),
          ),
          const SizedBox(height: 20),
          // 일반 설정 항목들 - 피그마에서 x: 16, y: 535, 575, 615, 655
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildSettingsItem(
                  title: '공지사항',
                  onTap: () {
                    // 공지사항 화면으로 이동
                  },
                ),
                const SizedBox(height: 20),
                _buildSettingsItem(
                  title: '알림설정',
                  onTap: () {
                    // 알림 설정 화면으로 이동
                  },
                ),
                const SizedBox(height: 20),
                _buildSettingsItem(
                  title: '계정설정',
                  onTap: () {
                    // 계정 설정 화면으로 이동
                  },
                ),
                const SizedBox(height: 20),
                _buildSettingsItem(
                  title: '문의하기',
                  onTap: () {
                    // 문의하기 화면으로 이동
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialSettingsItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E7DFF).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.water_drop, // 파이프 대신 물방울 아이콘 사용
                    size: 16,
                    color: Color(0xFF4A4A4A),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xFF4A4A4A),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialSettingsItemWithSvg({
    required String svgPath,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CustomSvgIcon(
                  assetPath: svgPath,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xFF4A4A4A),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xFF4A4A4A),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomTabBar() {
    return Container(
      height: 90,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFEEEEEE), width: 1),
        ),
      ),
      child: Row(
        children: [
          _buildTabItem(0, Icons.home, '홈', isSelected: false),
          _buildTabItem(1, Icons.map, '지도', isSelected: false),
          _buildTabItem(2, Icons.cleaning_services, '청소하기', isSelected: false),
          _buildTabItem(3, Icons.chat, '커뮤니티', isSelected: false),
          _buildTabItem(4, Icons.person, '마이', isSelected: true),
        ],
      ),
    );
  }

  Widget _buildTabItem(int index, IconData icon, String label, {bool isSelected = false}) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _onTabTapped(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF2E7DFF) : const Color(0xFFAAAAAA),
              size: 24,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? const Color(0xFF2E7DFF) : const Color(0xFFAAAAAA),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTabTapped(int index) {
    switch (index) {
      case 0: // 홈
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1: // 지도
        Navigator.pushReplacementNamed(context, '/map');
        break;
      case 2: // 청소하기
        // 청소하기 화면으로 이동
        break;
      case 3: // 커뮤니티
        Navigator.pushReplacementNamed(context, '/community');
        break;
      case 4: // 마이
        // 이미 마이 화면에 있음
        break;
    }
  }
}