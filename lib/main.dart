import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'dart:html' as html;
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
  double value = 3.5;
  bool isActive1 = true;
  bool isActive2 = false;
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();

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

  void _scrollToServices() {
    RenderBox? renderBox =
        _servicesKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox != null) {
      Offset offset = renderBox.localToGlobal(Offset.zero);

      double appBarHeight = AppBar().preferredSize.height;
      double targetScrollPosition = offset.dy - appBarHeight;

      _scrollController.animateTo(
        targetScrollPosition,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollToAbout() {
    RenderBox? renderBox =
        _aboutKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox != null) {
      Offset offset = renderBox.localToGlobal(Offset.zero);

      double appBarHeight = AppBar().preferredSize.height;
      double targetScrollPosition = offset.dy - appBarHeight;

      _scrollController.animateTo(
        targetScrollPosition,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: 'FAFAFA'.toColor(),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                      child: Icon(Icons.home, color: Colors.white, size: 25),
                    ),
                  );
                } else {
                  return Flexible(
                    flex: 2,
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            _scrollController.animateTo(
                              0.0,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Text('Home',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                        SizedBox(width: 10),
                        DropdownButton<String>(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: '5A4FCF'.toColor(),
                          ),
                          underline: Container(),
                          hint: Text('Category',
                              style: Theme.of(context).textTheme.bodyMedium),
                          value: _selectedValue,
                          items: _dropdownItems.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: Theme.of(context).textTheme.bodyMedium,
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
                          onPressed: () {
                            _scrollToServices();
                          },
                          child: Text('Services',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                        SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            _scrollToAbout();
                          },
                          child: Text('About us',
                              style: Theme.of(context).textTheme.bodyMedium),
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
                      html.window.sessionStorage['reload_flag'] = 'true';
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
                          style: TextStyle(fontSize: 15),
                          cursorHeight: 20,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            suffixIcon: Icon(Icons.search),
                            hintText: 'Search...',
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ViewAllButton(
                      text: 'Log In',
                      backgroundColor: '5A4FCF'.toColor().withOpacity(0.2),
                      textColor: '5A4FCF'.toColor(),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double containerWidth = constraints.maxWidth;
          return SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        Stack(
                          children: [
                            Row(
                              children: [
                                Container(
                                  color: 'FAFAFA'.toColor(),
                                  width: 90,
                                  height: 375,
                                ),
                                Image.asset(
                                  'assets/gambar1.png',
                                  scale: 3,
                                ),
                              ],
                            ),
                            Positioned(
                              top: 50,
                              child: Container(
                                padding: EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(24),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RatingStars(
                                          value: value,
                                          onValueChanged: (v) {
                                            setState(() {
                                              value = v;
                                            });
                                          },
                                          starBuilder: (index, color) => Icon(
                                            Icons.star,
                                            color: color,
                                          ),
                                          starCount: 5,
                                          starSize: 20,
                                          valueLabelRadius: 10,
                                          maxValue: 5,
                                          starSpacing: 2,
                                          maxValueVisibility: true,
                                          valueLabelVisibility: false,
                                          animationDuration:
                                              Duration(milliseconds: 1000),
                                          valueLabelPadding: EdgeInsets.zero,
                                          valueLabelMargin: EdgeInsets.zero,
                                          starOffColor: Color(0xffe7e8ea),
                                          starColor: 'FFB800'.toColor(),
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          value.toStringAsFixed(1),
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: 'FFB800'.toColor(),
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          '(5.2K+)',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: '656565'
                                                .toColor(), // Warna teks sesuai kebutuhan
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Padang Restaurant',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: '232631'.toColor(),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'IDR 49.999 - IDR 560.000',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: '656565'.toColor(),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_sharp,
                                          color: '656565'.toColor(),
                                          size: 18,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          'Padang, Indonesia',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: '656565'.toColor(),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 34),
                                    ViewAllButton(
                                      text: 'Make Reservation',
                                      icon: Icons.arrow_forward_ios,
                                      backgroundColor: 'FDC886'.toColor(),
                                      textColor: '232631'.toColor(),
                                      onPressed: () {},
                                    ),
                                    SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/info.png',
                                          scale: 2,
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          'No extra cost',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: '656565'.toColor(),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Stack(
                          children: [
                            Row(
                              children: [
                                Container(
                                  color: 'FAFAFA'.toColor(),
                                  width: 90,
                                  height: 375,
                                ),
                                Image.asset(
                                  'assets/gambar2.png',
                                  scale: 3,
                                ),
                              ],
                            ),
                            Positioned(
                              top: 50,
                              child: Container(
                                padding: EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(24),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RatingStars(
                                          value: value,
                                          onValueChanged: (v) {
                                            setState(() {
                                              value = v;
                                            });
                                          },
                                          starBuilder: (index, color) => Icon(
                                            Icons.star,
                                            color: color,
                                          ),
                                          starCount: 5,
                                          starSize: 20,
                                          valueLabelRadius: 10,
                                          maxValue: 5,
                                          starSpacing: 2,
                                          maxValueVisibility: true,
                                          valueLabelVisibility: false,
                                          animationDuration:
                                              Duration(milliseconds: 1000),
                                          valueLabelPadding: EdgeInsets.zero,
                                          valueLabelMargin: EdgeInsets.zero,
                                          starOffColor: Color(0xffe7e8ea),
                                          starColor: 'FFB800'.toColor(),
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          value.toStringAsFixed(1),
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: 'FFB800'.toColor(),
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          '(5.2K+)',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: '656565'
                                                .toColor(), // Warna teks sesuai kebutuhan
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Amuz Gourmet ',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: '232631'.toColor(),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'IDR 80.999 - IDR 560.000',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: '656565'.toColor(),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_sharp,
                                          color: '656565'.toColor(),
                                          size: 18,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          'Gorontalo, Indonesia',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: '656565'.toColor(),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 34),
                                    ViewAllButton(
                                      text: 'Make Reservation',
                                      icon: Icons.arrow_forward_ios,
                                      backgroundColor: 'FDC886'.toColor(),
                                      textColor: '232631'.toColor(),
                                      onPressed: () {},
                                    ),
                                    SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/info.png',
                                          scale: 2,
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          'No extra cost',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: '656565'.toColor(),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  key: _servicesKey,
                  children: [
                    Text(
                      'Special Benefit For You',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Why Should Choose Us?',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
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
                                ViewAllButton(
                                  text: 'View All Restaurant',
                                  icon: Icons.arrow_forward_ios,
                                  backgroundColor: 'FDC886'.toColor(),
                                  textColor: '232631'.toColor(),
                                  onPressed: () {
                                    // Aksi berbeda
                                  },
                                ),
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
                ViewAllButton(
                  text: 'View All Restaurant',
                  icon: Icons.arrow_forward_ios,
                  backgroundColor: 'FDC886'.toColor(),
                  textColor: '232631'.toColor(),
                  onPressed: () {},
                ),
                SizedBox(height: 120),
                Row(
                  key: _aboutKey,
                  children: [
                    Stack(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 70,
                              height: MediaQuery.of(context).size.height - 225,
                            ),
                            Image.asset(
                              'assets/nyoman.png',
                              scale: 2,
                            ),
                            Container(
                              width: 70,
                              height: MediaQuery.of(context).size.height - 225,
                            ),
                          ],
                        ),
                        Positioned(
                          left: 30,
                          bottom: 30,
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: EdgeInsets.all(24),
                            child: Row(
                              children: [
                                Container(
                                  width: 96,
                                  height: 132,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/gambar2.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Container(
                                  height: 120,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Chef at restaurant:',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: '232631'.toColor(),
                                            ),
                                          ),
                                          Text(
                                            'Pearl Dolphin',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: '232631'.toColor(),
                                            ),
                                          ),
                                        ],
                                      ),
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            color: Colors.transparent,
                                            child: Row(
                                              children: [
                                                Text(
                                                  'View Details',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: 'FDC886'.toColor(),
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: 'FDC886'.toColor(),
                                                  size: 12,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 30,
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: EdgeInsets.all(24),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(16),
                                  padding: EdgeInsets.all(15),
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: 'FDC886'.toColor().withOpacity(0.2),
                                  ),
                                  child: Image.asset('assets/experience.png',
                                      height: 35.42, width: 41.67),
                                ),
                                Text(
                                  '12 Years',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: '232631'.toColor(),
                                  ),
                                ),
                                Text(
                                  'Experience',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: '232631'.toColor(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 64),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Top 4 Expert Chefs',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          'Expert Chefs in Fuddy',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            color: '232631'.toColor(),
                          ),
                        ),
                        SizedBox(height: 32),
                        Container(
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.white,
                          ),
                          width: MediaQuery.of(context).size.width - 850,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PIZZA',
                                style: TextStyle(
                                    fontSize: 16, color: '656565'.toColor()),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Phoenix Satcheup',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: '656565'.toColor(),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  LayoutBuilder(
                                      builder: (context, constraints) {
                                    if (containerWidth < 200) {
                                      return MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.arrow_forward_ios,
                                            color: 'FDC886'.toColor(),
                                            size: 12,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            color: Colors.transparent,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Profile Details',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: 'FDC886'.toColor(),
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: 'FDC886'.toColor(),
                                                  size: 12,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_sharp,
                                    color: '656565'.toColor(),
                                    size: 15,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Jakarta, Indonesia',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: '656565'.toColor()),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 32),
                        Container(
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.white,
                          ),
                          width: MediaQuery.of(context).size.width - 850,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'VEGAN',
                                style: TextStyle(
                                    fontSize: 16, color: '656565'.toColor()),
                              ),
                              Text(
                                'Chamber Botfrag',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: '656565'.toColor(),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_sharp,
                                    color: '656565'.toColor(),
                                    size: 15,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Bandung, Indonesia',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: '656565'.toColor()),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 32),
                        Container(
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.white,
                          ),
                          width: MediaQuery.of(context).size.width - 850,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ROAST CHICKEN',
                                style: TextStyle(
                                    fontSize: 16, color: '656565'.toColor()),
                              ),
                              Text(
                                'Asep Vandal',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: '656565'.toColor(),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_sharp,
                                    color: '656565'.toColor(),
                                    size: 15,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Sunda, Indonesia',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: '656565'.toColor()),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 32),
                        Container(
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.white,
                          ),
                          width: MediaQuery.of(context).size.width - 850,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'BEEF STEAK',
                                style: TextStyle(
                                    fontSize: 16, color: '656565'.toColor()),
                              ),
                              Text(
                                'I Made Invoker ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: '656565'.toColor(),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_sharp,
                                    color: '656565'.toColor(),
                                    size: 15,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Bali, Indonesia',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: '656565'.toColor()),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 62),
                        ViewAllButton(
                          text: 'View All Chef',
                          icon: Icons.arrow_forward_ios,
                          backgroundColor: 'FDC886'.toColor(),
                          textColor: '232631'.toColor(),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 120),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildRestaurantCard(
      String imagePath, String title, String priceRange, String location) {
    return Stack(
      children: [
        Row(
          children: [
            Container(
              color: 'FAFAFA'.toColor(),
              width: 90,
              height: 375,
            ),
            Image.asset(
              imagePath,
              scale: 3,
            ),
          ],
        ),
        Positioned(
          top: 50,
          child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingStars(
                      value: value,
                      onValueChanged: (v) {
                        setState(() {
                          value = v;
                        });
                      },
                      starBuilder: (index, color) => Icon(
                        Icons.star,
                        color: color,
                      ),
                      starCount: 5,
                      starSize: 20,
                      valueLabelRadius: 10,
                      maxValue: 5,
                      starSpacing: 2,
                      maxValueVisibility: true,
                      valueLabelVisibility: false,
                      animationDuration: Duration(milliseconds: 1000),
                      valueLabelPadding: EdgeInsets.zero,
                      valueLabelMargin: EdgeInsets.zero,
                      starOffColor: Color(0xffe7e8ea),
                      starColor: 'FFB800'.toColor(),
                    ),
                    SizedBox(width: 4),
                    Text(
                      value.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 18,
                        color: 'FFB800'.toColor(),
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      '(5.2K+)',
                      style: TextStyle(
                        fontSize: 18,
                        color: '656565'.toColor(),
                      ),
                    ),
                  ],
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    color: '232631'.toColor(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  priceRange,
                  style: TextStyle(
                    fontSize: 18,
                    color: '656565'.toColor(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_sharp,
                      color: '656565'.toColor(),
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      location,
                      style: TextStyle(
                        fontSize: 16,
                        color: '656565'.toColor(),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 34),
                ViewAllButton(
                  text: 'Make Reservation',
                  icon: Icons.arrow_forward_ios,
                  backgroundColor: 'FDC886'.toColor(),
                  textColor: '232631'.toColor(),
                  onPressed: () {},
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Image.asset(
                      'assets/info.png',
                      scale: 2,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'No extra cost',
                      style: TextStyle(
                        fontSize: 16,
                        color: '656565'.toColor(),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
