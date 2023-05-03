import 'package:flutter/material.dart';

// description
class InfoPage extends StatelessWidget {
  final String? title;
  final List<String>? imgUrl;
  final String? description;
  const InfoPage({Key? key, this.title, this.description, this.imgUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 252, 253, 255),
          title: Text('$title', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          elevation: 0.0, // 取消陰影
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        // 園區圖片和說明
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(children: [
            AspectRatio(
                aspectRatio: 16.0 / 9.0,
                child: Image.network('${imgUrl![0]}', fit: BoxFit.fill)),
            SizedBox(height: 10),
            Text('$description')
          ]),
        ));
    ;
  }
}
