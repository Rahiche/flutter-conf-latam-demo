import 'package:flutter/material.dart';
import 'package:presentation_app/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import '../services/theme_service.dart';

class SlideFrontend101 extends StatefulWidget {
  const SlideFrontend101({super.key});

  @override
  State<SlideFrontend101> createState() => _SlideFrontend101State();
}

class _SlideFrontend101State extends State<SlideFrontend101> {
  int _selectedIndex = 0;

  final List<Map<String, String>> _topics = [
    {
      'title': 'Client Initialization',
      'code': '''// main.dart
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'client/protocol.dart';

late Client client;

void main() async {
  client = Client(
    'http://localhost:8080/',
    authenticationKeyManager: FlutterAuthenticationKeyManager(),
  );
  
  runApp(MyApp());
}''',
      'description': 'Initialize Serverpod client',
    },
    {
      'title': 'Calling Endpoints',
      'code': '''// Type-safe API calls
class PostService {
  final Client client;
  
  PostService(this.client);
  
  Future<List<Post>> getAllPosts() async {
    try {
      return await client.post.getAllPosts();
    } catch (e) {
      print('Error fetching posts: \$e');
      return [];
    }
  }
  
  Future<Post?> createPost(Post post) async {
    try {
      return await client.post.createPost(post);
    } catch (e) {
      print('Error creating post: \$e');
      return null;
    }
  }
}''',
      'description': 'Type-safe endpoint calls',
    },
    {
      'title': 'State Management',
      'code': '''// Using Provider for state
class PostProvider extends ChangeNotifier {
  final Client client;
  List<Post> _posts = [];
  bool _isLoading = false;
  
  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;
  
  PostProvider(this.client);
  
  Future<void> loadPosts() async {
    _isLoading = true;
    notifyListeners();
    
    _posts = await client.post.getAllPosts();
    
    _isLoading = false;
    notifyListeners();
  }
  
  Future<void> addPost(Post post) async {
    final newPost = await client.post.createPost(post);
    if (newPost != null) {
      _posts.insert(0, newPost);
      notifyListeners();
    }
  }
}''',
      'description': 'Reactive state management',
    },
    {
      'title': 'Authentication',
      'code': '''// Authentication flow
class AuthService {
  final Client client;
  
  AuthService(this.client);
  
  Future<bool> signIn(String email, String password) async {
    try {
      final result = await client.auth.authenticate(
        email,
        password,
      );
      
      if (result.success) {
        // Store auth key
        await client.authenticationKeyManager
            ?.put(result.keyId, result.key);
        return true;
      }
      return false;
    } catch (e) {
      print('Auth error: \$e');
      return false;
    }
  }
  
  Future<void> signOut() async {
    await client.authenticationKeyManager?.remove();
  }
}''',
      'description': 'User authentication',
    },
    {
      'title': 'UI Components',
      'code': '''// Flutter UI with Serverpod data
class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onLike;
  
  const PostCard({
    required this.post,
    required this.onLike,
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(post.content),
            const SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: onLike,
                ),
                Text('\${post.likes} likes'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}''',
      'description': 'Flutter widgets with backend data',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        return Container(
          decoration: BoxDecoration(gradient: themeService.getGradient()),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(slidePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'CHAPTER 2',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      const Text(
                        'The Frontend Experience',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Flutter 101: Seamless Integration',
                    style: TextStyle(fontSize: 28, color: Colors.white70),
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.05),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.code,
                                        color: Colors.white70,
                                        size: 24,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        _topics[_selectedIndex]['title']!,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    padding: const EdgeInsets.all(20),
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: const Color(0xff23241f),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: HighlightView(
                                        _topics[_selectedIndex]['code']!,
                                        language: 'dart',
                                        theme: monokaiSublimeTheme,
                                        textStyle: const TextStyle(
                                          fontFamily: 'monospace',
                                          fontSize: 16,
                                          height: 1.5,
                                        ),
                                        padding: EdgeInsets.zero,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.05),
                                  ),
                                  child: Text(
                                    _topics[_selectedIndex]['description']!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        SizedBox(
                          width: 300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Implementation Steps',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: _topics.length,
                                  itemBuilder: (context, index) {
                                    final isSelected = index == _selectedIndex;
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            _selectedIndex = index;
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? Colors.white.withOpacity(0.2)
                                                : Colors.white.withOpacity(
                                                    0.05,
                                                  ),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            border: Border.all(
                                              color: isSelected
                                                  ? Colors.white.withOpacity(
                                                      0.5,
                                                    )
                                                  : Colors.white.withOpacity(
                                                      0.1,
                                                    ),
                                              width: isSelected ? 2 : 1,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 8,
                                                height: 8,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: isSelected
                                                      ? Colors.white
                                                      : Colors.white
                                                            .withOpacity(0.4),
                                                ),
                                              ),
                                              const SizedBox(width: 15),
                                              Expanded(
                                                child: Text(
                                                  _topics[index]['title']!,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: isSelected
                                                        ? Colors.white
                                                        : Colors.white70,
                                                    fontWeight: isSelected
                                                        ? FontWeight.bold
                                                        : FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                              if (isSelected)
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 16,
                                                  color: Colors.white,
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
