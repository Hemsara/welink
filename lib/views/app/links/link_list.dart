// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:we_link_app/providers/links_provider.dart';
import 'package:we_link_app/res/colors.dart';
import 'package:we_link_app/res/ui.dart';

import 'package:we_link_app/views/app/links/widgets/detaild_link_view.dart';

class LinkListScreen extends StatefulWidget {
  const LinkListScreen({super.key});

  @override
  State<LinkListScreen> createState() => _LinkListScreenState();
}

class _LinkListScreenState extends State<LinkListScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppUi.scaffoldPadding),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.blueColor,
          child: Icon(Iconsax.add),
          onPressed: () => Navigator.pushNamed(context, '/add'),
        ),
        backgroundColor: AppColors.scaffoldColor,
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Manage your links",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Consumer<LinkProvider>(
              builder: (context, value, child) {
                return Column(
                  children: value.profile.links
                      .map((e) => DetailedLinkView(link: e))
                      .toList(),
                );
              },
            )
          ],
        )),
      ),
    );
  }
}
