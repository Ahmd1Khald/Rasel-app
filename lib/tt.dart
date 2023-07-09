import 'package:RASEL/Core/utils/constants/functions.dart';
import 'package:flutter/material.dart';

import 'doctor_profile.dart';

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          "Doctor List",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        actions: const [
          Icon(
            Icons.search,
            size: 25,
            color: Colors.black,
          )
        ],
      ),
      body: GridView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemBuilder: (_, index) => Card(
                elevation: 1,
                child: InkWell(
                  onTap: () {
                    AppFunctions.push(
                        context: context, screen: const DoctorProfile());
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          color: Colors.blue.withOpacity(0.1),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Image.network(
                              "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const Text("data",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          )),
                      const Text("data",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          )),
                      const Text(
                        "data",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              )),
    );
  }
}
