import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:amir/models/chapitres_model.dart';
import 'package:amir/models/cours_model.dart';
import 'package:amir/models/domaines_model.dart';
import 'package:amir/screen/admin/screen/gestion%20cours/lecons/read_lecons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../Services/catalogues_services.dart';
import '../../../../../Services/chapitres_Services.dart';
import '../../../../../Services/lecons_Services.dart';
import '../../../../../Services/cours_service.dart';
import '../../../../../Services/domaines_services.dart';
import '../../../../../models/catalogues_model.dart';
import '../../../../../shared/app_colors.dart';
import '../../../../../shared/dimensions/dimensions.dart';
import '../../../../../theme.dart';
import '../../../../../widgets/buttons/action_button.dart';
import '../../../../../widgets/inputs/input_field.dart';

class CreateLecons extends StatefulWidget {
  const CreateLecons({super.key});

  @override
  State<CreateLecons> createState() => _CreateLeconsState();
}

class _CreateLeconsState extends State<CreateLecons> {
  List<Catalogues> category = [];
  List<Domaines> domaines = [];
  List<Cours> cours = [];
  List<Chapitres> chapitre = [];
  CataloguesController caloguesController = CataloguesController();
  DomainesController domainesController = DomainesController();
  CoursController coursController = CoursController();
  ChapitresController chapitresController = ChapitresController();
  bool isLoaded = true;
  bool isDomainesLoaded = true;
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
  

  String categoryId = "";
  String? dropdownvalue;
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  LeconsController leconsController = LeconsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: pink,
          leading: BackButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ReadLecons()),
            ),
          ),
        ),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: FutureBuilder<List<Catalogues>>(
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
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InputField(
                              label: "Nom du leçon",
                              controller: nameController,
                              textInputType: TextInputType.text,
                            ),
                            InputField(
                              label: "numero du leçon",
                              controller: numberController,
                              textInputType: TextInputType.text,
                            ),
                            InputField(
                              label: "description du leçon",
                              controller: descriptionController,
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
                                        Map formData = {
                                          "name": nameController.text,
                                          "number": numberController.text,
                                          "id_chapitre": idChapitre,
                                          'description':
                                              descriptionController.text
                                        };
                                        leconsController.createLecons(formData);
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
