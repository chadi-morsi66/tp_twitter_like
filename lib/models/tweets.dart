import 'package:flutter/material.dart';


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