import 'package:flutter/material.dart';

import '../model/news_model.dart';

class Details extends StatelessWidget {
  static const String routeName = 'Details';

  const Details({super.key});
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Article;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffe8e8e8),
        title: Text(args.title),
      ),
      backgroundColor: const Color(0xffe8e8e8),
      body: Column(
        children: [
          Image.network(
            args.urlToImage!
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Author : ${args.author ?? 'There is no author'}',
                ),
                Text('Source : ${args.source.name}',
                  ),
                Text('Published at : ${args.publishedAt}',
                  ),
                Text(args.description!,
                style: const TextStyle(
                  fontSize: 20,
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
