import 'package:flutter/material.dart';

void main() {
  runApp(const FriendApp());
}

// Sub-step 2.1: অ্যাপের মূল কাঠামো ও বেসিক স্ট্রাকচার
class FriendApp extends StatelessWidget {
  const FriendApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Friend App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const FriendHomeScreen(),
    );
  }
}

class FriendHomeScreen extends StatelessWidget {
  const FriendHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // এখানে Scaffold দিয়ে অ্যাপের মূল কাঠামো (AppBar এবং Body) তৈরি করা হয়েছে
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Personal Friends'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Step 2.1 Complete: App Structure Ready!',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
      appBar: AppBar(
        title: const Text('My Friends'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          final friend = friends[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            elevation: 3,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Text(
                  friend['name']![0],
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(friend['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Status: ${friend['status']}'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigation to Detail Screen (Step 4)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FriendDetailScreen(
                      name: friend['name']!,
                      phone: friend['phone']!,
                      status: friend['status']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// 2. Friend Detail Screen (Navigation & Functionality)
class FriendDetailScreen extends StatelessWidget {
  final String name;
  final String phone;
  final String status;

  const FriendDetailScreen({
    super.key,
    required this.name,
    required this.phone,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blueAccent,
                child: Text(
                  name[0],
                  style: const TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text('Name: $name', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Phone: $phone', style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 10),
            Text('Current Status: $status', style: const TextStyle(fontSize: 16, color: Colors.green)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, foregroundColor: Colors.white),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Calling $name at $phone...')),
                  );
                },
                icon: const Icon(Icons.call),
                label: const Text('Call Friend'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
