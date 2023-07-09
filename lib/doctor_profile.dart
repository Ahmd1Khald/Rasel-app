import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Core/utils/constants/colors.dart';
import 'Core/utils/constants/network_images.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({Key? key}) : super(key: key);

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  bool isFav = false;
  void toggleFav() {
    setState(() {
      isFav = !isFav;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.blue,
        child: IconButton(
            onPressed: () {
              toggleFav();
            },
            icon: Icon(
              Icons.favorite,
              size: 30,
              color: isFav == true ? Colors.red : Colors.white,
            )),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 290,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(8),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      width: double.infinity,
                      imageUrl: AppNetworksImages.coverImage,
                      // Replace with your image URL
                      placeholder: (context, url) => LinearProgressIndicator(
                        color: AppColors.lightGrey,
                        backgroundColor: AppColors.sidesColor,
                      ),
                      // Optional: Show a placeholder while loading
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(Icons.error),
                      ), // Optional: Show an error icon if the image fails to load
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: CircleAvatar(
                    radius: 64,
                    backgroundColor: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: 118,
                        height: 113,
                        imageUrl: AppNetworksImages.coverImage,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(
                          color: AppColors.lightGrey,
                        ),
                        // Optional: Show a placeholder while loading
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 350,
            child: Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Text(
                'Doctor Name',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.manrope(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          SizedBox(
            width: 350,
            child: Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Text(
                'Doctor Address',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.manrope(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          SizedBox(
            width: 350,
            child: Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Text(
                'Another Info',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.manrope(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 40.0, bottom: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Specialize',
                      style: GoogleFonts.manrope(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'doc specialize',
                      style: GoogleFonts.manrope(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: 35,
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Phone',
                      style: GoogleFonts.manrope(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '+201061748098',
                      style: GoogleFonts.manrope(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 35,
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'Price',
                      style: GoogleFonts.manrope(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '120\$',
                      style: GoogleFonts.manrope(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.lightGrey),
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: MaterialButton(
                onPressed: () {},
                child: Text(
                  'Order Now !',
                  style: GoogleFonts.manrope(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
