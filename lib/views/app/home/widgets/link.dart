// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:we_link_app/models/links/link.dart';

class Link extends StatefulWidget {
  final LinkModel link;

  const Link({super.key, required this.link});

  @override
  State<Link> createState() => _LinkState();
}

class _LinkState extends State<Link> {
  late bool switchValue;

  @override
  void initState() {
    switchValue = widget.link.visible;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 80,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 222, 222, 222),
                spreadRadius: -5,
                blurRadius: 10),
          ],
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 247, 247, 247),
                  child: widget.link.icon.isEmpty
                      ? Icon(
                          Iconsax.image,
                          size: 15,
                          color: Colors.grey,
                        )
                      : Container(
                          width: 17,
                          height: 17,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              image: DecorationImage(
                                  image: NetworkImage(widget.link.icon),
                                  fit: BoxFit.cover)),
                        ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.link.label,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                    Text(
                      widget.link.href.split("").length < 35
                          ? widget.link.href
                          : "${widget.link.href.substring(0, 35)}...",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            PopupMenuButton(
              icon: Icon(
                CupertinoIcons.ellipsis_vertical,
                size: 16,
                color: Colors.grey.withOpacity(0.5),
              ),
              elevation: 0.2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              onSelected: (value) {},
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 'Home',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add to WeLink',
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                        Transform.scale(
                          scale: 0.75,
                          child: CupertinoSwitch(
                            value: switchValue,
                            activeColor: CupertinoColors.activeGreen,
                            onChanged: (bool? value) {
                              setState(() {
                                switchValue = value ?? false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'Home',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Edit Link',
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Iconsax.edit,
                          size: 16,
                          color: Colors.black45,
                        )
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'Home',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delete Link',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Iconsax.trash,
                          size: 16,
                          color: Colors.redAccent,
                        )
                      ],
                    ),
                  ),
                ];
              },
            )
          ],
        ),
      ),
    );
  }
}
