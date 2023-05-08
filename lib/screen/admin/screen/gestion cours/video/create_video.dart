import 'dart:developer';
import 'dart:io';

import 'package:amir/models/chapitres_model.dart';
import 'package:amir/models/cours_model.dart';
import 'package:amir/models/domaines_model.dart';
import 'package:amir/models/lecons_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../Services/catalogues_services.dart';
import '../../../../../Services/chapitres_Services.dart';
import '../../../../../Services/lecons_Services.dart';
import '../../../../../Services/cours_service.dart';
import '../../../../../Services/domaines_services.dart';
import '../../../../../Services/video_service.dart';
import '../../../../../models/catalogues_model.dart';
import '../../../../../shared/app_colors.dart';
import '../../../../../shared/dimensions/dimensions.dart';
import '../../../../../theme.dart';
import '../../../../../widgets/buttons/action_button.dart';
import '../../../../../widgets/inputs/input_field.dart';
import 'read_video.dart';

class CreateVideos extends StatefulWidget {
  const CreateVideos({super.key});

  @override
  State<CreateVideos> createState() => _CreateVideosState();
}

class _CreateVideosState extends State<CreateVideos> {
  List<Catalogues> category = [];
  List<Domaines> domaines = [];
  List<Cours> cours = [];
  List<Chapitres> chapitre = [];
  List<Lecons> lecons = [];
  CataloguesController caloguesController = CataloguesController();
  DomainesController domainesController = DomainesController();
  CoursController coursController = CoursController();
  ChapitresController chapitresController = ChapitresController();
  LeconsController leconsController = LeconsController();
  bool isLoaded = true;
  bool isDomainesLoaded = true;
  File? videosFile;
  getData() async {
    category = await caloguesController.getAllcatalogues();
    setState(() {
      isLoaded = false;
    });
  }

  getSpecificsDomaines(String? id) async {
    domaines = await domainesController.getSpecDomaines(id);
    setState(() {
      isDomainesLoaded = false;
    });
  }

  getSpecificsCours(String? id) async {
    cours = await coursController.getSpecCours(id);
    setState(() {
      isDomainesLoaded = false;
    });
  }

  getSpecificsChapitres(String? id) async {
    chapitre = await chapitresController.getSpecChapitres(id);
    setState(() {
      isDomainesLoaded = false;
    });
  }

  getSpecificsLecon(String? id) async {
    lecons = await leconsController.getSpecLecons(id);
    setState(() {
      isDomainesLoaded = false;
    });
  }

  uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path ?? "");
      setState(() {
        videosFile = file;
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  bool loading = false;
  bool check = false;

  final _formkey = GlobalKey<FormState>();
  File? _image = null;
  late final _picker = ImagePicker();
  String? _selected;
  String? idCours;
  String? idChapitre;
  String? idLecons;

  String categoryId = "";
  String? dropdownvalue;
  TextEditingController urlController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  VideosController videosController = VideosController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: pink,
          leading: BackButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ReadVideos()),
            ),
          ),
        ),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: 
        FutureBuilder<List<Catalogues>>(
          future: caloguesController.getAllcatalogues(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Catalogues> data = snapshot.data!;

              return data.isEmpty
                  ? const Center(
                      child: Text("Pas de catalogue"),
                    )
                  : Form(
                      key: _formkey,
                      child: Center(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Constants.screenHeight * 0.001,
                                  horizontal: Constants.screenWidth * 0.07),
                              child: DropdownButtonFormField<String?>(
                                hint: const Text("Catalogue"),
                                decoration: InputDecoration(
                                  focusedErrorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: pinkColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                        width: 2.0, color: pinkColor),
                                  ),
                                ),
                                value: dropdownvalue,
                                isDense: true,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: data.map((items) {
                                  return DropdownMenuItem(
                                    value: items.id,
                                    child: Text(items.collegeYear),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    List<Cours> cours = [];
                                    List<Chapitres> chapitre = [];
                                    domaines.clear();
                                    cours.clear();
                                    chapitre.clear();
                                    _selected = null;
                                    idCours = null;
                                    idChapitre = null;
                                    dropdownvalue = newValue!;
                                    getSpecificsDomaines(dropdownvalue);
                                    log(domaines
                                        .map((e) => e.nameDomain)
                                        .toString());
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Constants.screenHeight * 0.001,
                                  horizontal: Constants.screenWidth * 0.07),
                              child: DropdownButtonFormField<String?>(
                                hint: const Text("select domaine"),
                                decoration: InputDecoration(
                                  focusedErrorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: pinkColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                        width: 2.0, color: pinkColor),
                                  ),
                                ),
                                value: _selected,
                                isDense: true,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: domaines.map((map) {
                                  return DropdownMenuItem(
                                    value: map.id.toString(),
                                    // value: _mySelection,
                                    child: Text(map.nameDomain),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    cours.clear();
                                    chapitre.clear();
                                    idCours = null;
                                    idChapitre = null;
                                    _selected = newValue;
                                    getSpecificsCours(_selected);
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Constants.screenHeight * 0.001,
                                  horizontal: Constants.screenWidth * 0.07),
                              child: DropdownButtonFormField<String?>(
                                hint: const Text("select cours"),
                                decoration: InputDecoration(
                                  focusedErrorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: pinkColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                        width: 2.0, color: pinkColor),
                                  ),
                                ),
                                value: idCours,
                                isDense: true,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: cours.map((map) {
                                  return DropdownMenuItem(
                                    value: map.id.toString(),
                                    // value: _mySelection,
                                    child: Text(map.nameCour),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    chapitre.clear();
                                    idChapitre = null;
                                    idCours = newValue;
                                    getSpecificsChapitres(idCours);
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Constants.screenHeight * 0.001,
                                  horizontal: Constants.screenWidth * 0.07),
                              child: DropdownButtonFormField<String?>(
                                hint: const Text("select chapitre"),
                                decoration: InputDecoration(
                                  focusedErrorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: pinkColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                        width: 2.0, color: pinkColor),
                                  ),
                                ),
                                value: idChapitre,
                                isDense: true,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: chapitre.map((map) {
                                  return DropdownMenuItem(
                                    value: map.id.toString(),
                                    // value: _mySelection,
                                    child: Text(map.title),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    idChapitre = newValue;
                                    getSpecificsLecon(idChapitre);
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Constants.screenHeight * 0.001,
                                  horizontal: Constants.screenWidth * 0.07),
                              child: DropdownButtonFormField<String?>(
                                hint: const Text("select leçon"),
                                decoration: InputDecoration(
                                  focusedErrorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: pinkColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                        width: 2.0, color: pinkColor),
                                  ),
                                ),
                                value: idLecons,
                                isDense: true,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: lecons.map((map) {
                                  return DropdownMenuItem(
                                    value: map.id.toString(),
                                    // value: _mySelection,
                                    child: Text(map.name),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    idLecons = newValue;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                             InputField(
                              label: "Url",
                              controller: urlController,
                              textInputType: TextInputType.text,
                            ),
                            InputField(
                              label: "numero du videos",
                              controller: numberController,
                              textInputType: TextInputType.text,
                            ),
                            InputField(
                              label: "Time",
                              controller: timeController,
                              textInputType: TextInputType.text,
                            ),
                           
                          
                            loading
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            Constants.screenHeight * 0.01),
                                    child: const CircularProgressIndicator(),
                                  )
                                : ActionButton(
                                    label: "Ajouter",
                                    buttonColor: greenColor,
                                    labelColor: Colors.white,
                                    onPressed: () {
                                      if (_formkey.currentState!.validate()) {
                                        log(_image.toString());
                                         Map formData ={
                                      "number": int.parse(numberController.text) ,
                                      "url": urlController.text,
                                      "time":int.parse(timeController.text),
                                      "id_lecons": idLecons,
                                                    };
                                      
                                        videosController.createVideos(formData);
                                      }
                                    })
                          ],
                        ),
                      ));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
