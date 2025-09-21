import 'package:flutter/material.dart';
import 'package:presentation_app/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import '../services/theme_service.dart';

class SlideBackend101 extends StatefulWidget {
  const SlideBackend101({super.key});

  @override
  State<SlideBackend101> createState() => _SlideBackend101State();
}

class _SlideBackend101State extends State<SlideBackend101> {
  int _selectedIndex = 0;

  final List<Map<String, String>> _topics = [
    {
      'title': 'Serverpod Introduction',
      'code': '''//The missing server for Flutter

// Founded in 2021, Serverpod is an open-source, scalable app server, written in Dart for the Flutter community.

// Supports modern and useful features like containerization, future jobs, OAuth, ORM, web sockets''',
      'description': '',
    },
    {
      'title': 'Authentication',
      'code': '''// Low-code authentication, also supports OAuth out-of-the-box
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;

final pod = Serverpod(
  args,
  Protocol(),
  Endpoints(),
  authenticationHandler: auth.authenticationHandler,
);

auth.AuthConfig.set(
  auth.AuthConfig(
    sendValidationEmail: (session, email, validationCode) async {
      sendEmail(email, 'Validation code: \$validationCode');
      return true;
    },
    sendPasswordResetEmail: (session, userInfo, resetCode) async {
      sendEmail(userInfo.email, 'Password reset code: \$resetCode');
      return true;
    },
  ),
);

// Checking authentication for an existing client session
Future<User> getMe(Session session) async {
  if (await session.isUserSignedIn) {
    final authenticationInfo = await session.authenticated;
    if (authenticationInfo != null) {
      final user = await User.db.findById(session, authenticationInfo.userId);
      if (user != null) {
        return user;
      }
    }
    throw AccessDeniedException(message: 'User not found');
  }
  return Future.error(NotAuthorizedException(
        ResultAuthenticationFailed.unauthenticated('User is not signed in')));
} 
''',
      'description': 'Built-in authentication system',
    },
    {
      'title': 'Data Model Generation',
      'code': '''// category.yaml
class: Category
table: category
fields:
  name: String
  iconUrl: String
  approved: bool?, scope=serverOnly''',
      'description': 'Define your data models in YAML',
    },
    {
      'title': 'API Endpoints',
      'code': '''// category_endpoint.dart
class CategoryEndpoint extends Endpoint {
  Future<List<Category>> getCategories(Session session) async {
    if (await session.isUserSignedIn) {
      return Category.db.find(session, where: (table) => table.approved.equals(true));
    }
    return Future.error(NotAuthorizedException(
        ResultAuthenticationFailed.unauthenticated('User is not signed in')));
  }

  Future<Category?> getCategory(Session session, int id) async {
    if (await session.isUserSignedIn) {
      return Category.db.findById(session, id);
    }
    return Future.error(NotAuthorizedException(
        ResultAuthenticationFailed.unauthenticated('User is not signed in')));
  }
}''',
      'description':
          'Expose (or restrict) operations using built-in Endpoint class',
    },
    {
      'title': 'Database Operations',
      'code': '''// Database queries with type safety
Category.db.count(session); // Returns count of rows, supports WHERE clause
Category.db.delete(session, [category1, category2, category3]); // Returns the deleted rows, atomic operation
Category.db.deleteRow(session, category); // Returns the row that has been deleted
Category.db.deleteWhere(session, where: (table) => table.approved.equals(false)); // Deletes and returns all the rows that satisfy the WHERE clause
Category.db.find(session, where: (table) => table.approved.equals(true) & table.name.notEquals('')); // Returns all the rows that satisfy the WHERE clause
Category.db.findById(session, id); // Returns the full object from the database given its identifier
Category.db.findFirstRow(session, where: (table) => table.approved.equals(true), orderBy: (table) => table.name, orderDescending: true); // Shorthand for LIMIT 1;
Category.db.insert(session, [newCategory1, newCategory2]); // Returns the objects that were inserted, including the generated id value, atomic operation
Category.db.insertRow(session, categoryToInsert); // Returns the object that was inserted, including the generated id
Category.db.update(session, [updatedCategory1, updatedCategory2]); // Returns the updated objects, supports partial update
Category.db.updateRow(session, updatedCategory); // Returns the updated object, supports partial update

// Transactions
await session.db.transaction((txn) async {
  await Category.db.insertRow(txn, newCategory);
  await User.db.updateRow(txn, user.copyWith(categoriesAuthored: user.categoriesAuthored + 1));
});''',
      'description': 'Type-safe database operations',
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
                          'CHAPTER 1',
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
                        'The Backend Foundation',
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
                    'Serverpod 101: Everything is Dart',
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
                                        language: _selectedIndex == 0
                                            ? 'yaml'
                                            : 'dart',
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
                                'Core Features',
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
