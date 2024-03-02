import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'widgets/tweets_master.dart';
import 'models/tweets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twitter Like',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(252, 230, 142, 0.8),
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Future<List<Tweet>> _tweetsFuture;

  @override
  void initState() {
    super.initState();
    _tweetsFuture = fetchTweets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Twitter Like'),
        actions: [
          Image.asset(
            'logo/flutter_logo.jpg',
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          ),
        ],
      ),
      body: FutureBuilder<List<Tweet>>(
        future: _tweetsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tweets found.'));
          } else {
            final tweets = snapshot.data!;
            return TweetsMaster(tweets: tweets);
          }
        },
      ),
    );
  }
}

Future<List<Tweet>> fetchTweets() async {
  final response = await http.get(Uri.parse('https://twitterlike.shrp.dev/items/tweets'));

  if (response.statusCode == 200) {
    final List tweetsJson = json.decode(response.body)['data'];

    return tweetsJson.map((tweetJson) => Tweet.fromJson(tweetJson)).toList();
  } else {
    throw Exception('Failed to load tweets');
  }
}