import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class DrainRegistrationScreen extends StatefulWidget {
  const DrainRegistrationScreen({super.key});

  @override
  State<DrainRegistrationScreen> createState() => _DrainRegistrationScreenState();
}

class _DrainRegistrationScreenState extends State<DrainRegistrationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _buildDrainImageSection(),
                    const SizedBox(height: 20),
                    _buildFormSection(),
                    const SizedBox(height: 20),
                    _buildCompleteButton(),
                    const SizedBox(height: 20),
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
              '나의 하수구 등록',
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

  Widget _buildDrainImageSection() {
    return Container(
      width: 343,
      height: 229,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F3F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Container(
          width: 213,
          height: 213,
          decoration: BoxDecoration(
            color: const Color(0xFFE0E0E0),
            borderRadius: BorderRadius.circular(8),
            image: const DecorationImage(
              image: AssetImage('assets/images/app_icon.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.add_photo_alternate,
              size: 48,
              color: Color(0xFF8A8A8A),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormSection() {
    return Column(
      children: [
        // 하수구 이름
        _buildInputField(
          label: '하수구 이름',
          controller: _nameController,
          hintText: '하수구의 이름을 입력해주세요.',
        ),
        const SizedBox(height: 16),
        // 하수구 설명
        _buildInputField(
          label: '하수구 설명',
          controller: _descriptionController,
          hintText: '하수구의 설명을 입력해주세요.',
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFCCCCCC), width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Color(0xFF8A8A8A),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompleteButton() {
    return Container(
      width: 343,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF2E7DFF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        onPressed: () {
          // 하수구 등록 완료 로직
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('하수구가 성공적으로 등록되었습니다.'),
              backgroundColor: Color(0xFF2E7DFF),
            ),
          );
        },
        child: const Text(
          '완료',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
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
