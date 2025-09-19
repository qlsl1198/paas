import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'notification_screen.dart';

enum WeatherType {
  cloudy, // 흐림
  sunny,  // 맑음
  rainy   // 비
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTabIndex = 0;
  List<int> cleanedDays = [4, 6];
  DateTime currentDate = DateTime.now();
  DateTime displayedMonth = DateTime.now();
  WeatherType currentWeather = WeatherType.cloudy; // 기본값: 흐림

  String getWeatherText() {
    switch (currentWeather) {
      case WeatherType.cloudy:
        return '날씨가 흐려요';
      case WeatherType.sunny:
        return '날씨가 맑아요';
      case WeatherType.rainy:
        return '비가 와요';
    }
  }

  Widget getWeatherBackground() {
    switch (currentWeather) {
      case WeatherType.cloudy:
        return Stack(
          children: [
            // 노란색 원 (Ellipse 4) - Figma 정확한 위치: x: 255, y: 163
            Positioned(
              left: 255,
              top: 163,
              child: Container(
                width: 77,
                height: 77,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFCB2D),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // 구름 Vector - Figma 정확한 위치: x: 144, y: 178
            Positioned(
              left: 144,
              top: 178,
              child: Container(
                width: 206,
                height: 125,
                child: SvgPicture.asset(
                  'assets/images/cloud.svg',
                  width: 206,
                  height: 125,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // 해 Vector - Figma 정확한 위치: x: -122, y: 121 (카드 밖으로 나감)
            Positioned(
              left: -122,
              top: 121,
              child: Container(
                width: 206,
                height: 125,
                child: SvgPicture.asset(
                  'assets/images/sun.svg',
                  width: 206,
                  height: 125,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        );
      case WeatherType.sunny:
        return Container(); // 빈 컨테이너
      case WeatherType.rainy:
        return Container(); // 빈 컨테이너
    }
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
                    _buildCleaningCompleteCard(),
                    const SizedBox(height: 20),
                    _buildMonthlyCleaningRecord(),
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
      color: Colors.white,
      child: Stack(
        children: [
          Center(
            child: Text(
              '홈',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: 13,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/notification'),
              child: const Icon(Icons.notifications_outlined, size: 24, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  void _changeWeather() {
    setState(() {
      switch (currentWeather) {
        case WeatherType.cloudy:
          currentWeather = WeatherType.sunny;
          break;
        case WeatherType.sunny:
          currentWeather = WeatherType.rainy;
          break;
        case WeatherType.rainy:
          currentWeather = WeatherType.cloudy;
          break;
      }
    });
  }

  Widget _buildCleaningCompleteCard() {
    return GestureDetector(
      onTap: _changeWeather,
      child: Container(
        height: 358,
        decoration: BoxDecoration(
          color: const Color(0xFFE8ECF6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            getWeatherBackground(),
            Positioned(
            left: 24,
            top: 56,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '미래님,',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF111111),
                    height: 1.2,
                  ),
                ),
                Text(
                  getWeatherText(),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111111),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '오늘 하수구 주변을\n한 번만 살펴봐 주세요.',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF4A4A4A),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${currentDate.year}년 ${currentDate.month}월 ${currentDate.day}일',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF686868),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildMonthlyCleaningRecord() {
    final cleanedCount = cleanedDays.length;
    
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => _previousMonth(),
              child: const Icon(Icons.chevron_left, size: 24, color: Color(0xFF4A4A4A)),
            ),
            Text(
              '${displayedMonth.year}년 ${displayedMonth.month}월',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            GestureDetector(
              onTap: () => _nextMonth(),
              child: const Icon(Icons.chevron_right, size: 24, color: Color(0xFF4A4A4A)),
            ),
          ],
        ),
        const SizedBox(height: 19),
        Row(
          children: ['일', '월', '화', '수', '목', '금', '토'].map((day) {
            return Expanded(
              child: Container(
                height: 49,
                child: Center(
                  child: Text(
                    day,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        _buildCalendarGrid(),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () => _completeCleaning(context),
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF2E7DFF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                '청소완료',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarGrid() {
    final firstDayOfMonth = DateTime(displayedMonth.year, displayedMonth.month, 1);
    final lastDayOfMonth = DateTime(displayedMonth.year, displayedMonth.month + 1, 0);
    final firstWeekday = firstDayOfMonth.weekday % 7;
    
    final daysInMonth = lastDayOfMonth.day;
    final totalDays = firstWeekday + daysInMonth;
    final weeks = (totalDays / 7).ceil();
    
    return Column(
      children: List.generate(weeks, (weekIndex) {
        return Row(
          children: List.generate(7, (dayIndex) {
            final dayNumber = weekIndex * 7 + dayIndex - firstWeekday + 1;
            
            if (dayNumber <= 0 || dayNumber > daysInMonth) {
              final otherMonthDay = dayNumber <= 0 
                ? DateTime(displayedMonth.year, displayedMonth.month - 1, 0).day + dayNumber
                : dayNumber - daysInMonth;
              
              return _buildCalendarDay(
                otherMonthDay.toString(),
                isOtherMonth: true,
                isToday: false,
                isCleaned: false,
              );
            } else {
              final isToday = displayedMonth.year == currentDate.year &&
                            displayedMonth.month == currentDate.month &&
                            dayNumber == currentDate.day;
              final isCleaned = cleanedDays.contains(dayNumber);
              
              return _buildCalendarDay(
                dayNumber.toString(),
                isOtherMonth: false,
                isToday: isToday,
                isCleaned: isCleaned,
              );
            }
          }),
        );
      }),
    );
  }

  Widget _buildCalendarDay(String day, {
    bool isOtherMonth = false, 
    bool isToday = false, 
    bool isCleaned = false
  }) {
    Color backgroundColor = Colors.transparent;
    Color textColor = Colors.black;
    
    if (isCleaned) {
      backgroundColor = const Color(0xFF2E7DFF);
      textColor = Colors.white;
    } else if (isToday) {
      backgroundColor = const Color(0xFFFFCB2D);
      textColor = Colors.white;
    } else if (isOtherMonth) {
      textColor = const Color(0xFFAAAAAA);
    }
    
    return Expanded(
      child: Container(
        height: 49,
        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: isToday && !isCleaned 
            ? Border.all(color: const Color(0xFFFFCB2D), width: 2)
            : null,
        ),
        child: Center(
          child: Text(
            day,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
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

  void _previousMonth() {
    setState(() {
      displayedMonth = DateTime(displayedMonth.year, displayedMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      displayedMonth = DateTime(displayedMonth.year, displayedMonth.month + 1, 1);
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      selectedTabIndex = index;
    });
    
    switch (index) {
      case 0: // 홈
        // 이미 홈 화면에 있음
        break;
      case 1: // 지도
        Navigator.pushReplacementNamed(context, '/map');
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

  void _completeCleaning(BuildContext context) {
    final today = currentDate.day;
    if (!cleanedDays.contains(today)) {
      setState(() {
        cleanedDays.add(today);
      });
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('청소 완료!'),
          content: Text('${currentDate.month}월 ${today}일 청소가 완료되었습니다.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('확인'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('이미 완료'),
          content: const Text('오늘은 이미 청소가 완료되었습니다.'),
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

  void _showMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('메뉴'),
        content: const Text('메뉴 옵션들이 여기에 표시됩니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }

  void _showSearch(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('검색'),
        content: const TextField(
          decoration: InputDecoration(
            hintText: '검색어를 입력하세요',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('검색'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
        ],
      ),
    );
  }


  void _showSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('설정'),
        content: const Text('설정 옵션들이 여기에 표시됩니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
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


}
