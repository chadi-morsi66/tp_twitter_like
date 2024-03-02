import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Tweet {
  final String id;
  final String userCreated;
  final DateTime dateCreated;
  final String text;
  final List<String>? tags;
  final String? image;
  final String? imageUrl;

  Tweet({
    required this.id,
    required this.userCreated,
    required this.dateCreated,
    required this.text,
    this.tags,
    this.image,
  }) : imageUrl = image == null ? null : 'https://twitterlike.shrp.dev/assets/$image';

  factory Tweet.fromJson(Map<String, dynamic> json) {
  final List<dynamic> tagsJson = json['tags'] as List<dynamic>? ?? [];
  final List<String> tags = tagsJson.whereType<String>().toList();
  final String? image = json['image'] as String?;

  return Tweet(
    id: json['id'] as String,
    userCreated: json['user_created'] as String,
    dateCreated: DateTime.parse(json['date_created'] as String),
    text: json['text'] as String,
    tags: tags.isNotEmpty ? tags : null,
    image: image,
  );
}
}

class ChipList extends StatelessWidget {
  final List<String> chips;

  const ChipList({Key? key, required this.chips}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4.0,
      runSpacing: 4.0,
      children: chips
          .map((tag) => Chip(
                label: Text(tag),
              ))
          .toList(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Tweet>> futureTweets;

  @override
  void initState() {
    super.initState();
    futureTweets = fetchTweets();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Twitter like app", style: TextStyle(fontSize: 30)),
      ),
      body: FutureBuilder<List<Tweet>>(
        future: futureTweets,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tweets found.'));
          } else {
            final tweets = snapshot.data!;
            return ListView.builder(
              itemCount: tweets.length,
              itemBuilder: (context, index) {
                final tweet = tweets[index];
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/logo/flutter_logo.png'),
                      ),
                      
                      title: Text(tweet.userCreated),
                      subtitle: Text(tweet.dateCreated.toString()),
                    ),
                    if (tweet.text.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(tweet.text),
                      ),
                    if (tweet.tags != null && tweet.tags!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ChipList(
                          chips: tweet.tags!,
                        ),
                      ),
                    if (tweet.imageUrl != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Image.network(tweet.imageUrl!),
                      ),
                    const Divider(),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}