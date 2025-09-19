import 'package:flutter/material.dart';

class PostDetailScreen extends StatefulWidget {
  final Map<String, dynamic> post;

  const PostDetailScreen({super.key, required this.post});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  bool isLiked = false;
  final TextEditingController _commentController = TextEditingController();
  final List<Map<String, dynamic>> comments = [
    {
      'author': '익명1',
      'content': '정말 잘하셨네요! 저도 참고하겠습니다.',
      'date': '1시간 전',
      'likes': 5,
    },
    {
      'author': '익명2',
      'content': '저희 동네도 비슷한 문제가 있었는데 해결 방법이 궁금해요.',
      'date': '2시간 전',
      'likes': 3,
    },
  ];

  @override
  void initState() {
    super.initState();
    isLiked = widget.post['isLiked'] ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '게시글',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {
              // 공유 기능
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              _showMoreOptions();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPostHeader(),
            const SizedBox(height: 16),
            _buildPostImage(),
            const SizedBox(height: 16),
            _buildPostContent(),
            const SizedBox(height: 24),
            _buildInteractionButtons(),
            const SizedBox(height: 24),
            _buildCommentsSection(),
          ],
        ),
      ),
      bottomNavigationBar: _buildCommentInput(),
    );
  }

  Widget _buildPostHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(2.5),
              ),
              child: Text(
                widget.post['category'],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.location_on,
              size: 16,
              color: const Color(0xFF4A4A4A),
            ),
            const SizedBox(width: 4),
            Text(
              widget.post['location'],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFFAAAAAA),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          widget.post['title'],
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              widget.post['author'],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              widget.post['date'],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFFAAAAAA),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPostImage() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(widget.post['imageUrl']),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildPostContent() {
    return Text(
      widget.post['content'],
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black,
        height: 1.5,
      ),
    );
  }

  Widget _buildInteractionButtons() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isLiked = !isLiked;
            });
          },
          child: Row(
            children: [
              Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                color: isLiked ? Colors.red : const Color(0xFF4A4A4A),
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                widget.post['likes'].toString(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF4A4A4A),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 24),
        Row(
          children: [
            const Icon(
              Icons.visibility_outlined,
              color: Color(0xFF4A4A4A),
              size: 20,
            ),
            const SizedBox(width: 4),
            Text(
              widget.post['views'].toString(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4A4A4A),
              ),
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            // 공유 기능
          },
          child: const Icon(
            Icons.share,
            color: Color(0xFF4A4A4A),
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildCommentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '댓글 ${comments.length}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        ...comments.map((comment) => _buildCommentItem(comment)).toList(),
      ],
    );
  }

  Widget _buildCommentItem(Map<String, dynamic> comment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                comment['author'],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                comment['date'],
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFAAAAAA),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            comment['content'],
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  // 댓글 좋아요
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.thumb_up_outlined,
                      size: 16,
                      color: Color(0xFF4A4A4A),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      comment['likes'].toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF4A4A4A),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  // 댓글 신고
                },
                child: const Text(
                  '신고',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFAAAAAA),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommentInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFEEEEEE), width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _commentController,
              decoration: const InputDecoration(
                hintText: '댓글을 입력하세요...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Color(0xFFEEEEEE)),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              if (_commentController.text.isNotEmpty) {
                setState(() {
                  comments.add({
                    'author': '익명${comments.length + 1}',
                    'content': _commentController.text,
                    'date': '방금 전',
                    'likes': 0,
                  });
                  _commentController.clear();
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFF2E7DFF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.send,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.bookmark_border),
              title: const Text('북마크'),
              onTap: () {
                Navigator.pop(context);
                // 북마크 기능
              },
            ),
            ListTile(
              leading: const Icon(Icons.report_outlined),
              title: const Text('신고'),
              onTap: () {
                Navigator.pop(context);
                // 신고 기능
              },
            ),
            ListTile(
              leading: const Icon(Icons.block),
              title: const Text('차단'),
              onTap: () {
                Navigator.pop(context);
                // 차단 기능
              },
            ),
          ],
        ),
      ),
    );
  }
}
