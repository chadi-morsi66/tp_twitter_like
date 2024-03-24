import 'package:flutter/material.dart';
import '../../models/tweets.dart';
import 'tweet_preview.dart';
import 'tweet_details.dart';

class TweetsMaster extends StatefulWidget {
  final List<Tweet> tweets;

  const TweetsMaster({Key? key, required this.tweets}) : super(key: key);

  @override
  _TweetsMasterState createState() => _TweetsMasterState();
}

class _TweetsMasterState extends State<TweetsMaster> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.tweets.length,
      itemBuilder: (context, index) {
        final tweet = widget.tweets[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TweetDetails(tweet: tweet)),
              );
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: [
                  Hero(
                    tag: 'tweet-${tweet.id}',
                    child: TweetPreview(tweet: tweet),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Icon(
                            tweet.liked ? Icons.favorite : Icons.favorite_border,
                            color: tweet.liked ? Colors.red : null,
                          ),
                          onPressed: () {
                            setState(() {
                              tweet.liked = !tweet.liked;
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => TweetDetails(tweet: tweet)),
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
