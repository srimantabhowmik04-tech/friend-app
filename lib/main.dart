import 'package:flutter/material.dart';

void main() {
  runApp(const MiniSocialApp());
}

class MiniSocialApp extends StatelessWidget {
  const MiniSocialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mini Social',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF1877F2),
        scaffoldBackgroundColor: const Color(0xFFF0F2F5),
      ),
      home: const FeedScreen(),
    );
  }
}

class PostItem {
  final String id;
  final String author;
  final String time;
  final String text;
  int likes;
  bool isLiked;
  final List<String> comments;

  PostItem({
    required this.id,
    required this.author,
    required this.time,
    required this.text,
    this.likes = 0,
    this.isLiked = false,
    List<String>? comments,
  }) : comments = comments ?? [];
}

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final TextEditingController _postController = TextEditingController();
  final List<PostItem> _posts = [
    PostItem(
      id: '1',
      author: 'Srimanta Bhowmik',
      time: '2 hrs ago',
      text: 'Welcome to Mini Social! A fast and lightweight social feed.',
      likes: 12,
      isLiked: true,
      comments: ['Awesome app!', 'Super fast!'],
    ),
    PostItem(
      id: '2',
      author: 'Tech Friend',
      time: '5 hrs ago',
      text: 'Lightweight apps save battery and storage. Loving this clean UI! 🚀',
      likes: 8,
      isLiked: false,
      comments: ['Totally agree!'],
    ),
  ];

  void _addNewPost() {
    final text = _postController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _posts.insert(
        0,
        PostItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          author: 'Srimanta Bhowmik',
          time: 'Just now',
          text: text,
        ),
      );
    });

    _postController.clear();
    Navigator.pop(context);
  }

  void _openCreatePostModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          top: 20,
          left: 16,
          right: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Create Post',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Divider(),
            TextField(
              controller: _postController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: "What's on your mind?",
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1877F2),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: _addNewPost,
              child: const Text('Post', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showCommentsModal(PostItem post) {
    final TextEditingController commentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 16,
            left: 16,
            right: 16,
          ),
          child: Column(
            children: [
              const Text('Comments', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              const Divider(),
              Expanded(
                child: post.comments.isEmpty
                    ? const Center(child: Text('No comments yet. Write one!'))
                    : ListView.builder(
                        itemCount: post.comments.length,
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F2F5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(post.comments[index]),
                        ),
                      ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: commentController,
                      decoration: const InputDecoration(
                        hintText: 'Write a comment...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Color(0xFF1877F2)),
                    onPressed: () {
                      if (commentController.text.trim().isNotEmpty) {
                        setState(() {
                          post.comments.add(commentController.text.trim());
                        });
                        setModalState(() {});
                        commentController.clear();
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          'mini social',
          style: TextStyle(
            color: Color(0xFF1877F2),
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          // Create Post Header Box (Facebook style)
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFF1877F2),
                  child: Text('S', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: _openCreatePostModal,
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F2F5),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        "What's on your mind?",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Posts Feed List
          ..._posts.map((post) {
            return Container(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color(0xFFE7F3FF),
                        child: Text(
                          post.author[0],
                          style: const TextStyle(
                            color: Color(0xFF1877F2),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post.author, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          Text(post.time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                      const Spacer(),
                      PopupMenuButton<String>(
                        onSelected: (val) {
                          if (val == 'delete') {
                            setState(() {
                              _posts.removeWhere((item) => item.id == post.id);
                            });
                          }
                        },
                        itemBuilder: (ctx) => [
                          const PopupMenuItem(value: 'delete', child: Text('Delete Post')),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    post.text,
                    style: const TextStyle(fontSize: 15, height: 1.35),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${post.likes} Likes', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      Text('${post.comments.length} Comments', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            post.isLiked = !post.isLiked;
                            post.likes += post.isLiked ? 1 : -1;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                          child: Row(
                            children: [
                              Icon(
                                post.isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                                size: 18,
                                color: post.isLiked ? const Color(0xFF1877F2) : Colors.grey[700],
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Like',
                                style: TextStyle(
                                  color: post.isLiked ? const Color(0xFF1877F2) : Colors.grey[700],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => _showCommentsModal(post),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                          child: Row(
                            children: [
                              Icon(Icons.chat_bubble_outline, size: 18, color: Colors.grey[700]),
                              const SizedBox(width: 6),
                              Text(
                                'Comment',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
