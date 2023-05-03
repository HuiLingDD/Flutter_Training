import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/model/login_bloc.dart';
import 'package:flutter_training/widgets/login_custom_shape.dart';

// 登入頁
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late LoginBloc _loginBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 取得LoginBloc
    _loginBloc = BlocProvider.getBloc<LoginBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // 用於管理多個輸入框
      body: Form(
        key: _formKey, // 取得當前FormState
        child: Column(
          children: [
            clipShape(), // 裁剪的Container
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 40.0),
              child: Text(
                '歡迎登入',
                style: TextStyle(fontSize: 30.0),
              ),
            ),
            // user輸入欄
            Container(
              margin: EdgeInsets.only(top: 50.0),
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                controller: _userController,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    filled: false,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide:
                            BorderSide(color: Colors.blueGrey.shade800)),
                    hintText: 'example@mail.com',
                    labelText: 'example@mail.com',
                    prefixIcon: Icon(Icons.email)),
                maxLength: 20,
                // 驗證使用者輸入的值
                validator: (String? value) {
                  if (!isWordAndDigit(value!)) return '請輸入文字或數字';
                  return null;
                },
              ),
            ),
            // password輸入欄
            Container(
              margin: EdgeInsets.only(top: 30.0),
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                controller: _passwordController,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    filled: false,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide:
                            BorderSide(color: Colors.blueGrey.shade800)),
                    hintText: '請輸入6-20位數密碼',
                    labelText: '請輸入6-20位數密碼',
                    prefixIcon: Icon(Icons.lock)),
                maxLength: 20,
                obscureText: true, // 隱藏密碼
                // 驗證使用者輸入的值
                validator: (String? value) {
                  if (value!.length < 6) return '密碼長度需大於6個字元';
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            // 登入鈕
            ElevatedButton(
              onPressed: () {
                print('登入');
                // 如果使用者輸入的值通過驗證則跳至HomePage
                if (_formKey.currentState!.validate()) {
                  _loginBloc.currentPage = 1;
                }
              },
              style: ElevatedButton.styleFrom(
                  alignment: Alignment.center,
                  backgroundColor: Colors.lightBlue.shade200,
                  fixedSize: Size(330, 45)),
              child: Text(
                '登入',
                style: TextStyle(fontSize: 30.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 用於裁剪Container
  Widget clipShape() {
    return Stack(children: [
      Opacity(
          opacity: 0.65, // 透明度
          child: ClipPath(
            clipper: LoginCustomShapeClipper(), // 自定義裁剪形狀
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[
                Color.fromARGB(255, 189, 229, 246),
                Color.fromARGB(255, 79, 195, 247)
              ])),
              width: MediaQuery.of(context).size.width,
              height: 140,
            ),
          )),
      Opacity(
          opacity: 0.5, // 透明度
          child: ClipPath(
            clipper: LoginCustomShapeClipper2(), // 自定義裁剪形狀
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[
                Color.fromARGB(255, 189, 229, 246),
                Color.fromARGB(255, 79, 195, 247)
              ])),
              width: MediaQuery.of(context).size.width,
              height: 140,
            ),
          ))
    ]);
  }

  // 用於驗證使用者輸入的字是否正確
  bool isWordAndDigit(String value) {
    // 如果是大小寫英文、數字0-9、底線為True，否則回傳False
    return RegExp(r"^[ZA-ZZa-z0-9_]+$").hasMatch(value);
  }
}
