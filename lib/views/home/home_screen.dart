import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:we_link_app/res/colors.dart';
import 'package:we_link_app/res/ui.dart';
import 'package:we_link_app/views/home/widgets/link.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget appBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Hello there 👋🏻",
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                "Vehan Hemsara",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://instagram.fcmb11-1.fna.fbcdn.net/v/t51.2885-19/276978157_264760199193892_6709045983454783025_n.jpg?stp=dst-jpg_s320x320&_nc_ht=instagram.fcmb11-1.fna.fbcdn.net&_nc_cat=104&_nc_ohc=SvD2rX8-G7UAX8q0ZLo&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfBE_YHCCAEYgE4MgPw7uN3tnuuhnmL64OM-guxYdeKsFQ&oe=63F8515F&_nc_sid=8fd12b'))
        ],
      ),
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
      child: Container(
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
                    "345"),
                overviewItem(
                    const Icon(
                      Iconsax.search_favorite,
                      color: Color(0xff6561C4),
                      size: 18,
                    ),
                    const Color(0xffE2E2FF),
                    "Clicks",
                    "25"),
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
                    "64.7%"),
                overviewItem(
                    const Icon(
                      Iconsax.timer,
                      color: Color(0xffE85989),
                      size: 18,
                    ),
                    const Color(0xffFEE2EC),
                    "Avg Time",
                    "9.4"),
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
                        "we.link/vhemsara",
                        style: TextStyle(
                            color: AppColors.blueColor,
                            fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        Iconsax.copy,
                        color: AppColors.blueColor,
                        size: 18,
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Iconsax.home),
            ),
            BottomNavigationBarItem(
              label: "Stats",
              icon: Icon(Iconsax.chart),
            ),
            BottomNavigationBarItem(
              label: "Edit",
              icon: Icon(Iconsax.edit),
            ),
            BottomNavigationBarItem(
              label: "Settings",
              icon: Icon(Iconsax.setting),
            ),
          ]),
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: Column(
          children: [
            appBar(),
            const SizedBox(height: 25),
            overView(context),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(25),
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
                  children: const [
                    Text(
                      "My Links",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    Link(),
                    Link(),
                    Link(),
                    Link(),
                    Link(),
                    Link(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
