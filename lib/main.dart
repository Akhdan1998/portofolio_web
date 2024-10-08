// import 'package:carousel_slider/carousel_slider.dart' as carousel;
// import 'package:carousel_slider/carousel_slider.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:portofolio_web/models/models.dart';
import 'package:portofolio_web/utils.dart';
import 'package:supercharged/supercharged.dart';
import 'dart:js' as js;
import 'Widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pendekar Gendut Resto',
      theme: ThemeData(
        primaryColor: '232631'.toColor(),
        hintColor: '656565'.toColor(),
        scaffoldBackgroundColor: 'FDC886'.toColor(),
        colorScheme: ColorScheme.fromSeed(seedColor: 'FDC886'.toColor()),
        useMaterial3: true,
        textTheme: TextTheme(
          bodySmall: TextStyle(fontSize: 16, color: '232631'.toColor()),
          bodyMedium: TextStyle(fontSize: 16, color: '5A4FCF'.toColor()),
          bodyLarge: TextStyle(
              fontSize: 28,
              color: '232631'.toColor(),
              fontWeight: FontWeight.bold),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _selectedValue;
  String? _selectValue;
  final List<String> _dropdownItems = [
    'Category 1',
    'Category 2',
    'Category 3',
  ];
  final List<String> _dropdownItem = [
    'Jakarta, Indonesia',
    'Bandung, Indonesia',
    'Bogor, Indonesia',
  ];
  late ScrollController _scrollController;
  late Timer _timer;
  double _scrollPosition = 0.0;
  bool _scrollingRight = true;

  @override
  void initState() {
    super.initState();
    String? reloadFlag = html.window.sessionStorage['reload_flag'];
    if (reloadFlag != null && reloadFlag == 'true') {
      showToast(
        context,
        'Page refreshed successfully!',
        Icons.check,
        Colors.green,
      );
      html.window.sessionStorage.remove('reload_flag');
    }

    _scrollController = ScrollController();

    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double scrollAmount = MediaQuery.of(context).size.width / 2;

      setState(() {
        if (_scrollingRight) {
          _scrollPosition += scrollAmount;
          if (_scrollPosition >= maxScroll) {
            _scrollPosition = maxScroll;
            _scrollingRight = false;
          }
        } else {
          _scrollPosition -= scrollAmount;
          if (_scrollPosition <= 0) {
            _scrollPosition = 0;
            _scrollingRight = true;
          }
        }
      });

      _scrollController.animateTo(
        _scrollPosition,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: 'FAFAFA'.toColor(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LayoutBuilder(builder: (context, constraints) {
                        double containerWidth = constraints.maxWidth;
                        if (containerWidth < 200) {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: '326BFF'.toColor(),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Icon(Icons.home,
                                  color: Colors.white, size: 25),
                            ),
                          );
                        } else {
                          return Flexible(
                            flex: 2,
                            child: Row(
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: Text('Home',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ),
                                SizedBox(width: 10),
                                DropdownButton<String>(
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: '5A4FCF'.toColor(),
                                  ),
                                  underline: Container(),
                                  hint: Text('Category',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  value: _selectedValue,
                                  items: _dropdownItems.map((String item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedValue = newValue;
                                    });
                                  },
                                ),
                                SizedBox(width: 10),
                                TextButton(
                                  onPressed: () {},
                                  child: Text('Services',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ),
                                SizedBox(width: 10),
                                TextButton(
                                  onPressed: () {},
                                  child: Text('About us',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ),
                              ],
                            ),
                          );
                        }
                      }),
                      Spacer(),
                      Flexible(
                        flex: 1,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              html.window.sessionStorage['reload_flag'] =
                                  'true';
                              js.context.callMethod('reload', []);
                            },
                            child: Image.asset(
                              'assets/logo.png',
                              scale: 3,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Flexible(
                        flex: 2,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                height: 35,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 10),
                                    suffixIcon: Icon(Icons.search),
                                    hintText: 'Search...',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              style: unyu,
                              onPressed: () {},
                              child: Text(
                                'Log In',
                                style: TextStyle(
                                    color: '5A4FCF'.toColor(),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        Image.asset(
                          'assets/gambar1.png',
                          scale: 3,
                        ),
                        SizedBox(width: 20),
                        Image.asset(
                          'assets/gambar2.png',
                          scale: 3,
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text('Special Benefit For You',
                    style: Theme.of(context).textTheme.bodyMedium),
                SizedBox(height: 6),
                Text('Why Should Choose Us?',
                    style: Theme.of(context).textTheme.bodyLarge),
                SizedBox(height: 41),
                Row(
                  children: [
                    SizedBox(width: 20),
                    Container(
                      width: MediaQuery.of(context).size.width - 40,
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        alignment: WrapAlignment.spaceBetween,
                        children: fitur.map((e) {
                          return ButtonFitur(
                            id: e.id,
                            icon: e.icon,
                            title: e.title,
                            subtitle: e.subtitle,
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
                SizedBox(height: 120),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 475,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double cardWidth = constraints.maxWidth / 5 - 40;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeaderWidget(),
                                ViewAllButton(),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RestaurantCard(
                                  imagePath: 'assets/top1.png',
                                  restaurantName: 'Bind Balorant',
                                  bintang: '5.0',
                                  view: '(7.6K+)',
                                  kota: 'Jakarta, Indonesia',
                                  cardWidth: cardWidth,
                                ),
                                RestaurantCard(
                                  imagePath: 'assets/top2.png',
                                  restaurantName: 'Henshin',
                                  bintang: '6.0',
                                  view: '(9.6K+)',
                                  kota: 'Bandung, Indonesia',
                                  cardWidth: cardWidth,
                                ),
                                RestaurantCard(
                                  imagePath: 'assets/top3.png',
                                  restaurantName: 'OKU Kempinski',
                                  bintang: '9.0',
                                  view: '(7.9K+)',
                                  kota: 'Bogor, Indonesia',
                                  cardWidth: cardWidth,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 120),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Restaurant Based By City',
                              style: Theme.of(context).textTheme.bodyMedium),
                          SizedBox(height: 6),
                          Text('Restaurant Near You',
                              style: Theme.of(context).textTheme.bodyLarge),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 24, right: 24),
                        decoration: BoxDecoration(
                          color: 'F2F2F2'.toColor(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_sharp,
                              color: '656565'.toColor(),
                            ),
                            SizedBox(width: 6),
                            DropdownButton<String>(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: '656565'.toColor(),
                              ),
                              underline: Container(),
                              hint: Text(
                                'Location',
                                style: TextStyle(
                                  color: '656565'.toColor(),
                                ),
                              ),
                              value: _selectValue,
                              items: _dropdownItem.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      color: '656565'.toColor(),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectValue = newValue;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 34),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: restaurants.map((e) {
                      return Row(
                        children: [
                          SizedBox(width: 20),
                          HoverableRestaurantCard(e),
                          SizedBox(width: 20),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 56),
                ViewAllButton(),
                SizedBox(height: 120),
              ],
            ),
          );
        },
      ),
    );
  }
}
