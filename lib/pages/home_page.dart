import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/assets_images.dart';
import 'package:flutter_training/model/Ecology.dart';
import 'package:flutter_training/model/load_json.dart';
import 'package:flutter_training/model/login_bloc.dart';
import 'package:flutter_training/pages/info_page.dart';
import 'package:flutter_training/widgets/ecology_card_bottom.dart';
import 'package:flutter_training/widgets/horizontal_list_view.dart';
import 'package:rxdart/rxdart.dart';

// 首頁
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Size screenSize;
  final carouselSliderImg = [
    Image.asset(AssetsImages.image1, fit: BoxFit.cover),
    Image.asset(AssetsImages.image2, fit: BoxFit.cover),
    Image.asset(AssetsImages.image3, fit: BoxFit.cover)
  ];
  final BehaviorSubject<Ecology> homePageDataSubject =
      BehaviorSubject<Ecology>();
  final BehaviorSubject<int> carouselIndexSubject = BehaviorSubject<int>();
  final BehaviorSubject<Ecology> ecologySubject = BehaviorSubject<Ecology>();

  @override
  void dispose() {
    homePageDataSubject.close();
    carouselIndexSubject.close();
    ecologySubject.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    // 讀取json資料
    var jsonData = await LoadJson.loadJson(LoadJson.JSONData);
    try {
      Ecology object = Ecology.fromJson(jsonData);
      // 收到event後觸發widget進行reload
      homePageDataSubject.add(object);
      ecologySubject.add(object);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    LoginBloc loginBloc = BlocProvider.getBloc<LoginBloc>();
    // 取得螢幕大小
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 252, 253, 255),
        title: Text('園區', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0.0, // 取消陰影
        actions: [
          TextButton(
              onPressed: () {
                // 點擊登出時將currentPage設為0(LoginPage)
                loginBloc.currentPage = 0;
              },
              child: Text('登出', style: TextStyle(color: Colors.black)))
        ],
      ),
      body: CustomScrollView(
        slivers: [
          _sliderBar(),
          _buildHorizontalListTitleWidget('特色園區'),
          _importantArea(),
          _buildGridTitleWidget('園區資訊'),
          _allEcology()
        ],
      ),
    );
  }

  // 輪播圖
  Widget _sliderBar() {
    // 轉換Sliver Widget
    return SliverToBoxAdapter(
        child: StreamBuilder<Ecology>(
            stream: homePageDataSubject.stream,
            builder: (context, snap) {
              // 如果沒有資料時
              if (!snap.hasData) {
                return Container();
              }
              return Container(
                  child: Column(
                children: [
                  CarouselSlider(
                      items: carouselSliderImg,
                      options: CarouselOptions(
                          height: screenSize.width * 180 / 375,
                          aspectRatio: 375 / 180,
                          // 圖片佔版面的100%
                          viewportFraction: 1.0,
                          // 自動播放
                          autoPlay: true,
                          onPageChanged: (index, reason) {
                            carouselIndexSubject
                                .add(index); // 通知StreamBuilder資料改變
                          })),
                  // Indicator
                  StreamBuilder(
                      // 設定預設值，避免還沒有數值傳入
                      initialData: 0,
                      stream: carouselIndexSubject.stream,
                      builder: (context, sliderIndexSnap) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(carouselSliderImg.length,
                                (index) {
                              return Container(
                                width: 5.0,
                                height: 5.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    // 當index等於sliderIndexSnap時顯示橘色，否則顯示灰色
                                    color: index == sliderIndexSnap.data
                                        ? Color.fromARGB(255, 232, 63, 63)
                                        : Colors.grey),
                              );
                            }));
                      })
                ],
              ));
            }));
  }

  // 特色園區標題
  Widget _buildHorizontalListTitleWidget(String title) {
    // 轉換Sliver Widget
    return SliverToBoxAdapter(
        child: Container(
      height: 50,
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            color: Colors.lightBlue[200],
            width: 6,
            height: 30,
          ),
          SizedBox(width: 8),
          Text(
            '$title',
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    ));
  }

  // 特色園區
  Widget _importantArea() {
    // 轉換Sliver Widget
    return SliverToBoxAdapter(
        child: StreamBuilder<Ecology>(
            stream: homePageDataSubject.stream,
            builder: (context, snap) {
              // 如果沒有資料時
              if (!snap.hasData) {
                return Container();
              }
              return HorizontalListView();
            }));
  }

  // 園區資訊標題
  Widget _buildGridTitleWidget(String title) {
    // 轉換Sliver Widget
    return SliverToBoxAdapter(
        child: Container(
      height: 50,
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            color: Colors.lightBlue[200],
            width: 6,
            height: 30,
          ),
          SizedBox(width: 8),
          Text(
            '$title',
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    ));
  }

  // 園區資訊
  _allEcology() {
    return StreamBuilder<Ecology>(
        stream: ecologySubject.stream,
        builder: (context, snap) {
          // 如果沒有資料時
          if (!snap.hasData) {
            // 使用SliverToBoxAdapter將Container包入(因有使用CustomScrollView)
            return SliverToBoxAdapter(child: Container());
          }
          Ecology? data = snap.data!;
          return SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 以2列顯示
              childAspectRatio: 1.35,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return GestureDetector(
                    // 點擊進入說明
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => InfoPage(
                              title: data.data![index].title,
                              imgUrl: data.data![index].images,
                              description: data.data![index].description)));
                      // 關閉鍵盤
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                    child: Container(
                        padding: EdgeInsets.only(
                            top: 6.0, left: 10.0, right: 10.0, bottom: 6.0),
                        child: EcologyCardBottom(
                          title: data.data![index].title,
                          imgUrl: data.data![index].images,
                        )));
              },
              childCount: data.data!.length,
            ),
          );
        });
  }
}
