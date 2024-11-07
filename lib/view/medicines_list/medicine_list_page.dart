import 'package:flutter/material.dart';
import 'package:healio/core/const.dart';
import 'package:healio/view/medicines_list/widgets/medicine_container.dart';
import 'package:healio/view_model/medicine_provider.dart';
import 'package:provider/provider.dart';

class MedicineListPage extends StatefulWidget {
  final String selectedCategory;

  MedicineListPage({required this.selectedCategory});

  @override
  _MedicineListPageState createState() => _MedicineListPageState();
}

class _MedicineListPageState extends State<MedicineListPage> {
  bool _isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    // Only fetch if it's the first load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isFirstLoad) {
        _isFirstLoad = false;
        // Fetch medicines based on the selected category
        Provider.of<MedicineViewModel>(context, listen: false)
            .fetchMedicinesByCategory(widget.selectedCategory);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromRadius(30),
        child: AppBar(
          backgroundColor: lightBlue,
          centerTitle: true,
          title: Text(widget.selectedCategory),
        ),
      ),
      body: Consumer<MedicineViewModel>(builder: (context, viewModel, child) {
        // Show error message if there's an issue fetching data
        if (viewModel.errorMessage.isNotEmpty) {
          return Center(child: Text(viewModel.errorMessage));
        }

        // Show a message if no medicines are available for the selected category
        if (viewModel.medicines.isEmpty) {
          return Center(
              child: Text('No medicines available for this category.'));
        }

        // Filter the medicines to only include those that match the selected category
        final filteredMedicines = viewModel.medicines
            .where((medicine) => medicine.category == widget.selectedCategory)
            .toList();

        // Display list of medicines for the selected category
        return ListView.builder(
          itemCount: filteredMedicines.length,
          itemBuilder: (context, index) {
            final medicine = filteredMedicines[index];
            return MedicineContainer(
                medicine: medicine); // Using MedicineContainer for display
          },
        );
      }),
    );
  }
}
