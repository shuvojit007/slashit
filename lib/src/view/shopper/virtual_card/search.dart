import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slashit/src/resources/assets.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/view/shopper/virtual_card/websiteDetails.dart';

class Search extends StatefulWidget {
  static const routeName = "/search";
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _accountNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 60),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 30, bottom: 10),
            child: Text(
              "Where do you want to shop ? ",
              style: searchTitle,
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: TextField(
              onChanged: (String text) {},
              controller: _accountNumber,
              decoration: InputDecoration(
                hintText: "www.ebelle.com",
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(color: PrimaryColor, width: 1.0)),
                prefixIcon: Icon(Icons.search),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
                //   prefixIcon: Icon(FontAwesomeIcons.moneyCheck),
              ),
              cursorColor: appbartitle,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                _searchList(),
                _searchList(),
                _searchList(),
                _searchList(),
                _searchList(),
                _searchList(),
                _searchList(),
                _searchList(),
                _searchList(),
                _searchList(),
                _searchList(),
                _searchList(),
                _searchList(),
                _searchList(),
                _searchList(),
                _searchList(),
              ],
            ),
          )
        ],
      ),
    );
  }

  _searchList() {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(left: 20, bottom: 5, top: 5, right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _imageView(),
          Expanded(
            child: Text(
              "Amazon",
              textAlign: TextAlign.center,
              style: searchTitle1,
            ),
          ),
          Expanded(
              child: GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => websiteDetails(
                          link: "https://amazon.com/",
                          title: "Amazon",
                        ))),
            child: Text(
              "Visit website",
              textAlign: TextAlign.right,
              style: searchTitle2,
            ),
          )),
        ],
      ),
    );
  }

  _imageView() {
    return Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 0.2,
          style: BorderStyle.solid,
        ),
      ),
      child: ClipRRect(
        borderRadius: new BorderRadius.circular(55.0),
        child: CachedNetworkImage(
          imageUrl: "",
          height: 55,
          width: 55,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => Image.asset(
            Assets.Placeholder,
            width: 55,
            fit: BoxFit.cover,
            height: 55,
          ),
        ),
      ),
    );
  }
}
