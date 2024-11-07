import 'package:flutter/material.dart';
import 'package:healio/core/const.dart';
import 'package:healio/view/medicines_list/medicine_list_page.dart';
import 'package:healio/view_model/medicine_provider.dart';

class DrugCategoryList extends StatelessWidget {
  final MedicineViewModel medicinesViewModel;

  const DrugCategoryList({super.key, required this.medicinesViewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: backgroungColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Drugs Categories',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: lightBlue,
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 32.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 1.2,
            ),
            itemCount: medicinesViewModel.categories.length,
            itemBuilder: (context, index) {
              String category = medicinesViewModel.categories[index];
              String imageUrl =
                  medicinesViewModel.getCategoryImageUrl(category);

              return GestureDetector(
                onTap: () {
                  // Navigate to the MedicinesListPage with the selected category
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MedicineListPage(
                        selectedCategory: category,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 270.0,
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
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
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          imageUrl,
                          width: MediaQuery.of(context).size.width,
                          height: 80.0,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          category,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: lightBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
