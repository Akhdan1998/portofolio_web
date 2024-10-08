import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';

class ButtonFitur extends StatefulWidget {
  final String id;
  final String icon;
  final String title;
  final String subtitle;

  const ButtonFitur({
    required this.id,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  State<ButtonFitur> createState() => _ButtonFiturState();
}

class _ButtonFiturState extends State<ButtonFitur> {
  Color _buttonColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(48),
          bottomLeft: Radius.circular(48),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
            child: Image.asset(widget.icon, height: 48, width: 48),
          ),
          Text(
            widget.title,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              widget.subtitle,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (event) {
              setState(() {
                _buttonColor = 'FDC886'.toColor();
              });
            },
            onExit: (event) {
              setState(() {
                _buttonColor = Colors.white;
              });
            },
            child: Bounce(
              duration: Duration(milliseconds: 100),
              onPressed: () {},
              child: Container(
                padding: EdgeInsets.only(bottom: 24, top: 24, left: 65, right: 65),
                decoration: BoxDecoration(
                  color: _buttonColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                    bottomRight: Radius.circular(48),
                    bottomLeft: Radius.circular(48),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View Details',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showToast(BuildContext context, String message, IconData icon, Color iconColor) {
  DelightToastBar(
    animationDuration: Duration(seconds: 2),
    snackbarDuration: Duration(seconds: 5),
    autoDismiss: true,
    position: DelightSnackbarPosition.top,
    builder: (context) {
      return ToastCard(
        color: Colors.white,
        leading: Icon(
          icon,
          size: 28,
          color: iconColor,
        ),
        title: Text(
          message,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      );
    },
  ).show(context);
}

//Top Restoran
class HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top 3 Featured Restaurant',
          style: TextStyle(
            color: Color(0xFF5A4FCF),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Most Popular Restaurants',
          style: TextStyle(
            color: Color(0xFF232631),
            fontSize: 28,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'The best restaurant in our opinion is how\nmuch customers like it in terms of place,\nprice, comfort, and of course, the taste of\nthe food itself.',
          style: TextStyle(
            color: Color(0xFF656565),
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class ViewAllButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amberAccent,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'View All Restaurants',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

class RestaurantCard extends StatefulWidget {
  final String imagePath;
  final String restaurantName;
  final String bintang;
  final String view;
  final String kota;
  final double cardWidth;

  RestaurantCard({
    required this.imagePath,
    required this.restaurantName,
    required this.bintang,
    required this.view,
    required this.kota,
    required this.cardWidth,
  });

  @override
  _RestaurantCardState createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: _isHovered ? widget.cardWidth + 80 : widget.cardWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: DecorationImage(
                image: AssetImage(widget.imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (_isHovered)
            Positioned(
              bottom: 24,
              left: 24,
              right: 24,
              child: AnimatedOpacity(
                opacity: 1,
                duration: Duration(milliseconds: 300),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow),
                          SizedBox(width: 4),
                          Text(
                            widget.bintang,
                            style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            widget.view,
                            style: TextStyle(color: Color(0xFF656565)),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.restaurantName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF232631),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Color(0xFFFDC886),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(Icons.arrow_forward, size: 24),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.location_on_sharp, color: Color(0xFF656565)),
                          SizedBox(width: 4),
                          Text(
                            widget.kota,
                            style: TextStyle(
                              color: Color(0xFF656565),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

final List<Map<String, dynamic>> restaurants = [
  {
    'image': 'assets/based1.png',
    'rating': '8.6',
    'reviews': '(3.5K+)',
    'name': 'Tom’s by Tom Aikens The Langham',
    'price': 'IDR 29.000 - IDR 259.999',
  },
  {
    'image': 'assets/based2.png',
    'rating': '9.6',
    'reviews': '(9.5K+)',
    'name': 'Handi by Brasserie Le Méridien',
    'price': 'IDR 49.999 - IDR 560.000',
  },
  {
    'image': 'assets/based3.png',
    'rating': '7.9',
    'reviews': '(7.5K+)',
    'name': 'Tatemukai Signature',
    'price': 'IDR 29.999 - IDR 560.000',
  },
];

//Restoran near you
class HoverableRestaurantCard extends StatefulWidget {
  final Map<String, dynamic> restaurant;

  HoverableRestaurantCard(this.restaurant);

  @override
  _HoverableRestaurantCardState createState() => _HoverableRestaurantCardState();
}

class _HoverableRestaurantCardState extends State<HoverableRestaurantCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: Stack(
        children: [
          Image.asset(widget.restaurant['image'], scale: 2),
          if (_isHovered)
            Positioned(
              bottom: 24,
              left: 24,
              right: 24,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Rating dan reviews
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow),
                        SizedBox(width: 4),
                        Text(
                          widget.restaurant['rating'],
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          widget.restaurant['reviews'],
                          style: TextStyle(color: Color(0xFF656565)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            widget.restaurant['name'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF232631),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Color(0xFFFDC886),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.arrow_forward, size: 24),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    // Harga
                    Row(
                      children: [
                        Icon(Icons.location_on_sharp, color: Color(0xFF656565)),
                        SizedBox(width: 4),
                        Text(
                          widget.restaurant['price'],
                          style: TextStyle(
                            color: Color(0xFF656565),
                            fontSize: 16,
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
    );
  }
}