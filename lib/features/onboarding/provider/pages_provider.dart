import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sani_talk/common/widgets/page_view_layout.dart';

final List<Widget> _pages = [
  PageViewLayout(
    text:
        'Enjoy you life with SafeTalk, Make Circle with friends and Strangers, Create your own environment. Lorem ipsum get to your country and go together',
    image: 'assets/images/talk1.jpg',
  ),
  PageViewLayout(
    text:
        'Enjoy you life with SafeTalk, Make Circle with friends and Strangers, Create your own environment. Lorem ipsum get to your country and go together',
    image: 'assets/images/talk1.jpg',
  ),
  PageViewLayout(
    text:
        'Enjoy you life with SafeTalk, Make Circle with friends and Strangers, Create your own environment. Lorem ipsum get to your country and go together',
    image: 'assets/images/talk1.jpg',
  ),
];

final pageProvider = Provider<List<Widget>>(
  (ref) => _pages,
);
