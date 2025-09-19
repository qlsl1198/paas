import 'package:flutter/material.dart';
import 'drain_registration_screen.dart';

class DrainManagementScreen extends StatefulWidget {
  const DrainManagementScreen({super.key});

  @override
  State<DrainManagementScreen> createState() => _DrainManagementScreenState();
}

class _DrainManagementScreenState extends State<DrainManagementScreen> {
  // 샘플 하수구 데이터
  final List<Map<String, dynamic>> drains = [
    {
      'id': 1,
      'name': '대구 남구 대명동 하수구',
      'location': '대구 남구 대명동 123-45',
      'status': 'active',
      'lastCleaned': '2024-01-15',
      'cleaningCount': 5,
      'imageUrl': 'assets/images/notification1.png',
    },
    {
      'id': 2,
      'name': '대구 수성구 범어동 하수구',
      'location': '대구 수성구 범어동 67-89',
      'status': 'active',
      'lastCleaned': '2024-01-10',
      'cleaningCount': 3,
      'imageUrl': 'assets/images/notification2.png',
    },
    {
      'id': 3,
      'name': '대구 달서구 월성동 하수구',
      'location': '대구 달서구 월성동 12-34',
      'status': 'inactive',
      'lastCleaned': '2023-12-20',
      'cleaningCount': 1,
      'imageUrl': 'assets/images/notification3.png',
    },
  ];

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
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _buildDrainList(),
                    const SizedBox(height: 20),
                    _buildAddDrainButton(),
                    const SizedBox(height: 100), // 하단 탭바를 위한 여백
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomTabBar(),
    );
  }

  Widget _buildTopNavigationBar() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
        ),
      ),
      child: Row(
        children: [
          // 뒤로가기 버튼
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 24,
              height: 24,
              margin: const EdgeInsets.only(left: 16),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 16,
                color: Color(0xFF4A4A4A),
              ),
            ),
          ),
          // 제목
          const Expanded(
            child: Text(
              '내가 입양한 하수구',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          // 오른쪽 공간 (뒤로가기 버튼과 균형 맞추기)
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildDrainList() {
    if (drains.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: drains.map((drain) => _buildDrainCard(drain)).toList(),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      height: 229,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F3F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.water_drop_outlined,
            size: 64,
            color: Color(0xFFAAAAAA),
          ),
          SizedBox(height: 16),
          Text(
            '아직 입양한 하수구가 없습니다',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFFAAAAAA),
            ),
          ),
          SizedBox(height: 8),
          Text(
            '첫 번째 하수구를 입양해보세요!',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFFAAAAAA),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrainCard(Map<String, dynamic> drain) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // 하수구 이미지
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(drain['imageUrl']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // 하수구 정보
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      drain['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      drain['location'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4A4A4A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: drain['status'] == 'active' 
                                ? const Color(0xFF2E7DFF) 
                                : const Color(0xFFAAAAAA),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            drain['status'] == 'active' ? '활성' : '비활성',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '청소 ${drain['cleaningCount']}회',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF4A4A4A),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // 메뉴 버튼
              PopupMenuButton<String>(
                onSelected: (value) => _handleDrainAction(value, drain),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Text('수정'),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('삭제'),
                  ),
                ],
                child: const Icon(
                  Icons.more_vert,
                  color: Color(0xFF4A4A4A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // 마지막 청소일
          Row(
            children: [
              const Icon(
                Icons.cleaning_services,
                size: 16,
                color: Color(0xFF4A4A4A),
              ),
              const SizedBox(width: 4),
              Text(
                '마지막 청소: ${drain['lastCleaned']}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF4A4A4A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddDrainButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DrainRegistrationScreen(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2E7DFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          '하수구 등록',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
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

  void _handleDrainAction(String action, Map<String, dynamic> drain) {
    switch (action) {
      case 'edit':
        _showEditDrainDialog(drain);
        break;
      case 'delete':
        _showDeleteConfirmDialog(drain);
        break;
    }
  }

  void _showAddDrainDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController locationController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('하수구 등록'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: '하수구 이름',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: '위치',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty && locationController.text.isNotEmpty) {
                setState(() {
                  drains.add({
                    'id': drains.length + 1,
                    'name': nameController.text,
                    'location': locationController.text,
                    'status': 'active',
                    'lastCleaned': DateTime.now().toString().split(' ')[0],
                    'cleaningCount': 0,
                    'imageUrl': 'assets/images/notification1.png',
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('하수구가 등록되었습니다')),
                );
              }
            },
            child: const Text('등록'),
          ),
        ],
      ),
    );
  }

  void _showEditDrainDialog(Map<String, dynamic> drain) {
    final TextEditingController nameController = TextEditingController(text: drain['name']);
    final TextEditingController locationController = TextEditingController(text: drain['location']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('하수구 수정'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: '하수구 이름',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: '위치',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                drain['name'] = nameController.text;
                drain['location'] = locationController.text;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('하수구 정보가 수정되었습니다')),
              );
            },
            child: const Text('수정'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmDialog(Map<String, dynamic> drain) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('하수구 삭제'),
        content: Text('${drain['name']}을(를) 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                drains.remove(drain);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('하수구가 삭제되었습니다')),
              );
            },
            child: const Text('삭제'),
          ),
        ],
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
        Navigator.pushReplacementNamed(context, '/my');
        break;
    }
  }
}
