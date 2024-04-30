
import 'package:get/get.dart';

import '../core/utils/image_constant.dart';


class DummyContent {



  static List<SearchesModel> productPost = [

    SearchesModel(
      id: 1,
      image: [
        ImageConstant.imgArrowLeft,
        ImageConstant.imgArrowLeft,
        ImageConstant.imgArrowLeft,
      ],
    ),
  ];

  static List<CommunityModel> socialPost = [
    CommunityModel(
      id: 1,
      profilePic: ImageConstant.imgImage4,
      profileName: "Emma Thompson",
      location: "Brazil Academy",
      postDiscription:
      "Have you ever been a member of a book club? If so, what was the best book discussion you've had?",
      time: "6m ago",
      postType: 10,
      // 10 for image post, 20 for video post
      postImage: [
        ImageConstant.dashboardCardimg,
        ImageConstant.imgH1Banner41,
        ImageConstant.dashboardCardimg,
      ],
      tags: [
        'Leo Levin',
        'Marcus Korsgaard',
      ],
      isLiked: false.obs,
    ),

  ];

  static List<RecentSearchesModel> recentsearchesList = [
    RecentSearchesModel(
      id: 1,
      name: 'Touchscreen LCD Monitor',
      price: '900AED'
    ),
    RecentSearchesModel(
      id: 2,
      name: 'Alpha Owls® – Custom Headlights',
        price: '800AED'
    ),
    RecentSearchesModel(
      id: 3,
      name: 'Ameri PLATINUM Coated Brake Kit',
        price: '700AED'
    ),

  ];



}

class SearchesModel {
  int? id;
  List<String>? image;

  SearchesModel({this.id, this.image});
}



class CommunityModel {
  int? id;
  String? profilePic;
  String? profileName;
  String? postDiscription;
  List<String>? tags;
  String? location;
  String? time;
  int? postType;
  List<String>? postImage;
  RxBool? isLiked;
  CommunityModel ({
    this.id,
    this.profilePic,
    this.profileName,
    this.tags,
    this.postDiscription,
    this.location,
    this.time,
    this.postType,
    this.postImage,
    this.isLiked,
  });
}

class RecentSearchesModel {
  int? id;
  String? image;
  String? price;
  String? name;

  RecentSearchesModel({this.id, this.name, this.image,this.price});
}