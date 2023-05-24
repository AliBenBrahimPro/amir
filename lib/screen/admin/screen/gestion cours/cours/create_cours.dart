import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:amir/models/domaines_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../Services/cours_service.dart';
import '../../../../../Services/domaines_services.dart';
import '../../../../../shared/app_colors.dart';
import '../../../../../shared/dimensions/dimensions.dart';
import '../../../../../theme.dart';
import '../../../../../widgets/buttons/action_button.dart';
import '../../../../../widgets/inputs/input_field.dart';

class CreateCours extends StatefulWidget {
  const CreateCours({super.key});

  @override
  State<CreateCours> createState() => _CreateCoursState();
}

class _CreateCoursState extends State<CreateCours> {
  List<Domaines> domaines = [];
  DomainesController domainesController = DomainesController();
  bool isLoaded = true;
  bool isDomainesLoaded = true;

  getData() async {
    domaines = await domainesController.getAllDomaines();
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
  final List<Map> myJson = [
    {"id": '1', "image": "asset/icons/category/all.png", "name": "Tous"},
    {
      "id": '2',
      "image": "asset/icons/category/communication.png",
      "name": "communication"
    },
    {"id": '3', "image": "asset/icons/category/ethics.png", "name": "Ethics"},
    {"id": '4', "image": "asset/icons/category/history.png", "name": "History"},
    {"id": '5', "image": "asset/icons/category/langue.png", "name": "Langue"},
    {"id": '6', "image": "asset/icons/category/math.png", "name": "Math"},
    {
      "id": '7',
      "image": "asset/icons/category/microscope.png",
      "name": "Sciences de la vie et de la Terre"
    },
    {"id": '8', "image": "asset/icons/category/musical.png", "name": "Musique"},
    {
      "id": '9',
      "image": "asset/icons/category/physique.png",
      "name": "Physique"
    },
    {
      "id": '10',
      "image": "asset/icons/category/programming.png",
      "name": "Informatique"
    },
    {"id": '11', "image": "asset/icons/category/sportive.png", "name": "Sport"},
    {
      "id": '12',
      "image": "asset/icons/category/Technology.png",
      "name": "Technologie"
    }
  ];

  Future getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(
      () {
        if (image != null) {
          _image = File(image.path);
        } else {}
      },
    );
  }

  String categoryId = "";
  String? dropdownvalue;
  TextEditingController namecoursController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  CoursController coursController = CoursController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: pink,
        ),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: Form(
            key: _formkey,
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Center(
                    child: _image == null
                        ? Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                                child: SizedBox(
                                    width: 100,
                                    child: InkWell(
                                        onTap: () async {
                                          getImage();
                                          setState(() {});
                                        },
                                        child: Image.asset(
                                            'asset/images/upload.png')))),
                          )
                        : Stack(
                            children: <Widget>[
                              SizedBox(
                                width: 250.0,
                                height: 320.0,
                                child: Image.file(_image!),
                              ),
                              Positioned(
                                right: 5.0,
                                child: InkWell(
                                  child: const Icon(
                                    Icons.remove_circle,
                                    size: 30,
                                    color: Colors.red,
                                  ),
                                  onTap: () {
                                    setState(
                                      () {
                                        _image = null;
                                      },
                                    );
                                  },
                                ),
                              )
                            ],
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
                          borderSide:
                              const BorderSide(width: 2.0, color: pinkColor),
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
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputField(
                    label: "Nom du cours",
                    controller: namecoursController,
                    textInputType: TextInputType.text,
                  ),
                  InputField(
                    label: "Déscription du cours",
                    controller: descriptionController,
                    textInputType: TextInputType.text,
                  ),
                  loading
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: Constants.screenHeight * 0.01),
                          child: const CircularProgressIndicator(),
                        )
                      : _image == null || _selected== null
                          ? ActionButton(
                              label: "Ajouter",
                              buttonColor: Colors.grey,
                              labelColor: Colors.white,
                              onPressed: ()=>null)
                          : ActionButton(
                              label: "Ajouter",
                              buttonColor: greenColor,
                              labelColor: Colors.white,
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  print(_selected);
                                  coursController.createCours(
                                      namecoursController.text,
                                      descriptionController.text,
                                      _selected,
                                      _image);
                                }
                              })
                ],
              ),
            )));
  }
}
