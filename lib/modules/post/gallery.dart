import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<String> _images = [
    'https://job-kb.oss-cn-shanghai.aliyuncs.com/public/banner/banner_member_benefits.png',
    'https://job-kb.oss-cn-shanghai.aliyuncs.com/public/banner/banner_ten_years.png',
    'https://job-kb.oss-cn-shanghai.aliyuncs.com/public/advertisement/%E8%80%81%E5%B8%A6%E6%96%B0_%E5%B2%97%E4%BD%8D%E5%88%97%E8%A1%A8banner.png',
  ];
  int _currentIndex;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _currentIndex = _pageController.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            itemCount: _images.length,
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(_images[index]));
            },
            pageController: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          Positioned(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Image.asset(
                'images/but_gb_tk.png',
                height: 20,
                width: 20,
              ),
            ),
            left: 18,
            top: 42,
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              '${_currentIndex + 1 }/${_images.length}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  decorationColor: Colors.black,
                  decoration: null),
            ),
          )
        ],
      ),
    );
  }
}
