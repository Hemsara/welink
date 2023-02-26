// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:we_link_app/models/others/response.dart';
import 'package:we_link_app/providers/links_provider.dart';
import 'package:we_link_app/res/ui.dart';
import 'package:we_link_app/views/components/textfield.dart';

class AddLinkScreen extends StatefulWidget {
  const AddLinkScreen({super.key});

  @override
  State<AddLinkScreen> createState() => _AddLinkScreenState();
}

class _AddLinkScreenState extends State<AddLinkScreen> {
  late TextEditingController _titleCTRL;
  late TextEditingController _linkCTRL;
  String? iconURL = null;

  @override
  void initState() {
    _linkCTRL = TextEditingController();
    _titleCTRL = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Text(
          "Add New Link",
          style: TextStyle(fontSize: 17),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppUi.scaffoldPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    "Title of the link",
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
                    "URL",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.grey),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              iconURL = null;
                            });
                          },
                          controller: _linkCTRL,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            String result = _linkCTRL.text.substring(
                                _linkCTRL.text.indexOf('.') + 1,
                                _linkCTRL.text.indexOf('m/') + 1);

                            iconURL = "https://icon.horse/icon/${result}";
                          });
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromARGB(255, 225, 225, 225),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: iconURL != null
                                ? Image(
                                    image: NetworkImage(iconURL!),
                                    width: 22,
                                    height: 22,
                                  )
                                : Icon(
                                    Iconsax.image,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () async {
                Response res =
                    await context.read<LinkProvider>().saveLink(data: {
                  'label': _titleCTRL.text,
                  'href': _linkCTRL.text,
                  'icon': iconURL,
                  'profile': context.read<LinkProvider>().profile.id
                });
                if (res.status == ResponseStatus.success) {
                  Navigator.pop(context);
                }
              },
              child: Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(color: Colors.black)),
                child: Center(
                  child: context.watch<LinkProvider>().saving
                      ? SpinKitThreeBounce(
                          size: 15,
                          color: Colors.black,
                        )
                      : Text(
                          "Save Link",
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w700),
                        ),
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _icon(String? url) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromARGB(255, 225, 225, 225),
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: url != null
            ? Image(
                image: NetworkImage(iconURL!),
                width: 22,
                height: 22,
              )
            : SizedBox(),
      ),
    );
  }
}
