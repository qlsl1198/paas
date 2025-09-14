import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Map<String, dynamic>> notifications = [
    {
      'title': 'Drain 청소 알림',
      'message': '최근 2주 동안 기록이 없어요, 확인이 필요합니다.',
      'time': '2분 전',
      'isRead': false,
      'iconType': 'drain',
    },
    {
      'title': '200L 물길 확보 성공',
      'message': '지금까지 동네 안전에 기여했어요.',
      'time': '2분 전',
      'isRead': false,
      'iconType': 'success',
    },
    {
      'title': '댓글 알림',
      'message': '내 인증글에 새로운 댓글이 달렸어요.',
      'time': '2분 전',
      'isRead': false,
      'iconType': 'comment',
    },
    {
      'title': '오늘 비 소식 있어요',
      'message': '하수구 상태를 한 번 확인해 주세요.',
      'time': '2분 전',
      'isRead': false,
      'iconType': 'rain',
    },
    {
      'title': '장마 시작 알림',
      'message': '낙엽과 쓰레기가 쌓이지 않도록 관리해 주세요.',
      'time': '2분 전',
      'isRead': false,
      'iconType': 'rain',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 상단 네비게이션 바 (Figma: Group 177178)
          _buildTopNavigationBar(context),
          // 알림 리스트 (Figma: Frame 148)
          Expanded(
            child: _buildNotificationList(),
          ),
          // 하단 홈 인디케이터 (Figma: Home Indicator/Light)
          _buildHomeIndicator(),
        ],
      ),
    );
  }

  Widget _buildTopNavigationBar(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white,
      child: Stack(
        children: [
          // 뒤로가기 버튼 (Figma: mingcute:left-fill)
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
          // 중앙 제목 (Figma: 알림 텍스트)
          Positioned(
            left: 0,
            right: 0,
            top: 13,
            child: Center(
              child: Text(
                '알림',
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
          // 휴지통 아이콘 (Figma: tabler:trash)
          Positioned(
            right: 16,
            top: 13,
            child: GestureDetector(
              onTap: _showDeleteConfirmDialog,
              child: Container(
                width: 24,
                height: 24,
                child: const Icon(
                  Icons.delete_outline,
                  size: 20,
                  color: Color(0xFF4A4A4A),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return _buildNotificationItem(notification);
      },
    );
  }

  Widget _buildNotificationIcon(String iconType) {
    String imagePath;
    switch (iconType) {
      case 'drain':
        imagePath = 'assets/images/notification3.png';
        break;
      case 'success':
        imagePath = 'assets/images/notification2.png';
        break;
      case 'comment':
        imagePath = 'assets/images/notification4.png';
        break;
      case 'rain':
        imagePath = 'assets/images/notification1.png';
        break;
      default:
        imagePath = 'assets/images/notification3.png';
    }

    return Container(
      width: 16,
      height: 16,
      child: Image.asset(
        imagePath,
        width: 16,
        height: 16,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상단 행: 아이콘 + 제목 + 시간
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 아이콘 영역 (Figma: Frame 145/144/146/143)
              Container(
                width: 16,
                height: 16,
                margin: const EdgeInsets.only(right: 4),
                child: _buildNotificationIcon(notification['iconType']),
              ),
              // 제목
              Expanded(
                child: Text(
                  notification['title'],
                  style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    height: 1.4,
                  ),
                ),
              ),
              // 시간
              Text(
                notification['time'],
                style: const TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFAAAAAA),
                  height: 1.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          // 메시지 (Figma: Frame 139)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              notification['message'],
              style: const TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFFAAAAAA),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeIndicator() {
    return Container(
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
    );
  }

  void _showDeleteConfirmDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            '알림 삭제',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          content: const Text(
            '모든 알림을 삭제하시겠습니까?',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                '취소',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFAAAAAA),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  notifications.clear();
                });
                Navigator.of(context).pop();
              },
              child: const Text(
                '삭제',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2E7DFF),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
