import 'package:flutter/material.dart';

import '../../models/post_model.dart';

class PostDetailsPage extends StatelessWidget {
  const PostDetailsPage({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post details'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text(
              post.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 32),
            post.description.isEmpty
                ? const Text('Nothing yet...')
                : Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        post.description,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
            const SizedBox(height: 32),
            Row(
              children: [
                Text(
                  '${post.starsCounter}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.star_purple500_sharp,
                  color: Colors.green,
                  size: 24,
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
