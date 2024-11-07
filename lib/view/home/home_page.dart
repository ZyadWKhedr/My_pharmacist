import 'package:flutter/material.dart';
import 'package:healio/core/const.dart';
import 'package:healio/view/home/widgets/article_carousel.dart';
import 'package:healio/view/home/widgets/cutom_drawer.dart';
import 'package:healio/view/home/widgets/drug_category_list.dart';
import 'package:healio/view/home/widgets/search_bar.dart';
import 'package:healio/view_model/article_provider.dart';
import 'package:healio/view_model/medicine_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final articleViewModel = Provider.of<ArticleViewModel>(context);
    final medicinesViewModel = Provider.of<MedicineViewModel>(context);
    medicinesViewModel.fetchMedicines();

    // Fetch the articles when the page is first built
    if (articleViewModel.articles.isEmpty && !articleViewModel.isLoading) {
      articleViewModel.fetchArticles();
    }

    return Scaffold(
      drawer: const CustomDrawer(),
      body: articleViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60.0),
                    child: Row(
                      children: [
                        Builder(
                          builder: (context) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 5),
                              child: IconButton(
                                icon: Container(
                                  width: 40.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: lightBlue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                ),
                                onPressed: () {
                                  Scaffold.of(context).openDrawer();
                                },
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 16),
                        const Expanded(child: CustomSearchBar()),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ArticleCarousel(articleViewModel: articleViewModel),
                  const SizedBox(height: 30),
                  DrugCategoryList(medicinesViewModel: medicinesViewModel),
                ],
              ),
            ),
    );
  }
}
