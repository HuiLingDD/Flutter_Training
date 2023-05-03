import 'package:flutter/material.dart';

// 自定義LoginPage Container裁剪波浪形狀
class LoginCustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height); // 畫直線
    // 第一段貝賽爾曲線
    path.quadraticBezierTo(
        size.width / 4, size.height - 40, size.width / 2, size.height - 20);
    // 第二段貝賽爾曲線
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0); // 畫直線
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false; // 是否重新裁剪
  }
}

class LoginCustomShapeClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 20); // 畫直線
    // 第一段貝賽爾曲線
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height - 20);
    // 第二段貝賽爾曲線
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height - 35, size.width, size.height - 10);
    path.lineTo(size.width, 0); // 畫直線
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false; // 是否重新裁剪
  }
}
