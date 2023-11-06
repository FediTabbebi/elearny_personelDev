class TrainingModel {
  String idTraining;
  String title;
  String description;
  String author;
  String duration;
  double price;
  String trailerVid;
  String image;
  DateTime creationDate = DateTime.now();
  List<String>? authorizedUsers = [];
  // List<TagModel>? tags = [];
  // List<LessonModel>? lessons = [];
  // List<CategoryModel>? category = [];

  TrainingModel({
    required this.idTraining,
    required this.title,
    required this.description,
    required this.author,
    required this.duration,
    required this.price,
    required this.trailerVid,
    required this.image,
    required this.creationDate,
    this.authorizedUsers,
    // this.tags,
    // this.lessons,
    // this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'idTraining': idTraining,
      'title': title,
      'description': description,
      'author': author,
      'duration': duration,
      'price': price,
      'trailerVid': trailerVid,
      'image': image,
      'creationDate': creationDate,
      'authorizedUsers': authorizedUsers,
      // 'tags': tags,
      // 'lessons': lessons,
      // 'category': category,
    };
  }

  factory TrainingModel.fromJson(Map<String, dynamic> map) {
    return TrainingModel(
      idTraining: map['idTraining'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      author: map['author'] as String,
      duration: map['duration'] as String,
      price: map['price'] as double,
      trailerVid: map['trailerVid'] as String,
      image: map['image'] as String,
      creationDate: map['creationDate'] as DateTime,
      authorizedUsers: map['authorizedUsers'] as List<String>,
      // tags: map['tags'] as List<TagModel>,
      // lessons: map['lessons'] as List<LessonModel>,
      // category: map['category'] as List<CategoryModel>,
    );
  }
}
