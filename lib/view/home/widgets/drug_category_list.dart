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
      // Use MediaQuery to ensure the container takes full width of the screen
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: backgroungColor,
        borderRadius: BorderRadius.circular(12.0),
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
          // GridView to display drug categories in a 2-column grid
          GridView.builder(
            shrinkWrap: true, // To prevent GridView from taking up extra space
            physics:
                const NeverScrollableScrollPhysics(), // Disable scrolling in GridView
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Set the number of columns in the grid
              crossAxisSpacing: 32.0, // Space between columns
              mainAxisSpacing: 16.0, // Space between rows
              childAspectRatio: 1.0, // Control aspect ratio of each item
            ),
            itemCount:
                medicinesViewModel.categories.length, // Number of categories
            itemBuilder: (context, index) {
              String category = medicinesViewModel.categories[index];
              String imageUrl = medicinesViewModel.getCategoryImageUrl(
                  category); // Get image URL for the category

              return GestureDetector(
                onTap: () {
                  // When category is tapped, navigate to the MedicinesListPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MedicineListPage(
                        selectedCategory:
                            category, // Pass selected category to the next page
                      ),
                    ),
                  );
                },
                child: Container(
                  width:
                      double.infinity, // Ensure the container takes full width
                  height: 270.0, // Set fixed height for each category item
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 10.0), // Padding inside the item
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color of the container
                    borderRadius:
                        BorderRadius.circular(12.0), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 4), // Shadow offset
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image of the drug category
                        Image.network(
                          imageUrl,
                          width: MediaQuery.of(context)
                              .size
                              .width, // Dynamically adjust width based on screen size
                          height: 80.0, // Fixed height for the image
                          fit:
                              BoxFit.cover, // Ensure the image covers the space
                        ),
                        const SizedBox(
                            height:
                                12.0), // Space between image and category text
                        // Category name text
                        Text(
                          category,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color:
                                lightBlue, // Color for the category name text
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
