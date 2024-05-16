import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:isa_project/controller/news_controller.dart';
import 'package:isa_project/model/news_model.dart';
import 'package:isa_project/view/details_screen.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NewsController controller = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Application"),
        backgroundColor: const Color(0xffe8e8e8),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xffe8e8e8),
      body: FutureBuilder(
        future: controller.getData(),
        builder: (context, AsyncSnapshot<Articles?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError || snapshot.data == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Error fetching data try check your connection',
                  style: TextStyle(
                    fontSize: 18,
                  ),),
                  ElevatedButton(
                      onPressed: (){
                        setState(() {
                          controller.getData();
                        });
                      },
                      child: const Text('Try again',
                        style: TextStyle(
                          fontSize: 18,
                        ),),
                  ),
                ],
              ),
            );
          } else {
            Articles data = snapshot.data!;
            return ListView.builder(
              itemCount: data.articles.length,
              itemBuilder: (context, int index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed(Details.routeName,
                        arguments: data.articles[index]);
                      },
                      child: Image.network(
                          data.articles[index].urlToImage!),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Author : ${data.articles[index].author ?? 'There is no author'}'),
                          Text('Source : ${data.articles[index].source.name}'),
                          Text(data.articles[index].title),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
