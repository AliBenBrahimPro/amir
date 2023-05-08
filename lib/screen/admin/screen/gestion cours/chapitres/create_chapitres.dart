import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:amir/models/cours_model.dart';
import 'package:amir/models/domaines_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../Services/catalogues_services.dart';
import '../../../../../Services/chapitres_Services.dart';
import '../../../../../Services/cours_service.dart';
import '../../../../../Services/domaines_services.dart';
import '../../../../../models/catalogues_model.dart';
import '../../../../../shared/app_colors.dart';
import '../../../../../shared/dimensions/dimensions.dart';
import '../../../../../theme.dart';
import '../../../../../widgets/buttons/action_button.dart';
import '../../../../../widgets/inputs/input_field.dart';

class CreateChapitres extends StatefulWidget {
  const CreateChapitres({super.key});

  @override
  State<CreateChapitres> createState() => _CreateChapitresState();
}

class _CreateChapitresState extends State<CreateChapitres> {
  List<Catalogues> category = [];
  List<Domaines> domaines = [];
  List<Cours> cours = [];
  CataloguesController caloguesController = CataloguesController();
  DomainesController domainesController = DomainesController();
  CoursController coursController = CoursController();
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

  String categoryId = "";
  String? dropdownvalue;
  TextEditingController titlesController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController contenuController = TextEditingController();

  ChapitresController chapitresController = ChapitresController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: pink,
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
                                    domaines.clear();
                                    _selected = null;
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
                                    idCours = newValue;
                                    log(idCours.toString());
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InputField(
                              label: "title",
                              controller: titlesController,
                              textInputType: TextInputType.text,
                            ),
                            InputField(
                              label: "numero du chapitres",
                              controller: numberController,
                              textInputType: TextInputType.text,
                            ),
                            InputField(
                              label: "contenu du chapitres",
                              controller: contenuController,
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
                                          "title": titlesController.text,
                                          "number": numberController.text,
                                          "id_cour": idCours,
                                          'contenu': contenuController.text
                                        };
                                        chapitresController
                                            .createChapitres(formData);
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
