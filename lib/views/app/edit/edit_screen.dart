// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:provider/provider.dart';
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
                      backgroundColor: val.profile.avatar != null
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
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: val.profile.profileTitle),
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
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: val.profile.description,
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

  Widget backgroundOption() {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Container(
            width: 200,
            height: 300,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Color.fromARGB(255, 234, 234, 234))),
          ),
          SizedBox(height: 6),
          const Text(
            "Flat Color",
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
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    backgroundOption(),
                    backgroundOption(),
                    backgroundOption(),
                  ],
                ),
                SizedBox(height: 40),
                const Text(
                  "Background Color",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)),
                      width: 50,
                      height: 50,
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
                        "#FFFFFF",
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
                Row(
                  children: [
                    CircleAvatar(
                      radius: 11,
                      backgroundColor: Colors.black87,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 5,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 25,
                      height: 35,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black45, Colors.white]),
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
                SizedBox(height: 10),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 11,
                      backgroundColor: Colors.black87,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 5,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 25,
                      height: 35,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Colors.black45, Colors.white]),
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
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget styledButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(color: Colors.black87),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Fill",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                  SizedBox(height: 5),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        styledButton(),
                        styledButton(),
                        styledButton(),
                        styledButton(),
                        styledButton(),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Fill",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                  SizedBox(height: 5),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        styledButton(),
                        styledButton(),
                        styledButton(),
                        styledButton(),
                        styledButton(),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Fill",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                  SizedBox(height: 5),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        styledButton(),
                        styledButton(),
                        styledButton(),
                        styledButton(),
                        styledButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _profile(),
            SizedBox(height: 40),
            _background(),
            SizedBox(height: 40),
            _buttons(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
