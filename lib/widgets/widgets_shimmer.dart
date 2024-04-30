import 'package:anchorageislamabad/widgets/skeleton.dart';
import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../core/utils/color_constant.dart';
import '../core/utils/responsive.dart';
import '../core/utils/size_utils.dart';
import 'NoRecordFound.dart';

Widget ShimmerTimeLogTile(context) {
  Responsive responsive = Responsive();
  responsive.setContext(context);
  return Container(
    width: responsive.setWidth(100),
    height: responsive.setHeight(100),
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 170.0, height: 180.0, child: Skeleton()),
              SizedBox(width: 170.0, height: 180.0, child: Skeleton()),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 170.0, height: 170.0, child: Skeleton()),
              SizedBox(width: 170.0, height: 170.0, child: Skeleton()),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget ShimmerRetaltedTile(context) {
  Responsive responsive = Responsive();
  responsive.setContext(context);
  return Container(
    width: responsive.setWidth(100),
    height: responsive.setHeight(100),
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 160.0, height: 150.0, child: Skeleton()),
              SizedBox(width: 160.0, height: 150.0, child: Skeleton()),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget ShimmerAlertHistory(context) {
  Responsive responsive = Responsive();
  responsive.setContext(context);
  return Container(
    width: responsive.setWidth(100),
    height: responsive.setHeight(100),
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 120.0, height: 20.0, child: Skeleton()),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 160.0, height: 20.0, child: Skeleton()),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(width: 145.0, height: 20.0, child: Skeleton()),
                    ],
                  ),
                  SizedBox(
                      height: 40,
                      child: VerticalDivider(
                        width: 5,
                        thickness: 2,
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 70.0, height: 20.0, child: Skeleton()),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(width: 145.0, height: 20.0, child: Skeleton()),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ],
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 120.0, height: 20.0, child: Skeleton()),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 160.0, height: 20.0, child: Skeleton()),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(width: 145.0, height: 20.0, child: Skeleton()),
                    ],
                  ),
                  SizedBox(
                      height: 40,
                      child: VerticalDivider(
                        width: 5,
                        thickness: 2,
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 70.0, height: 20.0, child: Skeleton()),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(width: 145.0, height: 20.0, child: Skeleton()),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ],
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 120.0, height: 20.0, child: Skeleton()),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 160.0, height: 20.0, child: Skeleton()),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(width: 145.0, height: 20.0, child: Skeleton()),
                    ],
                  ),
                  SizedBox(
                      height: 40,
                      child: VerticalDivider(
                        width: 5,
                        thickness: 2,
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 70.0, height: 20.0, child: Skeleton()),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(width: 145.0, height: 20.0, child: Skeleton()),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ],
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 120.0, height: 20.0, child: Skeleton()),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 160.0, height: 20.0, child: Skeleton()),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(width: 145.0, height: 20.0, child: Skeleton()),
                    ],
                  ),
                  SizedBox(
                      height: 40,
                      child: VerticalDivider(
                        width: 5,
                        thickness: 2,
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 70.0, height: 20.0, child: Skeleton()),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(width: 145.0, height: 20.0, child: Skeleton()),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ],
          ),
        ),
        Divider(),
      ],
    ),
  );
}

Widget faqsSkeleton() {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 20.0,
                          height: 25.0,
                          child: Skeleton(),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 120.0,
                          height: 25.0,
                          child: Skeleton(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              SizedBox(
                width: 20.0,
                height: 15.0,
                child: Skeleton(),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
            height: getVerticalSize(1.00),
            width: size.width,
            decoration:
            BoxDecoration(color: ColorConstant.gray600)),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 20.0,
                          height: 25.0,
                          child: Skeleton(),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 120.0,
                          height: 25.0,
                          child: Skeleton(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              SizedBox(
                width: 20.0,
                height: 15.0,
                child: Skeleton(),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
            height: getVerticalSize(1.00),
            width: size.width,
            decoration:
            BoxDecoration(color: ColorConstant.gray600)),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 20.0,
                          height: 25.0,
                          child: Skeleton(),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 120.0,
                          height: 25.0,
                          child: Skeleton(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              SizedBox(
                width: 20.0,
                height: 15.0,
                child: Skeleton(),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
            height: getVerticalSize(1.00),
            width: size.width,
            decoration:
            BoxDecoration(color: ColorConstant.gray600)),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 20.0,
                          height: 25.0,
                          child: Skeleton(),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 120.0,
                          height: 25.0,
                          child: Skeleton(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              SizedBox(
                width: 20.0,
                height: 15.0,
                child: Skeleton(),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget menuSkeleton() {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 60,
              width: 60,
              child: Skeleton(
              cornerRadius: 50,
              )
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 50.0,
                    height: 15.0,
                    child: Skeleton(),
                  ),

                  Padding(
                    padding: getPadding(
                      top: 4,
                    ),
                    child: SizedBox(
                      width: 40.0,
                      height: 15.0,
                      child: Skeleton(),
                    ),
                  ),

                  Padding(
                    padding: getPadding(
                      top: 4,
                    ),
                    child: SizedBox(
                      width: 30.0,
                      height: 15.0,
                      child: Skeleton(),
                    ),

                  ),
                ],
              ),
            ),
          ],
        ),
      )
    ],
  );
}

Widget reservationsSkeleton() {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 20.0,
                          height: 25.0,
                          child: Skeleton(),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 120.0,
                          height: 25.0,
                          child: Skeleton(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              SizedBox(
                width: 20.0,
                height: 15.0,
                child: Skeleton(),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
            height: getVerticalSize(1.00),
            width: size.width,
            decoration:
            BoxDecoration(color: ColorConstant.gray600)),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 20.0,
                          height: 25.0,
                          child: Skeleton(),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 120.0,
                          height: 25.0,
                          child: Skeleton(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              SizedBox(
                width: 20.0,
                height: 15.0,
                child: Skeleton(),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
            height: getVerticalSize(1.00),
            width: size.width,
            decoration:
            BoxDecoration(color: ColorConstant.gray600)),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 20.0,
                          height: 25.0,
                          child: Skeleton(),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 120.0,
                          height: 25.0,
                          child: Skeleton(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              SizedBox(
                width: 20.0,
                height: 15.0,
                child: Skeleton(),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
            height: getVerticalSize(1.00),
            width: size.width,
            decoration:
            BoxDecoration(color: ColorConstant.gray600)),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 20.0,
                          height: 25.0,
                          child: Skeleton(),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 120.0,
                          height: 25.0,
                          child: Skeleton(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              SizedBox(
                width: 20.0,
                height: 15.0,
                child: Skeleton(),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget userTileSkeleton() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 40.0,
                height: 40.0,
                child: Skeleton(),
              ),
              const SizedBox(
                width: 10.0,
              ),
              SizedBox(
                width: 200.0,
                height: 20.0,
                child: Skeleton(),
              ),
            ],
          ),
        ),
        Container(
          height: 0.5,
          color: ColorConstant.appDescriptionTextColor,
        ),
      ],
    ),
  );
}

Widget shimmerHomePagesTile(context) {
  Responsive responsive = Responsive();
  responsive.setContext(context);
  return Container(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: responsive.setWidth(40), height: 30.0, child: Skeleton()),
        SizedBox(
          height: responsive.setHeight(2),
        ),
        Divider(),
        Container(
            width: responsive.setWidth(100),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                            width: responsive.setWidth(6),
                            height: responsive.setHeight(3),
                            child: Skeleton(
                              cornerRadius: 100,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            width: responsive.setWidth(20),
                            height: 20.0,
                            child: Skeleton()),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                            width: responsive.setWidth(7),
                            height: responsive.setHeight(3),
                            child: Skeleton(
                              cornerRadius: 2,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            width: responsive.setWidth(15),
                            height: 20.0,
                            child: Skeleton()),
                      ],
                    ),
                    SizedBox(
                      height: responsive.setHeight(2),
                    ),
                    Container(
                      width: responsive.setWidth(90),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: responsive.setWidth(10),
                                  height: responsive.setHeight(5),
                                  child: Skeleton(
                                    cornerRadius: 5,
                                  )),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      width: responsive.setWidth(40),
                                      height: 20.0,
                                      child: Skeleton()),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      width: responsive.setWidth(20),
                                      height: 15.0,
                                      child: Skeleton()),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      width: responsive.setWidth(50),
                                      height: 15.0,
                                      child: Skeleton()),
                                ],
                              ),
                            ],
                          ),
                          Container(
                              width: responsive.setWidth(13),
                              height: responsive.setHeight(6.5),
                              child: Skeleton(
                                cornerRadius: 100,
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )),
        Divider(),
        SizedBox(
          height: responsive.setHeight(1),
        ),
        Divider(),
        Center(
          child: Container(
              width: responsive.setWidth(80), height: 50.0, child: Skeleton()),
        ),
        Divider(),
        SizedBox(
          height: responsive.setHeight(1),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: responsive.setWidth(40),
                height: 25.0,
                child: Skeleton()),
            SizedBox(
              width: responsive.setWidth(3),
            ),
            Container(
                width: responsive.setWidth(30),
                height: 20.0,
                child: Skeleton()),
          ],
        ),
        SizedBox(
          height: responsive.setHeight(1),
        ),
        Divider(),
        Container(
          width: responsive.setWidth(90),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: responsive.setWidth(10),
                  height: responsive.setHeight(5),
                  child: Skeleton(
                    cornerRadius: 5,
                  )),
              SizedBox(
                width: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: responsive.setWidth(30),
                      height: 20.0,
                      child: Skeleton()),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      width: responsive.setWidth(50),
                      height: 15.0,
                      child: Skeleton()),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      width: responsive.setWidth(70),
                      height: 15.0,
                      child: Skeleton()),
                ],
              ),
            ],
          ),
        ),
        Divider(),
        Container(
          width: responsive.setWidth(90),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: responsive.setWidth(10),
                  height: responsive.setHeight(5),
                  child: Skeleton(
                    cornerRadius: 5,
                  )),
              SizedBox(
                width: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: responsive.setWidth(30),
                      height: 20.0,
                      child: Skeleton()),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      width: responsive.setWidth(50),
                      height: 15.0,
                      child: Skeleton()),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      width: responsive.setWidth(70),
                      height: 15.0,
                      child: Skeleton()),
                ],
              ),
            ],
          ),
        ),
        Divider(),
      ],
    ),
  );
}

Widget shimmerRestaurantProfile(context,index) {
  Responsive responsive = Responsive();
  responsive.setContext(context);
  return Container(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: responsive.setHeight(1),
        ),
        Container(
          width: responsive.setWidth(100),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: responsive.setWidth(15),
                        height: 15.0,
                        child: Skeleton()),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        width: responsive.setHeight(10),
                        height: responsive.setHeight(10),
                        child: Skeleton(
                          cornerRadius: 40,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        width: responsive.setWidth(15),
                        height: 15.0,
                        child: Skeleton()),
                  ],
                ),
                SizedBox(
                  height: responsive.setHeight(1),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: responsive.setHeight(2),
        ),
        Container(
            width: responsive.setWidth(50),
            height: 15.0,
            child: Skeleton()),
        SizedBox(
          height: responsive.setHeight(1),
        ),
        Container(
            width: responsive.setWidth(40),
            height: 15.0,
            child: Skeleton()),
        SizedBox(
          height: responsive.setHeight(3),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: responsive.setWidth(30), height: 25.0, child: Skeleton()),
            SizedBox(
              width: 10,
            ),
            Container(
                width: responsive.setWidth(8), height: 25.0, child: Skeleton()),
            SizedBox(
              width: 10,
            ),
            Container(
                width: responsive.setWidth(8), height: 25.0, child: Skeleton()),
            SizedBox(
              width: 10,
            ),
            Container(
                width: responsive.setWidth(8), height: 25.0, child: Skeleton()),
          ],
        ),
      ],
    ),
  );
}
Widget shimmerRestaurantProfile1(context,index) {
  Responsive responsive = Responsive();
  responsive.setContext(context);
  return Container(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: responsive.setHeight(200),

        ),

      ],
    ),
  );
}



Widget shimmerTermsAndPolicy(context) {
  Responsive responsive = Responsive();
  responsive.setContext(context);
  return Container(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(width: double.maxFinite, height: 20.0, child: Skeleton()),
        SizedBox(
          height: responsive.setHeight(0.5),
        ),
        Container(width: double.maxFinite, height: 20.0, child: Skeleton()),
        SizedBox(
          height: responsive.setHeight(0.5),
        ),
        Container(width: double.maxFinite, height: 20.0, child: Skeleton()),
        SizedBox(
          height: responsive.setHeight(0.5),
        ),
        Container(
            width: responsive.setWidth(40), height: 20.0, child: Skeleton()),
        SizedBox(
          height: responsive.setHeight(0.5),
        ),
        Container(width: double.maxFinite, height: 20.0, child: Skeleton()),
        SizedBox(
          height: responsive.setHeight(0.5),
        ),
        Container(width: double.maxFinite, height: 20.0, child: Skeleton()),
        SizedBox(
          height: responsive.setHeight(0.5),
        ),
        Container(
            width: responsive.setWidth(50), height: 20.0, child: Skeleton()),
        SizedBox(
          height: responsive.setHeight(0.5),
        ),
        Container(width: double.maxFinite, height: 20.0, child: Skeleton()),
        SizedBox(
          height: responsive.setHeight(0.5),
        ),
        Container(width: double.maxFinite, height: 20.0, child: Skeleton()),
        SizedBox(
          height: responsive.setHeight(0.5),
        ),
        Container(width: double.maxFinite, height: 15.0, child: Skeleton()),
        SizedBox(
          height: responsive.setHeight(0.5),
        ),
        Container(width: double.maxFinite, height: 20.0, child: Skeleton()),
        SizedBox(
          height: responsive.setHeight(0.5),
        ),
        Container(width: double.maxFinite, height: 20.0, child: Skeleton()),
        SizedBox(
          height: responsive.setHeight(0.5),
        ),
        Container(width: double.maxFinite, height: 20.0, child: Skeleton()),
        SizedBox(
          height: responsive.setHeight(0.5),
        ),
        Container(
            width: responsive.setWidth(40), height: 20.0, child: Skeleton()),
        SizedBox(
          height: responsive.setHeight(0.5),
        ),
        Container(width: double.maxFinite, height: 20.0, child: Skeleton()),
        SizedBox(
          height: responsive.setHeight(0.5),
        ),
        Container(width: double.maxFinite, height: 20.0, child: Skeleton()),
        SizedBox(
          height: responsive.setHeight(0.5),
        ),
        Container(
            width: responsive.setWidth(50), height: 20.0, child: Skeleton()),
        SizedBox(
          height: responsive.setHeight(0.5),
        ),
        Container(width: double.maxFinite, height: 20.0, child: Skeleton()),
        SizedBox(
          height: responsive.setHeight(0.5),
        ),
        Container(width: double.maxFinite, height: 20.0, child: Skeleton()),
        SizedBox(
          height: responsive.setHeight(0.5),
        ),
        Container(width: double.maxFinite, height: 15.0, child: Skeleton()),
      ],
    ),
  );
}





Widget shimmerFolders(context) {
  Responsive responsive = Responsive();
  responsive.setContext(context);
  return GridView.builder(
    itemCount: 6,
    padding: EdgeInsets.symmetric(horizontal: 10.0),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 12/15
    ),
    itemBuilder: (context, index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: responsive.setHeight(0.5),),
          Expanded(
            child: SizedBox(
              // height: size.height,
              width: double.maxFinite,
              child: Skeleton(),
            ),
          ),
          SizedBox(height: responsive.setHeight(0.5),),
          Container(width: 15.0, height: 15.0, child: Skeleton(cornerRadius: 3.0)),
        ],
      );
    },
  );
}

Widget shimmerCategoryFeature(context) {
  Responsive responsive = Responsive();
  responsive.setContext(context);
  return GridView.builder(
    shrinkWrap: true,
    physics: BouncingScrollPhysics(),
    itemCount: 12,
    padding: EdgeInsets.symmetric(horizontal: 10.0),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisExtent: 170,
      childAspectRatio: 5.0,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
    ),
    itemBuilder: (context, index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: responsive.setHeight(0.5),),
          Expanded(
            child: SizedBox(
              // height: size.height,
              width: double.maxFinite,
              child: Skeleton(
              ),
            ),
          ),
          SizedBox(height: responsive.setHeight(0.5),),

         // Container(width: 15.0, height: 15.0, child: Skeleton(cornerRadius: 3.0)),
        ],
      );
    },
  );
}

Widget shimmerCategoryFeatureHome(context) {
  Responsive responsive = Responsive();
  responsive.setContext(context);
  return  SizedBox(
    height: 100,
    child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 8),
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder:
            (BuildContext context, int index) {
          return Padding(
            padding:getPadding(right: 8),
            child: Container(
              width: 200,
              child: Skeleton(
              ),
            ),
          );
        }),
  );
}

Widget shimmerCategoryFeatureSelected(context) {
  Responsive responsive = Responsive();
  responsive.setContext(context);
  return  SizedBox(
    height: 50,
    child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 8),
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder:
            (BuildContext context, int index) {
          return Padding(
            padding:getPadding(right: 8),
            child: Container(
              width: 200,
              child: Skeleton(
              ),
            ),
          );
        }),
  );
}


Widget shimmerBannersHome(context) {
  Responsive responsive = Responsive();
  responsive.setContext(context);
  return  SizedBox(
    height: 200,
    child: Container(
      width: double.infinity,
     // height: 600,
      child: Skeleton(
      ),
    ),
  );
}

Widget shimmerDeals(context) {
  Responsive responsive = Responsive();
  responsive.setContext(context);
  return  Column(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.transparent, // Container background color
          borderRadius: BorderRadius.circular(10.0), // Border radius here
        ),
        width: double.infinity,
        height: getVerticalSize(100),
        child: Skeleton(
        ),
      ),
      SizedBox(height: 20,),
      Container(
        decoration: BoxDecoration(
          color: Colors.transparent, // Container background color
          borderRadius: BorderRadius.circular(10.0), // Border radius here
        ),
        width: double.infinity,
        height: getVerticalSize(100),
        child: Skeleton(
        ),
      ),
      SizedBox(height: 20,),
      Container(
        decoration: BoxDecoration(
          color: Colors.transparent, // Container background color
          borderRadius: BorderRadius.circular(10.0), // Border radius here
        ),
        width: double.infinity,
        height: getVerticalSize(100),
        child: Skeleton(
        ),
      ),
    ],
  );
}

Widget shimmerproduction(context) {
  Responsive responsive = Responsive();
  responsive.setContext(context);
  return  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
    child: Column(
      children: [
        Row(
          children: [
            Container(
                height: 40,width: 40,child: Skeleton(
              cornerRadius: 20,
            )),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                  SizedBox(height: 10,),

                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 30,),

        Row(
          children: [
            Container(
                height: 40,width: 40,child: Skeleton(
              cornerRadius: 20,
            )),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                  SizedBox(height: 10,),

                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 30,),

        Row(
          children: [
            Container(
                height: 40,width: 40,child: Skeleton(
              cornerRadius: 20,
            )),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                  SizedBox(height: 10,),

                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 30,),
        Row(
          children: [
            Container(
                height: 40,width: 40,child: Skeleton(
              cornerRadius: 20,
            )),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                  SizedBox(height: 10,),

                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 30,),
        Row(
          children: [
            Container(
                height: 40,width: 40,child: Skeleton(
              cornerRadius: 20,
            )),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                  SizedBox(height: 10,),

                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 30,),

      ],
    ),
  );
}

Widget shimmerSavedImages(context) {
  Responsive responsive = Responsive();
  responsive.setContext(context);
  return GridView.builder(
    itemCount: 6,
    padding: EdgeInsets.symmetric(horizontal: 10.0),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 13/15
    ),
    itemBuilder: (context, index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: responsive.setHeight(0.5),),
          Expanded(
            child: SizedBox(
              // height: size.height,
              width: double.maxFinite,
              child: Skeleton(),
            ),
          ),
          SizedBox(height: responsive.setHeight(0.5),),
        ],
      );
    },
  );
}

Widget shimerHomeCategories(context,index)
{
  Responsive responsive = Responsive();
  responsive.setContext(context);
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            height: 40,width: 40,child: Skeleton(
          cornerRadius: 50,
        )),

        Container(height: 5,width: responsive.setWidth(8),child: Skeleton(),)
      ],
    ),
  );
}

Widget shimerReportCategories(context)
{
  Responsive responsive = Responsive();
  responsive.setContext(context);
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Padding(
        padding: EdgeInsets.only(bottom: responsive.setHeight(4)),
        child: Container(height: 15,width: responsive.setWidth(30),child: Skeleton(),),
      ),
      Padding(
        padding: EdgeInsets.only(bottom: responsive.setHeight(2)),
        child: Container(height: 15,width: responsive.setWidth(30),child: Skeleton(),),
      )
    ],
  );
}

Widget shimmerRewards(context,index)
{
  Responsive responsive = Responsive();
  responsive.setContext(context);
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
    child: Column(
      children: [
        Row(
          children: [
            Container(
                height: 40,width: 40,child: Skeleton(
              cornerRadius: 20,
            )),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                  SizedBox(height: 10,),

                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 30,),

        Row(
          children: [
            Container(
                height: 40,width: 40,child: Skeleton(
              cornerRadius: 20,
            )),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                  SizedBox(height: 10,),

                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 30,),

        Row(
          children: [
            Container(
                height: 40,width: 40,child: Skeleton(
              cornerRadius: 20,
            )),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                  SizedBox(height: 10,),

                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 30,),
        Row(
          children: [
            Container(
                height: 40,width: 40,child: Skeleton(
              cornerRadius: 20,
            )),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                  SizedBox(height: 10,),

                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 30,),
        Row(
          children: [
            Container(
                height: 40,width: 40,child: Skeleton(
              cornerRadius: 20,
            )),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                  SizedBox(height: 10,),

                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 30,),

      ],
    ),
  );
}


Widget shimmerEventsDetails(context,index)
{
  Responsive responsive = Responsive();
  responsive.setContext(context);
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
    child: Column(
      children: [
        Row(
          children: [
            Container(
                height: 40,width: 40,child: Skeleton(
              cornerRadius: 20,
            )),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                  SizedBox(height: 10,),

                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 30,),

        Row(
          children: [
            Container(
                height: 40,width: 40,child: Skeleton(
              cornerRadius: 20,
            )),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                  SizedBox(height: 10,),

                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 30,),

        Row(
          children: [
            Container(
                height: 40,width: 40,child: Skeleton(
              cornerRadius: 20,
            )),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                  SizedBox(height: 10,),

                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 30,),
        Row(
          children: [
            Container(
                height: 40,width: 40,child: Skeleton(
              cornerRadius: 20,
            )),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                  SizedBox(height: 10,),

                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 30,),
        Row(
          children: [
            Container(
                height: 40,width: 40,child: Skeleton(
              cornerRadius: 20,
            )),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                  SizedBox(height: 10,),

                  Container(
                      height: 10,width: responsive.setFullWidth(),child: Skeleton(
                  )),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 30,),

      ],
    ),
  );
}
