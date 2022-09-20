import 'package:flutter/material.dart';
import 'package:news_app/pages/post_details_page/post_details_page.dart';

import '../../../models/post_model.dart';

class PostList extends StatelessWidget {
  const PostList({Key? key, required this.posts}) : super(key: key);
  final List posts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        Post post = posts[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PostDetailsPage(post: post)),
            );
          },
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  post.thumbnailUrl.contains('.jpg')
                      ? Image.network(
                          post.thumbnailUrl,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                        )
                      : const SizedBox(),
                  const SizedBox(height: 4),
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
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
