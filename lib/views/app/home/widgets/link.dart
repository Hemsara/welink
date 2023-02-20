// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:we_link_app/models/links/link.dart';

class Link extends StatelessWidget {
  final LinkModel link;

  const Link({super.key, required this.link});

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
                  child: link.icon.isEmpty
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
                                  image: NetworkImage(
                                      'http://127.0.0.1:8000${link.icon}'),
                                  fit: BoxFit.cover)),
                        ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      link.label,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    Text(
                      link.href,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              CupertinoIcons.ellipsis_vertical,
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}
