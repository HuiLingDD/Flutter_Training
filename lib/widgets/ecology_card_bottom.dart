import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// 底部卡片
class EcologyCardBottom extends StatelessWidget {
  final String? title;
  final List<String>? imgUrl;
  final Color _fontColor = Color.fromARGB(255, 40, 40, 40);

  EcologyCardBottom({Key? key, required this.title, required this.imgUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            // 使用kElevationToShadow第一種預設陰影樣式
            color: Colors.white,
            boxShadow: kElevationToShadow[1]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // 在卡片裡放圖片和title/評分
          children: [
            AspectRatio(
              aspectRatio: 16.0 / 9.0,
              child: Image.network('${imgUrl![0]}', fit: BoxFit.fill),
            ),
            _buildTitleText()
          ],
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
              initialRating: 2, // 初始評分
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
