
import 'package:ai_image_generator/api_servics.dart';
import 'package:ai_image_generator/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var sizes = ["Small", "Medium", "Large"];
  var values = ["256x256", "512x512", "1024x1024"];
  String? dropValue;
  var textController = TextEditingController();
  String image = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "AI Image Generator",
          style: TextStyle(
            fontFamily: "poppins_bold",
            color: whiterColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 44,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: whiterColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextFormField(
                              controller: textController,
                              decoration: InputDecoration(
                                  hintText: "eg 'A monkey on moon' ",
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          height: 44,
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: whiterColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              icon: Icon(Icons.expand_more, color: btnColor),
                              value: dropValue,
                              hint: const Text("Select size"),
                              items: List.generate(
                                  sizes.length,
                                      (index) => DropdownMenuItem(
                                    child: Text(
                                      sizes[index],
                                    ),
                                    value: values[index],
                                  )),
                              onChanged: (value) {
                                setState(() {
                                  dropValue = value.toString();
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                        width: 300,
                        height: 44,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: btnColor,
                              shape: const StadiumBorder()),
                          onPressed: () async {
                            if (textController.text.isNotEmpty &&
                                dropValue!.isNotEmpty) {
                              image = await Api.generateImage(
                                  textController.text, dropValue!);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Please pass the text query and select size"),
                                ),
                              );
                            }
                          },
                          child: Text(
                            "Generate",
                          ),
                        ))
                  ])),
          Expanded(
              flex: 4,
              child: Container(
                color: Colors.amber,
              ))
        ]),
      ),
    );
  }
}