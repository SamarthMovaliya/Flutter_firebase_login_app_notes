import 'package:firebase_login_pages/ModalClass/globals.dart';
import 'package:firebase_login_pages/helper/Firebase_store_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  String NoteName = 'Untitled...';
  String myColor = '0xffffecb3';
  String Title = '';
  String Body = '';
  Color myPickedColor = Colors.amber.shade100;
  Color currentColor = Colors.amber.shade100;
  final GlobalKey<FormState> EditKey = GlobalKey<FormState>();
  TextEditingController NameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  final DateTime dateTime = DateTime.now();

  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        decoration: BoxDecoration(color: Colors.grey.shade200, boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            offset: const Offset(-2, -2),
            blurRadius: 4,
          )
        ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                        'Select Color',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                      content: SingleChildScrollView(
                        child: MaterialPicker(
                          pickerColor: currentColor,
                          onColorChanged: (Color val) {
                            setState(() {
                              currentColor = val;
                              print('_________________________');
                              String halfCode =
                                  currentColor.toString().split('(')[1];
                              String fullCode = halfCode.split(')')[0];
                              myColor = fullCode;
                              print(fullCode);
                              print('_________________________');
                            });
                            Navigator.pop(context);
                          },
                        ),
                        // ColorPicker(
                        //   onColorChanged: (val) {
                        //     setState(() {
                        //       val = currentColor;
                        //     });
                        //   },
                        //   pickerColor: currentColor,
                        // ),
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.color_lens_sharp),
              ),
              IconButton(
                onPressed: () async {
                  Map<String, dynamic> data = {
                    'NoteName': NoteName,
                    'NoteTitle': Title,
                    'NoteBody': Body,
                    'ColorCode': myColor,
                    'Date':
                        '${dateTime.day}-${dateTime.month}-${dateTime.year}',
                  };
                  await FireBaseStoreHelper.fireBaseStoreHelper
                      .insert(data: data);
                  Navigator.pop(context);
                },
                icon: Icon(Icons.save),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.amber.shade50,
                  title: const Text(
                    'Edit your name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  content: Form(
                    key: EditKey,
                    child: TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please Edit your Name....';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          NoteName = val!;
                        });
                      },
                      controller: NameController,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "Edit file Name....",
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        labelText: "File Name",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        enabled: true,
                        prefixIcon: const Icon(Icons.edit),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        if (EditKey.currentState!.validate()) {
                          EditKey.currentState!.save();
                          NameController.clear();
                          Navigator.pop(context);
                        }
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(2),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.amber,
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        NameController.clear();
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(3),
                      ),
                      child: const Text(
                        'Cancle',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.mode_edit_outline_outlined),
          ),
        ],
        title: Text(
          NoteName,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: currentColor,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(2, 3),
                  blurRadius: 5,
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        '${dateTime.day}-${dateTime.month}-${dateTime.year}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700),
                      ),
                    ),
                  ),
                  TextField(
                    controller: titleController,
                    onChanged: (val) {
                      setState(() {
                        Title = val;
                      });
                    },
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      hintText: 'Title',
                      helperMaxLines: 2,
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, color: Colors.transparent)),
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        color: Colors.grey,
                      ),
                      enabled: true,
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SingleChildScrollView(
                    child: TextField(
                      controller: bodyController,
                      onChanged: (val) {
                        setState(() {
                          Body = val;
                        });
                      },
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      maxLines: 100,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        hintText: 'body',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        enabled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0,
                            color: Colors.transparent,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 0,
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
