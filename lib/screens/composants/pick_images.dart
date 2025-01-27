import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// ignore: must_be_immutable
class PickImages extends StatefulWidget {
  XFile? images;
  GestureTapCallback onPicked;
  String name;

  PickImages(
      {super.key,
      required this.images,
      required this.onPicked,
      required this.name});

  @override
  State<PickImages> createState() => _PickImagesState();
}

class _PickImagesState extends State<PickImages> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.images == null)
          GestureDetector(
            //widget.onPicked
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => Padding(
                        padding: EdgeInsets.all(16),
                        child: ShadDialog.alert(
                          title: Text("Choisir la source"),
                          description: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              "Vous devez choisir si la source est la galerie ou la camera",
                            ),
                          ),
                          actions: [
                            ShadButton(
                                child: const Text('Galerie'),
                                onPressed: (){
                                  widget.onPicked();
                                  Navigator.pop(context);
                                }),
                            ShadButton(
                                child: const Text('Camera'),
                                onPressed: () async {
                                  widget.onPicked();
                                  Navigator.pop(context);
                                }),
                          ],
                        ),
                      ));
            },
            child: Container(
                // width: 200,
                //  / height: 25,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: const Color.fromARGB(255, 220, 220, 220),
                    border: Border.all(width: 0.001, color: Colors.grey)),
                child: Padding(
                  padding: EdgeInsets.only(left: 16.00),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.add),
                      Expanded(
                          child: Text(
                        widget.name,
                        style: theme.titleMedium,
                      ))
                    ],
                  ),
                )),
          ),
        widget.images == null
            ? Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Aucune photo selectionée",
                      style: GoogleFonts.lato(
                          color: Colors.red,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ],
                ))
            : Padding(
                padding: const EdgeInsets.all(16.00),
                child: Stack(
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.file(
                          fit: BoxFit.cover, File(widget.images!.path)),
                    ),
                    Positioned(
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                widget.images = null;
                              });
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.red,
                            )))
                  ],
                )),
      ],
    );
  }
}
