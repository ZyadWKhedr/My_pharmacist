import 'package:flutter/material.dart';
import 'package:healio/core/const.dart';
import 'package:healio/view_model/article_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ArticleCarousel extends StatefulWidget {
  final ArticleViewModel articleViewModel;

  const ArticleCarousel({super.key, required this.articleViewModel});

  @override
  _ArticleCarouselState createState() => _ArticleCarouselState();
}

class _ArticleCarouselState extends State<ArticleCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 350.0,
            enlargeCenterPage: true,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 6),
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            autoPlayCurve: Curves.easeInOut,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: widget.articleViewModel.articles.map((article) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () =>
                            _launchURL(Uri.parse(article.link)), // Corrected
                        child: Image.network(
                          article.photo,
                          width: double.infinity,
                          height: 244.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      GestureDetector(
                        onTap: () =>
                            _launchURL(Uri.parse(article.link)), // Corrected
                        child: Text(
                          article.title,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: lightBlue,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        SmoothPageIndicator(
          controller: PageController(initialPage: _currentIndex),
          count: widget.articleViewModel.articles.length,
          effect: ExpandingDotsEffect(
            dotWidth: 10.0,
            dotHeight: 8.0,
            activeDotColor: lightBlue,
            dotColor: Colors.grey,
            spacing: 4.0,
          ),
        ),
      ],
    );
  }

  // Function to launch URL
  Future<void> _launchURL(Uri url) async {
    try {
      final uri = Uri.parse(url.toString());
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
        print('Launching URL: ${url.toString()}');
      } else {
        throw 'Could not launch $uri';
      }
    } catch (e) {
      print('Error: $e');
    }
    
  }
}
