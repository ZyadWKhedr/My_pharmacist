class Medicine {
  final int id;
  final String medicineName;
  final String commercialName;
  final String category;
  final String description;
  final String type;
  final String dosage;
  final String frequency;

  Medicine({
    required this.id,
    required this.medicineName,
    required this.commercialName,
    required this.category,
    required this.description,
    required this.type,
    required this.dosage,
    required this.frequency,
  });

  
  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'],
      medicineName: json['medicineName'],
      commercialName: json['commercialName'],
      category: json['category'],
      description: json['description'],
      type: json['type'],
      dosage: json['dosage'],
      frequency: json['frequency'],
    );
  }
}
