// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:iconsax/iconsax.dart';
import 'package:we_link_app/models/links/link.dart';

class DetailedLinkView extends StatefulWidget {
  final LinkModel link;

  const DetailedLinkView({super.key, required this.link});

  @override
  State<DetailedLinkView> createState() => _DetailedLinkViewState();
}

class _DetailedLinkViewState extends State<DetailedLinkView> {
  late bool switchValue;

  @override
  void initState() {
    setState(() {
      switchValue = widget.link.visible;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Row(
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
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
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
                // PopupMenuButton(
                //   icon: Icon(
                //     CupertinoIcons.ellipsis_vertical,
                //     size: 16,
                //     color: Colors.grey.withOpacity(0.5),
                //   ),
                //   elevation: 0.2,
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(15)),
                //   onSelected: (value) {},
                //   itemBuilder: (context) {
                //     return [
                //       PopupMenuItem(
                //         value: 'Home',
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Text(
                //               'Add to WeLink',
                //               style: TextStyle(
                //                   color: Colors.black45,
                //                   fontSize: 13,
                //                   fontWeight: FontWeight.w500),
                //             ),
                //             Transform.scale(
                //               scale: 0.75,
                //               child: CupertinoSwitch(
                //                 value: switchValue,
                //                 activeColor: CupertinoColors.activeGreen,
                //                 onChanged: (bool? value) {
                //                   setState(() {
                //                     switchValue = value ?? false;
                //                   });
                //                 },
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       PopupMenuItem(
                //         value: 'Home',
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Text(
                //               'Edit Link',
                //               style: TextStyle(
                //                   color: Colors.black45,
                //                   fontSize: 13,
                //                   fontWeight: FontWeight.w500),
                //             ),
                //             Icon(
                //               Iconsax.edit,
                //               size: 16,
                //               color: Colors.black45,
                //             )
                //           ],
                //         ),
                //       ),
                //       PopupMenuItem(
                //         value: 'Home',
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Text(
                //               'Delete Link',
                //               style: TextStyle(
                //                   color: Colors.redAccent,
                //                   fontSize: 13,
                //                   fontWeight: FontWeight.w500),
                //             ),
                //             Icon(
                //               Iconsax.trash,
                //               size: 16,
                //               color: Colors.redAccent,
                //             )
                //           ],
                //         ),
                //       ),
                //     ];
                //   },
                // )
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.hand_draw,
                      color: Colors.grey,
                      size: 17,
                    ),
                    SizedBox(width: 2),
                    Text(
                      widget.link.clicks.toString(),
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.greenAccent.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Iconsax.edit,
                              color: Colors.green,
                              size: 17,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Edit",
                              style: TextStyle(color: Colors.green),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.redAccent.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Iconsax.trash,
                              color: Colors.redAccent,
                              size: 17,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Delete",
                              style: TextStyle(color: Colors.redAccent),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
