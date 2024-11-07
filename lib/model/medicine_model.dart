class Medicine {
  final String id;
  final String commercialName;
  final String medicalName;
  final String dosage;
  final String type;
  final String category;
  final String description;
  final String? imageUrl;
  final String sideEffects;
  final String precautions;
  final String interactions;

  Medicine({
    required this.id,
    required this.commercialName,
    required this.medicalName,
    required this.dosage,
    required this.type,
    required this.category,
    required this.description,
    this.imageUrl, 
    required this.sideEffects,
    required this.precautions,
    required this.interactions,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'] ?? '',
      commercialName: json['commercialName'] ?? '',
      medicalName: json['medicalName'] ?? '',
      dosage: json['dosage'] ?? '',
      type: json['type'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'], 
      sideEffects: json['sideEffects'] ?? '',
      precautions: json['precautions'] ?? '',
      interactions: json['interactions'] ?? '',
    );
  }
}
