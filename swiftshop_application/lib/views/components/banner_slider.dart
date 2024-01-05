import 'package:flutter/src/widgets/framework.dart';
import 'package:banner_carousel/banner_carousel.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  @override
  Widget build(BuildContext context) {
    List<BannerModel> listBanners = [
      BannerModel(imagePath: "assets/banner/h1.jpg", id: "1"),
      BannerModel(imagePath: "assets/banner/h2.jpg", id: "2"),
      BannerModel(imagePath: "assets/banner/h3.jpg", id: "3"),
      BannerModel(imagePath: "assets/banner/h4.jpg", id: "4"),
    ];
    return BannerCarousel(
      banners: listBanners,
    );
  }
}
