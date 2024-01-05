import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:banner_carousel/banner_carousel.dart';

class Slider extends StatefulWidget {
  const Slider({super.key});

  @override
  State<Slider> createState() => _SliderState();
}

class _SliderState extends State<Slider> {
  @override
  Widget build(BuildContext context) {
    List<BannerModel> listBanners = [
      BannerModel(imagePath: "assets/img/h1.jpg", id: "1"),
      BannerModel(imagePath: "assets/img/h2.jpg", id: "2"),
      BannerModel(imagePath: "assets/img/h3.jpg", id: "3"),
      BannerModel(imagePath: "assets/img/h4.jpg", id: "4"),
    ];
    return BannerCarousel(
      banners: listBanners,
    );
  }
}
