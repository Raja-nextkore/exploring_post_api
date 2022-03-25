import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/post_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    fetchPost();
  }
  final String url = 'https://jsonplaceholder.typicode.com/posts';

 final List<Post> _post = [];
 bool isLoading = false;

  Future<List<Post>> fetchPost() async {
    setState(() {
      isLoading =true;
    });
    final http.Response response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      var parsedJson = jsonDecode(response.body.toString());
      
      for(Map<String,dynamic> json in parsedJson){
        setState(() {
          _post.add(Post.fromJson(json));
          isLoading =false;
        });
      }

      return _post;
    } else {
      throw Exception('Unable to load post...');
    }
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exploring Post Api in Flutter'),
      ),
      body: ListView.separated(
        separatorBuilder: (_,i)=>const Divider(
          height: 1.0,
          color: Colors.black,
        ),
        itemCount: _post.length,
        itemBuilder: (_, index) {
         var postIndex = _post[index];
          return isLoading ? const Center(child:CircularProgressIndicator(
            color: Colors.white,
          )): Card(
            elevation: 10.0,
            child: ListTile(
            
              title: Text(postIndex.title,style:const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),),
              subtitle: Text(postIndex.body,style:const TextStyle(
                color: Colors.white70,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),),
              leading: CircleAvatar(child: Text(postIndex.id.toString())),
            ),
          );
        },
      ),
    );
  }
}
