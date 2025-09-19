import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'post_detail_screen.dart';
import 'write_post_screen.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  int selectedCategoryIndex = 0;
  final List<String> categories = ['전체', '자유', '인증', '꿀팁', '지역'];

  // 샘플 게시글 데이터
  final List<Map<String, dynamic>> posts = [
    {
      'id': 1,
      'category': '자유',
      'title': '빗물 길 트기 완료!',
      'content': '장마철 대비 겸 해서 하수구 확인했는데 꽉 막혀 있더라구요.지금은 깨끗하게 청소 끝~!작은 ...',
      'location': '대구 남구 대명동',
      'author': '익명',
      'date': '2시간 전',
      'likes': 123,
      'views': 123,
      'imageUrl': 'assets/images/notification1.png',
      'isLiked': false,
    },
    {
      'id': 2,
      'category': '인증',
      'title': '청소 인증샷 올립니다!',
      'content': '오늘 아침에 하수구 청소 완료했습니다. 깨끗하게 정리했어요~',
      'location': '서울 강남구 역삼동',
      'author': '청소왕',
      'date': '3시간 전',
      'likes': 89,
      'views': 156,
      'imageUrl': 'assets/images/notification2.png',
      'isLiked': true,
    },
    {
      'id': 3,
      'category': '꿀팁',
      'title': '하수구 냄새 제거 꿀팁',
      'content': '하수구 냄새가 심할 때 베이킹소다와 식초를 섞어서 부어보세요!',
      'location': '부산 해운대구 우동',
      'author': '청소마스터',
      'date': '5시간 전',
      'likes': 67,
      'views': 234,
      'imageUrl': 'assets/images/notification3.png',
      'isLiked': false,
    },
    {
      'id': 4,
      'category': '지역',
      'title': '대구 지역 청소 모임',
      'content': '대구 지역 청소 모임을 만들었습니다. 함께 참여해주세요!',
      'location': '대구 수성구 범어동',
      'author': '지역대표',
      'date': '1일 전',
      'likes': 45,
      'views': 89,
      'imageUrl': 'assets/images/notification4.png',
      'isLiked': false,
    },
    {
      'id': 5,
      'category': '자유',
      'title': '청소 도구 추천해주세요',
      'content': '하수구 청소에 좋은 도구가 있으면 추천해주세요!',
      'location': '인천 연수구 송도동',
      'author': '청소초보',
      'date': '2일 전',
      'likes': 23,
      'views': 67,
      'imageUrl': 'assets/images/notification1.png',
      'isLiked': true,
    },
    {
      'id': 6,
      'category': '인증',
      'title': '주말 청소 완료!',
      'content': '주말에 집 주변 청소를 완료했습니다. 깨끗해졌어요!',
      'location': '광주 서구 치평동',
      'author': '주말청소러',
      'date': '3일 전',
      'likes': 34,
      'views': 78,
      'imageUrl': 'assets/images/notification2.png',
      'isLiked': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _buildTopNavigationBar(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildTrendingSection(),
                        _buildTopCards(),
                        _buildCategoryTabs(),
                        _buildPostsList(),
                        const SizedBox(height: 100), // 플로팅 버튼을 위한 여백
                      ],
                    ),
                  ),
                ),
              ],
            ),
            _buildFloatingActionButton(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomTabBar(),
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
              '커뮤니티',
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
              onTap: () {
                // 알림 화면으로 이동
              },
              child: const Icon(
                Icons.notifications_outlined,
                size: 24,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopCards() {
    // 자유 카테고리의 최신 게시글 찾기
    final freePosts = posts.where((post) => post['category'] == '자유').toList();
    final latestFreePost = freePosts.isNotEmpty ? freePosts.first : null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // 공지사항 카드
          Expanded(
            child: GestureDetector(
              onTap: () {
                _showNoticeDialog();
              },
              child: Container(
                height: 146,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7DFF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '공지사항',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        '커뮤니티 가이드라인',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(
                            Icons.visibility_outlined,
                            color: Colors.white,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            '1,234',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // 자유 게시글 카드
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (latestFreePost != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDetailScreen(post: latestFreePost),
                    ),
                  );
                }
              },
              child: Container(
                height: 146,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F3F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '자유',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        latestFreePost?['title'] ?? '게시글이 없습니다',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      if (latestFreePost != null)
                        Row(
                          children: [
                            const Icon(
                              Icons.visibility_outlined,
                              color: Color(0xFF4A4A4A),
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              latestFreePost['views'].toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF4A4A4A),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Icon(
                              Icons.favorite,
                              color: Color(0xFF4A4A4A),
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              latestFreePost['likes'].toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF4A4A4A),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Row(
        children: [
          Text(
            '지금 가장 시원한 하수구',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 2),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
            ),
            child: const Center(
              child: Text(
                '🌬️',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.asMap().entries.map((entry) {
            int index = entry.key;
            String category = entry.value;
            bool isSelected = selectedCategoryIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategoryIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF767676) : Colors.transparent,
                  border: isSelected ? null : Border.all(color: const Color(0xFFAAAAAA)),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : const Color(0xFFAAAAAA),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildPostsList() {
    // 선택된 카테고리에 따라 게시글 필터링
    List<Map<String, dynamic>> filteredPosts = posts;
    
    if (selectedCategoryIndex > 0) {
      String selectedCategory = categories[selectedCategoryIndex];
      filteredPosts = posts.where((post) => post['category'] == selectedCategory).toList();
    }
    
    // 게시글이 없을 때 빈 상태 표시
    if (filteredPosts.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              '${categories[selectedCategoryIndex]} 카테고리에 게시글이 없습니다',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '첫 번째 게시글을 작성해보세요!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: filteredPosts.map((post) => _buildPostCard(post)).toList(),
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetailScreen(post: post),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 게시글 헤더
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                  child: Text(
                    post['category'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.location_on,
                  size: 14,
                  color: const Color(0xFF4A4A4A),
                ),
                const SizedBox(width: 2),
                Text(
                  post['location'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFAAAAAA),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            // 게시글 내용
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post['title'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        post['content'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFAAAAAA),
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 22),
                // 게시글 이미지
                Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: AssetImage(post['imageUrl']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            // 좋아요/조회수
            Row(
              children: [
                _buildInteractionButton(
                  icon: Icons.visibility_outlined,
                  count: post['views'],
                ),
                const SizedBox(width: 28),
                _buildInteractionButton(
                  icon: Icons.favorite,
                  count: post['likes'],
                  isLiked: post['isLiked'],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractionButton({
    required IconData icon,
    required int count,
    bool isLiked = false,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: isLiked ? Colors.red : const Color(0xFF4A4A4A),
        ),
        const SizedBox(width: 2),
        Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF4A4A4A),
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return Positioned(
      right: 16,
      bottom: 100, // 하단 탭바 위에 위치
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WritePostScreen(),
            ),
          );
        },
        child: Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            color: Color(0xFF2E7DFF),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.edit,
            color: Colors.white,
            size: 24,
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
          _buildTabItem(3, Icons.chat, '커뮤니티', isSelected: true),
          _buildTabItem(4, Icons.person, '마이', isSelected: false),
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
        // 이미 커뮤니티 화면에 있음
        break;
      case 4: // 마이
        // 마이 화면으로 이동
        break;
    }
  }

  void _showNoticeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          '커뮤니티 가이드라인',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '건전한 커뮤니티를 위해 다음 사항을 지켜주세요:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '• 서로를 존중하는 마음으로 소통해주세요\n'
                '• 개인정보나 민감한 정보는 공유하지 마세요\n'
                '• 스팸이나 광고성 게시물은 금지됩니다\n'
                '• 청소와 관련된 유용한 정보를 공유해주세요\n'
                '• 욕설이나 비방은 삼가해주세요\n'
                '• 저작권을 침해하는 내용은 금지됩니다',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '위 규칙을 위반할 경우 게시글이 삭제되거나 계정이 제재될 수 있습니다.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              '확인',
              style: TextStyle(
                color: Color(0xFF2E7DFF),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
