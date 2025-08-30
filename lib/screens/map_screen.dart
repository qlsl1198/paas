import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int selectedTabIndex = 1; // 지도 탭이 선택됨

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 상단 네비게이션 바
            _buildTopNavigationBar(),
            
            // 지도 영역
            Expanded(
              child: Stack(
                children: [
                  // 지도 배경
                  _buildMapBackground(),
                  
                  // 지도 위의 요소들
                  _buildMapElements(),
                  
                  // 하단 카드
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: _buildBottomCard(),
                  ),
                ],
              ),
            ),
            
            // 하단 탭바
            _buildBottomTabBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopNavigationBar() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: const Color(0xFF6C6C6C),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(Icons.arrow_back, size: 16, color: Colors.white),
          ),
          const Spacer(),
          const Text(
            '근처 하숙이들',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(Icons.more_vert, size: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildMapBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
        image: const DecorationImage(
          image: NetworkImage('https://via.placeholder.com/343x520/87CEEB/FFFFFF?text=Map'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildMapElements() {
    return Stack(
      children: [
        // 지도 위의 마커들 (정확한 위치)
        Positioned(
          top: 152,
          left: 93,
          child: _buildMapMarker(),
        ),
        Positioned(
          top: 246,
          right: 82,
          child: _buildMapMarker(),
        ),
        Positioned(
          top: 322,
          left: 93,
          child: _buildMapMarker(),
        ),
        Positioned(
          top: 421,
          right: 130,
          child: _buildMapMarker(),
        ),
        Positioned(
          bottom: 73,
          left: 120,
          child: _buildMapMarker(),
        ),
        
        // 중앙 마커 (선택된 위치) - 정확한 위치
        Positioned(
          top: 260,
          left: 144,
          child: Container(
            width: 54,
            height: 18,
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Center(
              child: Text(
                '현재 위치',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMapMarker() {
    return Container(
      width: 22,
      height: 26,
      child: Stack(
        children: [
          // 마커 외곽선 (검은색 원)
          Container(
            width: 22,
            height: 26,
            decoration: const BoxDecoration(
              color: Color(0xFF323232),
              shape: BoxShape.circle,
            ),
          ),
          // 마커 내부 (회색 원)
          Positioned(
            top: 6,
            left: 6,
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Color(0xFF8F8F8F),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCard() {
    return Container(
      width: double.infinity,
      height: 293,
      decoration: const BoxDecoration(
        color: Color(0xFFF2F3F9),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Column(
        children: [
          // 상단 핸들
          Container(
            width: 83,
            height: 4,
            margin: const EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          
          // 카드 내용
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // 프로필 이미지
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E0E0),
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        image: NetworkImage('https://via.placeholder.com/64x64/FFB6C1/FFFFFF?text=Profile'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 19),
                  
                  // 정보 영역
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 텍스트 정보
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '김하숙',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '청소 완료율: 85%',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                '거리: 0.3km',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // 좋아요 버튼
                        Container(
                          width: 24,
                          height: 24,
                          child: const Icon(
                            Icons.favorite,
                            color: Color(0xFFFF6B6B),
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomTabBar() {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFEEEEEE), width: 1),
        ),
      ),
      child: Row(
        children: [
          _buildTabItem(0, Icons.home, '홈', isSelected: selectedTabIndex == 0),
          _buildTabItem(1, Icons.map, '지도', isSelected: selectedTabIndex == 1),
          _buildTabItem(2, Icons.cleaning_services, '청소하기', isSelected: selectedTabIndex == 2),
          _buildTabItem(3, Icons.chat, '커뮤니티', isSelected: selectedTabIndex == 3),
          _buildTabItem(4, Icons.person, '마이', isSelected: selectedTabIndex == 4),
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
              color: isSelected ? const Color(0xFF00FFAA) : const Color(0xFFAAAAAA),
              size: 24,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? const Color(0xFF00FFAA) : const Color(0xFFAAAAAA),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 탭 전환 기능
  void _onTabTapped(int index) {
    setState(() {
      selectedTabIndex = index;
    });
    
    switch (index) {
      case 0: // 홈
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1: // 지도
        // 이미 지도 화면에 있음
        break;
      case 2: // 청소하기
        _showCleaningScreen(context);
        break;
      case 3: // 커뮤니티
        _showCommunityScreen(context);
        break;
      case 4: // 마이
        _showMyScreen(context);
        break;
    }
  }

  // 각 탭별 화면들
  void _showCleaningScreen(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('청소하기'),
        content: const Text('청소 가이드와 체크리스트가 여기에 표시됩니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('시작하기'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
        ],
      ),
    );
  }

  void _showCommunityScreen(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('커뮤니티'),
        content: const Text('청소 팁과 커뮤니티 게시판이 여기에 표시됩니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void _showMyScreen(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('마이'),
        content: const Text('개인 정보와 통계가 여기에 표시됩니다.'),
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