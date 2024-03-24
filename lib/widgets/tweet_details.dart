import 'package:flutter/material.dart';
import '../../models/tweets.dart';

class TweetDetails extends StatefulWidget {
  final Tweet tweet;

  const TweetDetails({Key? key, required this.tweet}) : super(key: key);

  @override
  _TweetDetailsState createState() => _TweetDetailsState();
}

class _TweetDetailsState extends State<TweetDetails> {
  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tweet Details'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(widget.tweet.userCreated),
            subtitle: Text(widget.tweet.dateCreated.toString()),
          ),
          if (widget.tweet.text.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(widget.tweet.text),
            ),
          if (widget.tweet.tags != null && widget.tweet.tags!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 4.0,
                runSpacing: 4.0,
                children: widget.tweet.tags!
                    .map((tag) => Chip(
                          label: Text(tag),
                        ))
                    .toList(),
              ),
            ),
          if (widget.tweet.imageUrl != null)
            Stack(
              children: [
                GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      _liked = !_liked;
                    });
                  },
                  child: Image.network(widget.tweet.imageUrl!),
                ),
                if (_liked)
                  Positioned.fill(
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red.withOpacity(0.5), 
                      size: 30, 
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}