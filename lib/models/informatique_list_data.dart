class InformatiqueListData {
  InformatiqueListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.createdAt ="",

  });

  String imagePath;
  String titleTxt;
  String subTxt;
  String createdAt;
 

  static List<InformatiqueListData> informatiqueList = <InformatiqueListData>[
    InformatiqueListData(
      imagePath: 'asset/images/flutter.png',
      titleTxt: 'Flutter',
      subTxt:
          'Flutter is an open-source UI software development kit created by Google.',
      createdAt: "2023-03-29",
      
    ),
    InformatiqueListData(
      imagePath: 'asset/images/react.png',
      titleTxt: 'React',
      subTxt: 'React is a free and open-source front-end JavaScript library for building user interfaces based on components.',
      createdAt: "2023-01-02",
     
    ),
    InformatiqueListData(
      imagePath: 'asset/images/laravel.png',
      titleTxt: 'Laravel',
      subTxt: 'Laravel is a free and open-source PHP web framework',
      createdAt: "2023-03-30",
    
    ),
    InformatiqueListData(
      imagePath: 'asset/images/python.png',
      titleTxt: 'Python',
      subTxt: 'Python is a high-level, general-purpose programming language. Its design philosophy emphasizes code readability with the use of significant indentation.',
      createdAt: "2022-07-04",
      
    ),
  ];
}
