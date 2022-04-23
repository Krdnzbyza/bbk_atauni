import 'package:flutter/material.dart';
import 'package:flutter_learn_service/home/service/post_service.dart';

import '../model/post_model.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<PostModel>? postModel;
  final PostService postService = PostService();
  bool isLoading = false;
  bool openText = false;

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> init() async {
    postModel = await postService.fetchData();
    changeLoading();
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BBK'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          init();
        },
        child: Icon(Icons.add),
      ),
      body: isLoading
          ? ListView.builder(
              itemCount: postModel?.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    leading: FlutterLogo(),
                    title: Text(postModel?[index].title ?? 'data yoktur'),
                    trailing: Icon(Icons.access_alarm),
                    subtitle: InkWell(
                      onTap: () {
                        setState(() {
                          openText = !openText;
                        });
                      },
                      child: Text(
                        postModel?[index].body ?? 'data yoktur',
                        style: openText
                            ? TextStyle()
                            : TextStyle(
                                foreground: Paint()
                                  ..shader = LinearGradient(colors: [Colors.grey, Colors.white])
                                      .createShader(Rect.fromLTWH(0, 0, 500, 0)),
                                overflow: TextOverflow.ellipsis),
                        softWrap: false,
                        maxLines: openText ? 20 : 2,
                      ),
                    ),
                  ),
                );
              },
            )
          : SizedBox(),
    );
  }
}
