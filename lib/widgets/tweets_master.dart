import 'package:flutter/material.dart';
import '../../models/tweets.dart';
import 'tweet_preview.dart';
import 'dart:convert';
import 'tweet_details.dart';

class TweetsMaster extends StatelessWidget {
  final List<Tweet> tweets;

  const TweetsMaster({Key? key, required this.tweets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tweets.length,
      itemBuilder: (context, index) {
        final tweet = tweets[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: GestureDetector(
            onTap: () {
              // Handle tweet tap, e.g., navigate to tweet details screen
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: [
                  Hero(
                    tag: 'tweet-${tweet.id}', // Use a unique tag for each tweet
                    child: TweetPreview(tweet: tweet),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Icon(Icons.favorite),
                          onPressed: () {
                            // Handle like action
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  TweetDetails(tweet: tweet,)),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.comment),
                          onPressed: () {
                            // Handle comment action
                          },
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