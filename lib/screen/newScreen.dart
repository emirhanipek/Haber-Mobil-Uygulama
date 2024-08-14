import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/settings/settings_cubit.dart';

class newsDetailScreen extends StatefulWidget {
  final String newsID;
  const newsDetailScreen({super.key, required this.newsID});

  @override
  State<newsDetailScreen> createState() => _newsDetailScreenState();
}

class _newsDetailScreenState extends State<newsDetailScreen> {
  Dio dio = Dio();
  late final SettingsCubit settings;

  bool loading = true;
  String title = '';
  String content = '';
  String image = '';
  String date = '';

  loadUser() async {
    final response = await dio
        .get('https://www.nginx.com/wp-json/wp/v2/posts/' + widget.newsID);
    print(response.data);
    loading = false;
    title = response.data["yoast_head_json"]["title"];
    content = response.data["yoast_head_json"]["description"];
    image = response.data['yoast_head_json']['twitter_image'];
    date = response.data['date'].substring(0, 10);
    setState(() {});
  }

  @override
  void initState() {
    settings = context.read<SettingsCubit>();
    loadUser();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("CNN")),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                image != ""
                    ? Image.network(image)
                    : Image.network("https://www.thinkink.com/News.jpg"),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      content,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Tarih:  ' + date,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 185, 0, 0)),
                          onPressed: () {
                            _showDialog(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 30, right: 40),
                            child: Row(children: [
                              Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(Icons.cancel)),
                              Text(
                                "Yalan Haber Bildir",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    wordSpacing: 0.3),
                              ),
                            ]),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("Yalan Haber İhbarı"),
        content:
            new Text("Yalan Haberi Bize Bildirdiğiniz İçin Teşşekkür Ederiz."),
        actions: [
          ElevatedButton(
            child: new Text("KAPAT"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
