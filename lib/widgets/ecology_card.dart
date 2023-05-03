import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// 特色園區卡片
class EcologyCard extends StatelessWidget {
  final String cardImg;
  final String title;
  final Color _fontColor = Color.fromARGB(255, 40, 40, 40);

  EcologyCard({
    Key? key,
    required this.title,
    required this.cardImg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            // 使用kElevationToShadow第一種預設陰影樣式
            color: Colors.white,
            boxShadow: kElevationToShadow[1]),
        child: Column(
          // 在卡片裡放圖片和title/評分
          children: [Image.asset('$cardImg'), _buildTitleText()],
        ));
  }

  // title、評分
  Widget _buildTitleText() {
    return Container(
      margin: EdgeInsets.all(6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$title', style: TextStyle(fontSize: 14.0, color: _fontColor)),
          // 評分
          RatingBar(
              initialRating: 3, // 初始評分
              itemCount: 3, // 評分總數
              itemSize: 14,
              allowHalfRating: true, // 允許0.5評分
              direction: Axis.horizontal,
              ratingWidget: RatingWidget(
                  full: Icon(Icons.star, color: Colors.orange),
                  half: Icon(Icons.star_half, color: Colors.orange),
                  empty: Icon(
                    Icons.star_outline,
                    color: Colors.orange,
                  )),
              onRatingUpdate: (rating) {
                print(rating);
              })
        ],
      ),
    );
  }
}
