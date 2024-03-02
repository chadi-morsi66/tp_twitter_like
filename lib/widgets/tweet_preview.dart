import 'package:flutter/material.dart';
import '../../models/tweets.dart';

class TweetPreview extends StatelessWidget {
  final Tweet tweet;

  const TweetPreview({Key? key, required this.tweet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
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
            child: Wrap(
              spacing: 4.0,
              runSpacing: 4.0,
              children: tweet.tags!
                  .map((tag) => Chip(
                        label: Text(tag),
                      ))
                  .toList(),
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
  }
}