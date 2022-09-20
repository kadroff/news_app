import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/post_model.dart';
import 'components/post_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  late List<Post> initialPostList;
  late Future _initPostData;

  @override
  void initState() {
    super.initState();
    _initPostData = fetchPosts();
  }

  Future fetchPosts() async {
    final response = await http.Client()
        .get(Uri.parse('https://www.reddit.com/r/flutterdev/new.json'));

    initialPostList = parsePosts(response.body);
  }

  List<Post> parsePosts(responseBody) {
    final parsed = jsonDecode(responseBody)['data']['children'];
    List<Post> listFromJson =
        List<Post>.from(parsed.map((data) => Post.fromJson(data)));

    return listFromJson;
  }

  Future<void> refreshPosts() async {
    final response = await http.Client()
        .get(Uri.parse('https://www.reddit.com/r/flutterdev/new.json'));

    List<Post> newPostsList = parsePosts(response.body);
    final isEqualModels = checkIfContains(initialPostList, newPostsList);

    if (isEqualModels) {
      for (int i = 0; i < newPostsList.length; i++) {
        final newPost = newPostsList[i];
        final index =
            initialPostList.indexWhere((element) => element.id == newPost.id);
        if (index != -1) {
          setState(() {
            initialPostList[index] = newPost;
          });
        } else {
          setState(() {
            initialPostList.insert(0, newPost);
          });
        }
      }
    } else {
      for (int i = 0; i < newPostsList.length; i++) {
        final newPost = newPostsList[i];
        final index =
            initialPostList.indexWhere((element) => element.id == newPost.id);
        if (index == -1) {
          setState(() {
            initialPostList.insert(0, newPost);
          });
        } else {
          setState(() {
            initialPostList[index] = newPost;
          });
        }
      }
    }
  }

  checkIfContains(initialPostList, newPostsList) {
    final Set initialPostSet = initialPostList.toSet();
    final Set newPostSet = newPostsList.toSet();
    return initialPostSet.containsAll(newPostSet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter news'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: _initPostData,
            builder: (
              BuildContext context,
              AsyncSnapshot snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else {
                  return Expanded(
                    child: RefreshIndicator(
                      key: _refreshIndicatorKey,
                      onRefresh: refreshPosts,
                      child: PostList(posts: initialPostList),
                    ),
                  );
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
          ),
        ],
      ),
    );
  }
}
