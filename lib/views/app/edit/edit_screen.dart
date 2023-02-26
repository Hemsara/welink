// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';

import 'package:provider/provider.dart';
import 'package:we_link_app/models/links/link_profile.dart';
import 'package:we_link_app/models/links/style.dart';
import 'package:we_link_app/models/others/response.dart';
import 'package:we_link_app/providers/links_provider.dart';
import 'package:we_link_app/res/colors.dart';
import 'package:we_link_app/res/constants.dart';
import 'package:we_link_app/res/ui.dart';

class EditLinkProfile extends StatefulWidget {
  const EditLinkProfile({super.key});

  @override
  State<EditLinkProfile> createState() => _EditLinkProfileState();
}

class _EditLinkProfileState extends State<EditLinkProfile> {
  double _currentSliderValue = 0;
  late int selectedStyleIndex;
  late bool gradientUp;
  late bool flatColor;
  late TextEditingController _titleCTRL;
  late TextEditingController _bioCTRL;
// create some values
  late Color pickerColor;
  late Color currentColor;

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  void initState() {
    context.read<LinkProvider>().getStyles();
    setState(() {
      selectedStyleIndex = context.read<LinkProvider>().profile.style.id;
      gradientUp = context.read<LinkProvider>().profile.gradient_up;
      flatColor = context.read<LinkProvider>().profile.flatColor;
      currentColor = context.read<LinkProvider>().profile.bgColor;
      pickerColor = context.read<LinkProvider>().profile.bgColor;

      _titleCTRL = TextEditingController();
      _bioCTRL = TextEditingController();

      _titleCTRL.text = context.read<LinkProvider>().profile.profileTitle;
      _bioCTRL.text = context.read<LinkProvider>().profile.description;
    });

    super.initState();
  }

  Widget _profile() {
    return Consumer<LinkProvider>(builder: (context, val, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Profile Data",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(25)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundImage: val.profile.avatar != null
                          ? NetworkImage(
                              '${AppConstants.host}${val.profile.avatar}')
                          : null,
                      backgroundColor: val.profile.avatar == null
                          ? AppColors.blueColor.withOpacity(0.2)
                          : null,
                      radius: 50,
                      child: val.profile.avatar == null
                          ? Icon(
                              Iconsax.user,
                              color: AppColors.blueColor,
                              size: 35,
                            )
                          : null,
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () async {},
                          child: Container(
                            width: 230,
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                              color: AppColors.blueColor,
                            ),
                            child: Center(
                              child: Text(
                                "Upload Image",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 230,
                          height: 48,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                              border: Border.all(color: AppColors.blueColor)),
                          child: Center(
                            child: Text(
                              "Remove",
                              style: TextStyle(
                                  color: AppColors.blueColor,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(255, 244, 244, 244),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Profile Title",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.grey),
                      ),
                      TextField(
                        controller: _titleCTRL,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(255, 244, 244, 244),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bio",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.grey),
                      ),
                      TextField(
                        controller: _bioCTRL,
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      );
    });
  }

  Widget backgroundOption(String t, bool g) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                flatColor = g ? false : true;
              });
              print(flatColor);
            },
            child: Container(
              width: 200,
              height: 300,
              decoration: BoxDecoration(
                  gradient: g
                      ? LinearGradient(
                          begin: gradientUp
                              ? Alignment.topCenter
                              : Alignment.bottomCenter,
                          colors: [
                              pickerColor,
                              Colors.white,
                            ])
                      : null,
                  color: !g ? pickerColor : null,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Color.fromARGB(255, 234, 234, 234),
                  )),
            ),
          ),
          SizedBox(height: 6),
          Text(
            t,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _background() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Background",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(25)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Stack(
                      children: [
                        backgroundOption("Flat Color", false),
                        Positioned(
                          left: 8,
                          top: 8,
                          child: flatColor
                              ? CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 11,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Color.fromARGB(255, 255, 255, 255),
                                    radius: 10,
                                    child: Icon(
                                      Icons.done,
                                      size: 10,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        backgroundOption("Gradient", true),
                        Positioned(
                          left: 8,
                          top: 8,
                          child: !flatColor
                              ? CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 11,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Color.fromARGB(255, 255, 255, 255),
                                    radius: 10,
                                    child: Icon(
                                      Icons.done,
                                      size: 10,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              const Text(
                "Background Color",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Pick a color!'),
                          content: SingleChildScrollView(
                            child: ColorPicker(
                              pickerColor: pickerColor,
                              onColorChanged: changeColor,
                            ),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text('Got it'),
                              onPressed: () {
                                setState(() => currentColor = pickerColor);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: currentColor,
                          borderRadius: BorderRadius.circular(10)),
                      width: 50,
                      height: 50,
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromARGB(255, 244, 244, 244),
                    ),
                    child: Center(
                        child: Text(
                      "#${currentColor.toHex(withAlpha: true)}",
                      style: TextStyle(color: Colors.black45),
                    )),
                  )
                ],
              ),
              SizedBox(height: 40),
              const Text(
                "Gradient",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    gradientUp = true;
                  });
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 11,
                      backgroundColor: Colors.black87,
                      child: gradientUp
                          ? CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 5,
                            )
                          : null,
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 25,
                      height: 35,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [currentColor, Colors.white]),
                          borderRadius: BorderRadius.circular(200)),
                    ),
                    SizedBox(width: 5),
                    const Text(
                      "Gradient Up",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    gradientUp = false;
                  });
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 11,
                      backgroundColor: Colors.black87,
                      child: !gradientUp
                          ? CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 5,
                            )
                          : null,
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 25,
                      height: 35,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [currentColor, Colors.white]),
                          borderRadius: BorderRadius.circular(200)),
                    ),
                    SizedBox(width: 5),
                    const Text(
                      "Gradient down",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget styledButton(Style e) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 17, horizontal: 10),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_currentSliderValue),
          border: Border.all(color: Colors.black),
          boxShadow: e.isHardShadow
              ? [
                  BoxShadow(
                      color: Color.fromARGB(255, 0, 0, 0),
                      offset: Offset(2.8, 2.8),
                      spreadRadius: 1,
                      blurRadius: 0)
                ]
              : e.isSoftShadow
                  ? [
                      BoxShadow(
                          color: Color.fromARGB(255, 219, 219, 219),
                          offset: Offset(2.8, 2.8),
                          spreadRadius: 1,
                          blurRadius: 10)
                    ]
                  : null,
          // boxShadow: !e.isFilled
          //     ? e.isHardShadow
          //         ? [
          //             BoxShadow(
          //                 color: Color.fromARGB(255, 0, 0, 0),
          //                 offset: Offset(2.8, 2.8),
          //                 spreadRadius: 1,
          //                 blurRadius: 0)
          //           ]
          //         : null
          //     : null,
          color: e.isFilled ? Color.fromARGB(221, 0, 0, 0) : Colors.white,
        ),
        child: Text(
          e.name,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: e.isFilled ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buttons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Button Styles",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(25)),
          child: Column(
            children: context
                .watch<LinkProvider>()
                .styles
                .asMap()
                .map((i, element) => MapEntry(
                      i,
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedStyleIndex = element.id;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            styledButton(element),
                            CircleAvatar(
                              radius: 11,
                              backgroundColor: Colors.black87,
                              child: element.id == selectedStyleIndex
                                  ? CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 5,
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ))
                .values
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buttonRadius() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Button Radius",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(25)),
          child: Slider(
            inactiveColor: Colors.black.withOpacity(0.2),
            activeColor: Colors.black,
            value: _currentSliderValue,
            max: 30,
            divisions: 30,
            label: _currentSliderValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
              });
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: AppUi.scaffoldPadding,
          left: AppUi.scaffoldPadding,
          right: AppUi.scaffoldPadding),
      child: context.watch<LinkProvider>().fetching
          ? Text("Loading")
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _profile(),
                  SizedBox(height: 40),
                  _background(),
                  SizedBox(height: 40),
                  _buttons(),
                  SizedBox(height: 40),
                  _buttonRadius(),
                  SizedBox(height: 40),
                  GestureDetector(
                    onTap: () async {
                      print(flatColor);
                      await context.read<LinkProvider>().updateProfile(
                        data: {
                          LinkProfileFields.radius: _currentSliderValue,
                          LinkProfileFields.gradientUp: gradientUp,
                          LinkProfileFields.style: selectedStyleIndex,
                          LinkProfileFields.profileTitle: _titleCTRL.text,
                          LinkProfileFields.description: _bioCTRL.text,
                          LinkProfileFields.flatColor: flatColor,
                          LinkProfileFields.bgColor : currentColor.toHex(withAlpha: true)
                        },
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: Colors.white,
                          border: Border.all(color: Colors.black)),
                      child: Center(
                        child: context.watch<LinkProvider>().saving
                            ? SpinKitThreeBounce(
                                size: 15,
                                color: Colors.black,
                              )
                            : Text(
                                "Save changes",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.w700),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
    );
  }
}

extension HexColor on Color {
  String _generateAlpha({required int alpha, required bool withAlpha}) {
    if (withAlpha) {
      return alpha.toRadixString(16).padLeft(2, '0');
    } else {
      return '';
    }
  }

  String toHex({bool leadingHashSign = false, bool withAlpha = false}) =>
      '${leadingHashSign ? '#' : ''}'
              '${_generateAlpha(alpha: alpha, withAlpha: withAlpha)}'
              '${red.toRadixString(16).padLeft(2, '0')}'
              '${green.toRadixString(16).padLeft(2, '0')}'
              '${blue.toRadixString(16).padLeft(2, '0')}'
          .toUpperCase();
}
