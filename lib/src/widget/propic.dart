import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:slashit/src/resources/assets.dart';
import 'package:slashit/src/utils/url.dart';

class ProfileImage extends StatefulWidget {
  String photo;

  ProfileImage({this.photo});

  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  void initState() {
    print("photo => ${widget.photo}");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 35, left: 5),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: Colors.white, width: 0.2, style: BorderStyle.solid)),
      child: ClipRRect(
        borderRadius: new BorderRadius.circular(55.0),
        child: _profileImage(),
      ),
    );
  }

  Widget _profileImage() {
    // print("photo ${photo}");
    if (widget.photo == null) {
      return Image.asset(Assets.Placeholder,
          width: 55, fit: BoxFit.cover, height: 55);
    } else {
      return CachedNetworkImage(
          imageUrl: "${URL.S3_URL}${widget.photo}",
          height: 55,
          width: 55,
          fit: BoxFit.cover,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Image.asset(Assets.Placeholder,
              width: 55, fit: BoxFit.cover, height: 55));
    }
  }
}
