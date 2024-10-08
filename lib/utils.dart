import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supercharged/supercharged.dart';

import 'models/models.dart';

final ButtonStyle unyu = ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
  elevation: 0,
  textStyle: GoogleFonts.poppins().copyWith(fontSize: 14),
  backgroundColor: '5A4FCF'.toColor().withOpacity(0.2),
);

final ButtonStyle oyen = ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
  elevation: 0,
  textStyle: GoogleFonts.poppins().copyWith(fontSize: 14),
  backgroundColor: 'FDC886'.toColor(),
);

List<Fitur> fitur = [
  Fitur(id: '1', icon: 'assets/diskon.png', title: 'Extra Discounts', subtitle: 'Get your special discount by\nusing our reservation',),
  Fitur(id: '2', icon: 'assets/eat.png', title: 'Come and Eat', subtitle: 'Get your own table quickly &\nwithout waiting in line',),
  Fitur(id: '3', icon: 'assets/fee.png', title: 'No Extra Fee', subtitle: 'Get tax free if you want to order\nfood and make a reservation',),
  Fitur(id: '4', icon: 'assets/clean.png', title: 'Guaranteed Cleanliness', subtitle: 'We ensure the cleanliness of the\nplace as well as the food',),
];

