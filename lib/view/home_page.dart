import 'package:flutter/material.dart';
import 'package:healio/core/widgets/custom_button.dart';
import 'package:healio/view_model/article_provider.dart';
import 'package:healio/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    final articleViewModel = Provider.of<ArticleViewModel>(context);

    // Fetch the articles when the page is first built
    if (articleViewModel.articles.isEmpty && !articleViewModel.isLoading) {
      articleViewModel.fetchArticles();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: articleViewModel.isLoading
          ? Center(child: CircularProgressIndicator()) // Loading indicator
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Carousel Slider for Article Photos and Titles
                CarouselSlider(
                  options: CarouselOptions(
                    height: 300.0, // Set height for the carousel
                    enlargeCenterPage: true,
                    viewportFraction:
                        1.0, // Make each slide fill the screen width
                    enableInfiniteScroll: false, // Disable infinite scroll
                  ),
                  items: articleViewModel.articles.map((article) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context)
                              .size
                              .width, // Full screen width
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              // Wrap the image with GestureDetector for tap action
                              GestureDetector(
                                onTap: () => _launchURL(
                                    article.link), // Launch URL on tap
                                child: Image.network(
                                  article.photo,
                                  width: double
                                      .infinity, // Full width for the image
                                  height: 200.0, // Set the height for the image
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              // Article Title with GestureDetector for tap action
                              GestureDetector(
                                onTap: () => _launchURL(
                                    article.link), // Launch URL on tap
                                child: Text(
                                  article.title,
                                  textAlign:
                                      TextAlign.center, // Center the title
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
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

                // Sign Out Button
                Center(
                  child: CustomButton(
                    label: 'Sign out',
                    onPressed: () {
                      userViewModel.signOut();
                    },
                  ),
                ),
              ],
            ),
    );
  }

  // Function to launch URL
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
