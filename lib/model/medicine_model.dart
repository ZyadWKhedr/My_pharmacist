class Medicine {
  final int id;
  final String commercialName;
  final String medicalName;
  final String dosage;
  final String description;
  final String category;
  final String type;
  final String frequency;
  final String image;
  final String sideEffects;
  final String precautions;
  final String interactions;

  Medicine({
    required this.id,
    required this.commercialName,
    required this.medicalName,
    required this.dosage,
    required this.description,
    required this.category,
    required this.type,
    required this.frequency,
    required this.image,
    required this.sideEffects,
    required this.precautions,
    required this.interactions,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'],
      commercialName: json['commercialName'],
      medicalName: json['medicalName'],
      dosage: json['dosage'],
      description: json['description'],
      category: json['category'],
      type: json['type'],
      frequency: json['frequency'],
      image: json['image'],
      sideEffects: json['sideEffects'],
      precautions: json['precautions'],
      interactions: json['interactions'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'commercialName': commercialName,
        'medicalName': medicalName,
        'dosage': dosage,
        'description': description,
        'category': category,
        'type': type,
        'frequency': frequency,
        'image': image,
        'sideEffects': sideEffects,
        'precautions': precautions,
        'interactions': interactions,
      };
}
