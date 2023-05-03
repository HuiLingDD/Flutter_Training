import 'package:flutter/material.dart';
import 'package:flutter_training/assets_images.dart';
import 'package:flutter_training/widgets/ecology_card.dart';

// 特色園區區域
class HorizontalListView extends StatelessWidget {
  // 卡片img
  final cardImg = [
    AssetsImages.image4,
    AssetsImages.image5,
  ];
  HorizontalListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 6.0, left: 10.0, bottom: 6.0),
        child: SizedBox(
          height: 175,
          child: ListView.separated(
              padding: EdgeInsets.only(bottom: 3.0, right: 18.0),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final imageData = cardImg[index];
                return SizedBox(
                    width: 220,
                    height: 180,
                    child: EcologyCard(
                        // 如果index為0則title為介紹1，否則為介紹2
                        title: index == 0 ? '名稱1' : '名稱2',
                        cardImg: imageData));
              },
              // 設定卡片之間的距離
              separatorBuilder: (context, index) {
                return Container(
                  color: Colors.transparent,
                  width: 10.0,
                );
              },
              itemCount: cardImg.length),
        ));
  }
}
