class Category {
  Category({
    this.title = '',
    this.imagePath = '',
    this.description = '',
    this.money = 0,
    this.rating = 0.0,
  });

  String title;
  String description;
  int money;
  double rating;
  String imagePath;

  static List<Category> categoryList = <Category>[
    Category(
      imagePath: 'asset/images/flutter.png',
      title: 'Flutter',
      description: 'Google',
      money: 25,
      rating: 4.3,
    ),
    Category(
      imagePath: 'asset/images/react.png',
      title: 'React',
      description: '22',
      money: 18,
      rating: 4.6,
    ),
    Category(
      imagePath: 'asset/images/laravel.png',
      title: 'Laravel',
      description: '24',
      money: 25,
      rating: 4.3,
    ),
    Category(
      imagePath: 'asset/images/python.png',
      title: 'Python',
      description: '22',
      money: 18,
      rating: 4.6,
    ),
  ];

  static List<Category> popularCourseList = <Category>[
    Category(
      imagePath: 'asset/images/boy1.png',
      title: 'App Design Course',
      description: '12',
      money: 25,
      rating: 4.8,
    ),
    Category(
      imagePath: 'asset/images/boy1.png',
      title: 'Web Design Course',
      description: '28',
      money: 208,
      rating: 4.9,
    ),
    Category(
      imagePath: 'asset/images/boy1.png',
      title: 'App Design Course',
      description: '12',
      money: 25,
      rating: 4.8,
    ),
    Category(
      imagePath: 'asset/images/boy1.png',
      title: 'Web Design Course',
      description: '28',
      money: 208,
      rating: 4.9,
    ),
  ];
}
