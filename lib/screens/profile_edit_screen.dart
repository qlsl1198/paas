import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController _nicknameController = TextEditingController();
  bool _isNicknameAvailable = false;
  bool _isCheckingNickname = false;
  
  // 선택된 값들
  String selectedBirthDate = '';
  String selectedRegion = '';
  String selectedGender = '남성'; // 기본값

  @override
  void initState() {
    super.initState();
    _nicknameController.text = '김솜이'; // 기본값
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
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _buildProfileImageSection(),
                    const SizedBox(height: 28),
                    _buildFormSection(),
                    const SizedBox(height: 80),
                    _buildSaveButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildTopNavigationBar() {
    return const CustomAppBar(
      title: '프로필 수정',
      showBackButton: true,
    );
  }

  Widget _buildProfileImageSection() {
    return Column(
      children: [
        // 프로필 이미지
        Stack(
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2E7DFF), width: 1),
                image: const DecorationImage(
                  image: AssetImage('assets/images/notification1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // 편집 버튼
            Positioned(
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  _showImagePicker();
                },
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F3F9),
                    border: Border.all(color: const Color(0xFF2E7DFF), width: 1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Color(0xFF2E7DFF),
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFormSection() {
    return Column(
      children: [
        // 닉네임 입력 필드
        _buildInputField(
          label: '닉네임',
          hintText: '닉네임을 입력해주세요',
          controller: _nicknameController,
          onChanged: (value) => _checkNicknameAvailability(value),
          suffixIcon: _isCheckingNickname
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: Center(
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7DFF)),
                      ),
                    ),
                  ),
                )
              : _nicknameController.text.isNotEmpty
                  ? Icon(
                      _isNicknameAvailable ? Icons.check_circle : Icons.cancel,
                      color: _isNicknameAvailable ? Colors.green : Colors.red,
                      size: 20,
                    )
                  : null,
        ),
        const SizedBox(height: 12),
        // 생년월일 선택 필드
        _buildDropdownField(
          label: '생년월일',
          hintText: '생년월일을 입력해주세요.',
          value: selectedBirthDate,
          onTap: _showBirthDatePicker,
        ),
        const SizedBox(height: 12),
        // 지역 선택 필드
        _buildDropdownField(
          label: '지역',
          hintText: '지역을 선택해주세요.',
          value: selectedRegion,
          onTap: _showRegionPicker,
        ),
        const SizedBox(height: 12),
        // 성별 선택 필드
        _buildGenderSelector(),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required String hintText,
    TextEditingController? controller,
    bool isPassword = false,
    Widget? suffixIcon,
    Function(String)? onChanged,
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
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFCCCCCC), width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Color(0xFF8A8A8A),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              suffixIcon: suffixIcon,
            ),
          ),
        ),
        if (controller == _nicknameController && _nicknameController.text.isNotEmpty && !_isCheckingNickname)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              _isNicknameAvailable ? '사용 가능한 닉네임입니다' : '이미 사용 중인 닉네임입니다',
              style: TextStyle(
                fontSize: 12,
                color: _isNicknameAvailable ? Colors.green : Colors.red,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hintText,
    required String value,
    required VoidCallback onTap,
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
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFCCCCCC), width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value.isEmpty ? hintText : value,
                    style: TextStyle(
                      fontSize: 14,
                      color: value.isEmpty ? const Color(0xFF8A8A8A) : Colors.black,
                    ),
                  ),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD9D9D9),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '성별',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => selectedGender = '남성'),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: selectedGender == '남성' ? const Color(0xFFF2F3F9) : Colors.white,
                    border: Border.all(
                      color: selectedGender == '남성' ? const Color(0xFF2E7DFF) : const Color(0xFFCCCCCC),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '남성',
                      style: TextStyle(
                        fontSize: 14,
                        color: selectedGender == '남성' ? const Color(0xFF2E7DFF) : const Color(0xFF8A8A8A),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => selectedGender = '여성'),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: selectedGender == '여성' ? const Color(0xFFF2F3F9) : Colors.white,
                    border: Border.all(
                      color: selectedGender == '여성' ? const Color(0xFF2E7DFF) : const Color(0xFFCCCCCC),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '여성',
                      style: TextStyle(
                        fontSize: 14,
                        color: selectedGender == '여성' ? const Color(0xFF2E7DFF) : const Color(0xFF8A8A8A),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _isNicknameAvailable ? _saveProfile : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2E7DFF),
          disabledBackgroundColor: const Color(0xFFCCCCCC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
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

  void _checkNicknameAvailability(String nickname) {
    if (nickname.isEmpty) {
      setState(() {
        _isNicknameAvailable = false;
        _isCheckingNickname = false;
      });
      return;
    }

    setState(() {
      _isCheckingNickname = true;
    });

    // 실제로는 서버 API를 호출해야 하지만, 여기서는 시뮬레이션
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isCheckingNickname = false;
        // '김솜이'는 이미 사용 중, 다른 닉네임은 사용 가능으로 시뮬레이션
        _isNicknameAvailable = nickname != '김솜이';
      });
    });
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '프로필 이미지 선택',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('카메라로 촬영'),
              onTap: () {
                Navigator.pop(context);
                // 카메라 기능 구현
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('갤러리에서 선택'),
              onTap: () {
                Navigator.pop(context);
                // 갤러리 기능 구현
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('취소'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showBirthDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 20)), // 20세 기본값
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate != null) {
        setState(() {
          selectedBirthDate = '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일';
        });
      }
    });
  }

  void _showRegionPicker() {
    final regions = [
      '서울특별시',
      '부산광역시',
      '대구광역시',
      '인천광역시',
      '광주광역시',
      '대전광역시',
      '울산광역시',
      '세종특별자치시',
      '경기도',
      '강원도',
      '충청북도',
      '충청남도',
      '전라북도',
      '전라남도',
      '경상북도',
      '경상남도',
      '제주특별자치도',
    ];

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 400,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                '지역 선택',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: regions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(regions[index]),
                    onTap: () {
                      setState(() {
                        selectedRegion = regions[index];
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveProfile() {
    if (_isNicknameAvailable) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('프로필 수정 완료'),
          content: const Text('프로필이 성공적으로 수정되었습니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // 다이얼로그 닫기
                Navigator.pop(context); // 프로필 수정 화면 닫기
              },
              child: const Text('확인'),
            ),
          ],
        ),
      );
    }
  }
}