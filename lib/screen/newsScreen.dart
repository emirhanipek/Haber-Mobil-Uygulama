// ignore_for_file: unnecessary_null_comparison
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsapp/screen/home_screen.dart';
import 'package:newsapp/screen/indexScreen.dart';
import '../bloc/settings/settings_cubit.dart';

class newsScreen extends StatefulWidget {
  const newsScreen({super.key});

  @override
  State<newsScreen> createState() => _newsScreenState();
}

class _newsScreenState extends State<newsScreen> {
  List<dynamic> news = [];
  late final SettingsCubit settings;
  loadNews() async {
    Dio dio = Dio();
    var response = await dio.get('https://www.nginx.com/wp-json/wp/v2/posts');
    if (response.statusCode == 200) {
      print(response.data);
      news = response.data;
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Hata oluştu'),
      ));
    }
  }

  Widget getNews() {
    if (news != null) {
      var haberler = news
          .map((e) => Container(
                padding: EdgeInsets.only(top: 10),
                child: InkWell(
                  onTap: () {
                    context.push('/haberler/' + e['id'].toString());
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: e["yoast_head_json"]["twitter_image"] != null
                            ? Image.network(
                                e["yoast_head_json"]["twitter_image"])
                            : Image.network(
                                "https://www.thinkink.com/News.jpg"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        e["yoast_head_json"]["title"].length >
                                                10
                                            ? e["yoast_head_json"]["title"]
                                                .substring(0, 33)
                                            : e["yoast_head_json"]["title"],
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Wrap(
                                    children: [
                                      Text(
                                        e["yoast_head_json"]["description"]
                                                    .length >
                                                10
                                            ? e["yoast_head_json"]
                                                        ["description"]
                                                    .substring(0, 25) +
                                                '...'
                                            : e["yoast_head_json"]
                                                ["description"],
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        e["date"].substring(0, 10),
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ))
          .toList();
      return Column(
        children: haberler,
      );
    } else {
      return Text("Loading");
    }
  }

  @override
  void initState() {
    super.initState();
    settings = context.read<SettingsCubit>();
    loadNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 185, 0, 0),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => indexScreen()));
                },
                child: Container(
                    padding: EdgeInsets.only(top: 5, right: 10),
                    child: Icon(Icons.settings)),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => home_screen()));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      content: Container(
                        child: Text(
                          "Checked Out",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        padding: EdgeInsets.all(15),
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 185, 12, 0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      )));
                },
                child: Container(
                    padding: EdgeInsets.only(top: 5, right: 10),
                    child: Icon(Icons.logout)),
              )
            ],
            centerTitle: true,
            title: Text("AnaSayfa")),
        body: SingleChildScrollView(child: getNews()));
  }
}
