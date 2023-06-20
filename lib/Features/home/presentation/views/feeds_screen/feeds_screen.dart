import 'package:RASEL/Core/utils/constants/assets_images.dart';
import 'package:RASEL/Core/utils/constants/styles.dart';
import 'package:RASEL/Features/home/presentation/views/feeds_screen/widgets/cover.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../Core/utils/constants/colors.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CoverImage(),
          SizedBox(
            //height: double.infinity,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => buildPostItem(),
              separatorBuilder: (context, index) => SizedBox(
                height: 4.h,
              ),
              itemCount: 10,
            ),
          )
        ],
      ),
    );
  }
}

Widget buildPostItem() => Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 28.sp,
                    backgroundColor: AppColors.splashBackgroundColor,
                    child: Image.asset(AppAssetsImages.logoImage),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Ahmed Khaled',
                            style: AppStyles.postUserName,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 20.sp,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        'Aug 29, 2000 at 11:00 pm',
                        style: AppStyles.postDate,
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  color: AppColors.deepGrey,
                ),
              ),
              Text(
                "The club was first headed by Alfred Mitchell-Innes, who was a British advisor to the Ministry of Finance at the time, in order to facilitate financial support for the club. An official meeting of the club's board was held on 24 April 1907. The committee met at 5:30 pm in the house of Mitchell-Innes in Giza under his chairmanship and the membership of Idris Ragheb Bey, Ismael Seri Pasha, Amin Sami Pasha, Omar Lotfi Bek and Mohamed Effendi Sherif as secretary.",
                style: AppStyles.postText,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      SizedBox(
                        height: 20.h,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#software',
                            style: AppStyles.postTages,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#software',
                            style: AppStyles.postTages,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#software',
                            style: AppStyles.postTages,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#software',
                            style: AppStyles.postTages,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#software_developing',
                            style: AppStyles.postTages,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 150.h,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(
                      'https://img.freepik.com/free-photo/social-media-concept-with-smartphone_52683-100042.jpg?w=1060&t=st=1686660783~exp=1686661383~hmac=b2aa9ec45ef19106a03a6db3465cca57af29e35c66c964389876d4f4e84fb20e'),
                  fit: BoxFit.cover,
                )),
              ),
              Row(
//mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      ///todo like button
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            size: 18.sp,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          const Text('100'),
                        ],
                      ),
                    ),
                  )),
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      ///todo comment button
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            FontAwesomeIcons.comment,
                            size: 18.sp,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          const Text('100 Comments'),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8,
                ),
                child: Divider(
                  color: AppColors.deepGrey,
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 17.sp,
                    backgroundColor: AppColors.splashBackgroundColor,
                    child: Image.asset(AppAssetsImages.logoImage),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    'Write a comment...',
                    style: AppStyles.postDate,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.favorite_border,
                        size: 18.sp,
                        color: Colors.red,
                      )),
                  const Text('Like'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
