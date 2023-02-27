// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:we_link_app/models/others/response.dart';
import 'package:we_link_app/providers/links_provider.dart';
import 'package:we_link_app/res/colors.dart';
import 'package:we_link_app/res/constants.dart';
import 'package:we_link_app/res/ui.dart';
import 'package:we_link_app/views/app/home/widgets/link.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<LinkProvider>().getOverview();

    super.initState();
  }

  Widget appBar() {
    return Padding(
      padding: EdgeInsets.all(AppUi.scaffoldPadding),
      child: Consumer<LinkProvider>(builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Hello there 👋🏻",
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  "${value.profile.user.firstName} ${value.profile.user.lastName}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            PopupMenuButton(
              icon: CircleAvatar(
                  backgroundColor: AppColors.blueColor.withOpacity(0.1),
                  backgroundImage: value.profile.avatar != null
                      ? NetworkImage(
                          '${AppConstants.host}${value.profile.avatar}')
                      : null,
                  child: value.profile.avatar == null
                      ? Icon(
                          Iconsax.user,
                          size: 17,
                        )
                      : null),
              elevation: 0.2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              onSelected: (value) {},
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    onTap: () async {
                      final storage = FlutterSecureStorage();
                      await storage.deleteAll();
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    value: 'Home',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'LogOut',
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Iconsax.logout,
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
                      children: const [
                        Text(
                          'Settings',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Iconsax.setting,
                          size: 16,
                          color: Colors.redAccent,
                        )
                      ],
                    ),
                  ),
                ];
              },
            ),
          ],
        );
      }),
    );
  }

  Widget overviewItem(Icon icon, Color color, String title, String value) {
    return SizedBox(
      width: 130,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            child: icon,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style:
                    const TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
              ),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget overView(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppUi.scaffoldPadding),
      child: Consumer<LinkProvider>(
        builder: (context, value, child) {
          return Container(
            padding: const EdgeInsets.all(25),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(25)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    overviewItem(
                        const Icon(
                          Iconsax.eye,
                          color: Color(0xff07ADF3),
                          size: 18,
                        ),
                        const Color(0xffDEF5FF),
                        "Total Views",
                        value.profile.views.toString()),
                    overviewItem(
                        const Icon(
                          Iconsax.search_favorite,
                          color: Color(0xff6561C4),
                          size: 18,
                        ),
                        const Color(0xffE2E2FF),
                        "Clicks",
                        value.profile.clicks.toString()),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    overviewItem(
                        const Icon(
                          Iconsax.chart,
                          size: 18,
                          color: Color(0xff70C98F),
                        ),
                        const Color(0xFFE2FEE9),
                        "Avg CTR",
                        "${((value.profile.clicks / value.profile.views) * 100 > 0 ? (value.profile.clicks / value.profile.views) * 100 : 0).toStringAsFixed(1)}%"),
                    overviewItem(
                        const Icon(
                          Iconsax.timer,
                          color: Color(0xffE85989),
                          size: 18,
                        ),
                        const Color(0xffFEE2EC),
                        "Avg Time",
                        "0.0"),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: 43,
                      decoration: BoxDecoration(
                          color: AppColors.blueColor.withOpacity(0.07),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${AppConstants.host}/${value.profile.user.username}",
                            style: TextStyle(
                                color: AppColors.blueColor,
                                fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await Clipboard.setData(ClipboardData(
                                text:
                                    "http://localhost:3000/${value.profile.user.username}",
                              ));

                              final snackBar = SnackBar(
                                backgroundColor:
                                    Color.fromARGB(255, 242, 242, 242),
                                content: const Text(
                                  'Copied to clipboard🔥',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 76, 75, 75)),
                                ),
                                // Some code to undo the change.
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            child: Icon(
                              Iconsax.copy,
                              color: AppColors.blueColor,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.blueColor,
                          borderRadius: BorderRadius.circular(10)),
                      height: 43,
                      width: 43,
                      child: const Center(
                        child: Icon(
                          Iconsax.eye,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<LinkProvider>().fetching
        ? const Center(child: Text("Loading.."))
        : Column(
            children: [
              appBar(),
              const SizedBox(height: 25),
              overView(context),
              const Spacer(),
              Container(
                padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                height: 400,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "My Links",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      Consumer<LinkProvider>(
                        builder: (context, value, child) {
                          return Column(
                            children: value.profile.links
                                .map((e) => Link(link: e))
                                .toList(),
                          );
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          );
  }
}
