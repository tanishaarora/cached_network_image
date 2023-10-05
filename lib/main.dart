import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Home()
    );
  }
}

class Home extends  StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Image Cache Manager"),
            backgroundColor: Colors.redAccent
        ),
        body: Container(
          margin: EdgeInsets.all(30),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: "https://www.fluttercampus.com/img/logo_small.webp",
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                cacheManager: CacheManager(
                    Config(
                      "fluttercampus",
                      stalePeriod: const Duration(days: 7),
                      //one week cache period
                    )
                ),
              ),

              Divider(),

              ElevatedButton(
                  onPressed: () async {
                    await DefaultCacheManager().emptyCache();
                  },
                  child: Text("Clear All Image Cache")
              ),

              ElevatedButton(
                  onPressed: () async {
                    await DefaultCacheManager().removeFile("fluttercampus");
                    //Cache with "fluttercampus" key will be removed.
                  },
                  child: Text("Clear Only This Image")
              )
            ],
          ),
        )
    );
  }
}