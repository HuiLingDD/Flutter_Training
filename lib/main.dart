import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/model/login_bloc.dart';
import 'package:flutter_training/pages/home_page.dart';
import 'package:flutter_training/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        // 傳入LoginBloc使Widget Tree可使用
        blocs: [Bloc((i) => LoginBloc())],
        dependencies: [],
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: LoginManagment(),
          debugShowCheckedModeBanner: false,
        ));
  }
}

// 選擇頁面
class LoginManagment extends StatelessWidget {
  LoginManagment({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // 取得LoginBloc
    LoginBloc loginBloc = BlocProvider.getBloc<LoginBloc>();
    return StreamBuilder(
        // 當currentPageStream資料送進來時觸發builder
        stream: loginBloc.currentPageStream,
        builder: (context, snap) {
          return IndexedStack(
            index: loginBloc.currentPage,
            // LoginPage=0,HomePage=1
            children: [
              LoginPage(),
              HomePage(),
            ],
          );
        });
  }
}
