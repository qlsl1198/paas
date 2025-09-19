import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'home_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int selectedTabIndex = 1; // 지도 탭이 선택된 상태
  final MapController _mapController = MapController();
  double _currentZoom = 15;
  int? _selectedIndex;

  final List<Map<String, dynamic>> savedLocations = [
    {
      'title': '민애님의 하숙이',
      'lastDate': '2025.07.23',
      'count': '13회',
      'favorite': true,
      'lat': 37.5665,
      'lng': 126.9780,
    },
    {
      'title': '우리동네 하수구',
      'lastDate': '2025.07.18',
      'count': '7회',
      'favorite': false,
      'lat': 37.5700,
      'lng': 126.9820,
    },
    {
      'title': '학교 앞 배수로',
      'lastDate': '2025.07.11',
      'count': '5회',
      'favorite': false,
      'lat': 37.5630,
      'lng': 126.9750,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 상단 네비게이션 바 (Group 177178) - 높이: 50px
            _buildTopNavigationBar(),
            // 지도 영역
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  // 지도 배경 (지도 GROUP) - 전체 화면
                  _buildMapBackground(),
                  // 플로팅 액션 버튼들
                  _buildFloatingActionButtons(),
                  // 하단 정보 카드 (시트가 가장 위에서 아이콘을 가리도록 마지막에 렌더링)
                  _buildBottomInfoCard(),
                ],
              ),
            ),
            // 하단 탭바 (네비게이터) - 높이: 90px
            _buildBottomTabBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopNavigationBar() {
    return Container(
      height: 50,
      color: Colors.white,
      child: Stack(
        children: [
          // 뒤로가기 버튼 (Frame 65 - mingcute:left-fill) - 위치: (16, 13)
          Positioned(
            left: 16,
            top: 13,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 24,
                height: 24,
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          // 중앙 제목 (가운데 정렬)
          Positioned.fill(
            child: Center(
              child: Text(
                '지도',
                style: const TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapBackground() {
    final LatLng initialCenter = LatLng(
      (savedLocations.first['lat'] as double),
      (savedLocations.first['lng'] as double),
    );
    return Positioned.fill(
      child: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: initialCenter,
          initialZoom: _currentZoom,
          interactionOptions: const InteractionOptions(
            flags: InteractiveFlag.all,
          ),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.paas',
            tileProvider: CancellableNetworkTileProvider(),
          ),
          MarkerLayer(markers: _buildMarkers()),
        ],
      ),
    );
  }

  List<Marker> _buildMarkers() {
    return List<Marker>.generate(savedLocations.length, (index) {
      final item = savedLocations[index];
      final LatLng pos = LatLng(item['lat'] as double, item['lng'] as double);
      final bool isSelected = _selectedIndex == index;
      return Marker(
        point: pos,
        width: 26,
        height: 26,
        child: GestureDetector(
          onTap: () => _onSelectLocation(index, animate: false),
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF2E7DFF) : const Color(0xFF323232),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : const Color(0xFF8F8F8F),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildFloatingActionButtons() {
    return Stack(
      children: [
        // 나침반 버튼 (회전 초기화) - 위치: (17, 94)
        Positioned(
          left: 17,
          top: 94,
          child: _buildFloatingButton(
            icon: Icons.explore_outlined,
            onTap: _resetRotation,
          ),
        ),
        // 하트 버튼 (선택 위치 즐겨찾기 토글) - 위치: (17, 146)
        Positioned(
          left: 17,
          top: 146,
          child: _buildFloatingButton(
            icon: Icons.favorite,
            onTap: _toggleFavorite,
          ),
        ),
        // 위치 버튼 (내 위치로 이동) - 위치: (17, 461)
        Positioned(
          left: 17,
          top: 461,
          child: _buildFloatingButton(
            icon: Icons.location_on,
            onTap: _goToMyLocation,
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFFB0B0B0),
            width: 1.5,
          ),
        ),
        child: Icon(
          icon,
          color: Colors.black,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildBottomInfoCard() {
    // 드래그로 크기 조절 가능한 하단 시트 (항상 하단 정렬)
    return Align(
      alignment: Alignment.bottomCenter,
      child: DraggableScrollableSheet(
        initialChildSize: 0.30,
        minChildSize: 0.18,
        maxChildSize: 0.85,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Color(0xFFF2F3F9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: CustomScrollView(
              controller: scrollController,
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverToBoxAdapter(
                  child: Center(
                    child: Container(
                      width: 83,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 12)),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  sliver: SliverList.separated(
                    itemCount: savedLocations.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = savedLocations[index];
                      return GestureDetector(
                        onTap: () => _onSelectLocation(index),
                        child: _buildSavedLocationItem(
                          title: item['title'] as String,
                          lastDate: item['lastDate'] as String,
                          count: item['count'] as String,
                          isFavorite: (item['favorite'] as bool?) ?? false,
                        ),
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 16)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSavedLocationItem({
    required String title,
    required String lastDate,
    required String count,
    required bool isFavorite,
  }) {
    return Container(
      width: double.infinity,
      height: 92,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          // 썸네일 64x64
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.place, color: Colors.grey, size: 28),
          ),
          const SizedBox(width: 19),
          // 텍스트들
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Text(
                            '최근 청소 날짜',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFAAAAAA),
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              lastDate,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF4F4F4F),
                                height: 1.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Row(
                        children: [
                          const Text(
                            '최근 청소 횟수',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFAAAAAA),
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              count,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF4F4F4F),
                                height: 1.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: const Color(0xFF2E7DFF),
            size: 20,
          ),
        ],
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
        Navigator.pushReplacementNamed(context, '/community');
        break;
      case 4: // 마이
        Navigator.pushReplacementNamed(context, '/my');
        break;
    }
  }

  void _showCompassDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('나침반'),
        content: const Text('나침반 기능이 여기에 표시됩니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void _showFavoriteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('즐겨찾기'),
        content: const Text('즐겨찾기 기능이 여기에 표시됩니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void _showLocationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('위치'),
        content: const Text('현재 위치 기능이 여기에 표시됩니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  Future<void> _goToMyLocation() async {
    final permission = await Geolocator.checkPermission();
    LocationPermission granted = permission;
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      granted = await Geolocator.requestPermission();
    }
    if (granted == LocationPermission.always || granted == LocationPermission.whileInUse) {
      final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final center = LatLng(pos.latitude, pos.longitude);
      _mapController.move(center, _currentZoom);
    } else {
      if (!context.mounted) return;
      _showLocationDialog();
    }
  }

  void _resetRotation() {
    // flutter_map 7.x는 기본 회전 미지원, 확대/이동 초기화로 대체
    if (savedLocations.isEmpty) return;
    final LatLng initial = LatLng(savedLocations.first['lat'] as double, savedLocations.first['lng'] as double);
    _mapController.move(initial, 15);
  }

  void _toggleFavorite() {
    if (_selectedIndex == null) return;
    setState(() {
      final current = savedLocations[_selectedIndex!]['favorite'] as bool? ?? false;
      savedLocations[_selectedIndex!]['favorite'] = !current;
    });
  }

  void _onSelectLocation(int index, {bool animate = true}) {
    setState(() {
      _selectedIndex = index;
    });
    final item = savedLocations[index];
    final LatLng center = LatLng(item['lat'] as double, item['lng'] as double);
    _mapController.move(center, _currentZoom);
  }

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