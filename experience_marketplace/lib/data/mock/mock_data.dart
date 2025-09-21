import '../models/user.dart';

class MockData {
  static final List<User> users = [
    User(
      id: 'user1',
      name: 'John Doe',
      email: 'john@example.com',
      avatar: 'https://i.pravatar.cc/150?img=1',
      bio: 'Adventure enthusiast and local guide with 5 years of experience',
      isHost: true,
      joinDate: DateTime(2020, 1, 15),
      rating: 4.8,
      totalReviews: 124,
    ),
    User(
      id: 'user2',
      name: 'Sarah Wilson',
      email: 'sarah@example.com',
      avatar: 'https://i.pravatar.cc/150?img=2',
      bio: 'Food lover and cultural explorer',
      isHost: true,
      joinDate: DateTime(2019, 6, 20),
      rating: 4.9,
      totalReviews: 89,
    ),
    User(
      id: 'user3',
      name: 'Mike Chen',
      email: 'mike@example.com',
      avatar: 'https://i.pravatar.cc/150?img=3',
      bio: 'Professional photographer and nature guide',
      isHost: true,
      joinDate: DateTime(2021, 3, 10),
      rating: 4.7,
      totalReviews: 56,
    ),
    User(
      id: 'user4',
      name: 'Emma Thompson',
      email: 'emma@example.com',
      avatar: 'https://i.pravatar.cc/150?img=4',
      isHost: false,
      joinDate: DateTime(2022, 1, 5),
      favoriteExperienceIds: const ['exp1', 'exp3', 'exp5'],
    ),
    User(
      id: 'user5',
      name: 'Current User',
      email: 'user@example.com',
      avatar: 'https://i.pravatar.cc/150?img=5',
      bio: 'Travel enthusiast exploring the world',
      isHost: false,
      joinDate: DateTime(2023, 1, 1),
      favoriteExperienceIds: const ['exp2', 'exp4'],
    ),
  ];

  static User? currentUser = users.firstWhere((u) => u.id == 'user5');
}
