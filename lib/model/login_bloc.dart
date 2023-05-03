import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';

// 儲存、通知頁面已改變
class LoginBloc extends BlocBase {
  int _currentPage = 0;
  // 通知頁面currentPage已被改變
  StreamController<int> _currentPageStreamController = StreamController<int>();

  int get currentPage => _currentPage;
  Stream<int> get currentPageStream => _currentPageStreamController.stream;

  set currentPage(int value) {
    // 經由set寫入資料至_currentPage
    _currentPage = value;
    // 通知所有已訂閱StreamController的介面
    _currentPageStreamController.sink.add(value);
  }

  // Release Stream
  @override
  void dispose() {
    _currentPageStreamController.close();
    super.dispose();
  }
}
