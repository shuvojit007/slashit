import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slashit/src/blocs/searchWebstie.dart';
import 'package:slashit/src/models/website.dart';
import 'package:slashit/src/resources/assets.dart';
import 'package:slashit/src/resources/colors.dart';
import 'package:slashit/src/resources/text_styles.dart';
import 'package:slashit/src/utils/showToast.dart';
import 'package:slashit/src/view/common/bankTransfer.dart';
import 'package:slashit/src/view/shopper/virtual_card/vcard.dart';
import 'package:slashit/src/view/shopper/virtual_card/websiteDetails.dart';

class Search extends StatefulWidget {
  static const routeName = "/search";
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchWebsite = TextEditingController();

  SearchWebsiteBloc _bloc;
  ScrollController _controller = ScrollController();
  bool scrlDown = true;
  int offset = 0;
  final _debouncer = Debouncer(milliseconds: 500);

  _scrollListener() async {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      print(" Scroll Lister FetchMore Called");
      offset = offset + 1;
      _bloc.fetchAllWebsitewithText(20, offset, "");
    }
  }

  _onSubmited(String text) {
    print("_bloc.websiteList.length ${_bloc.count}");
    if (_bloc.count == 0) {
      if (!RegExp(
              r"^[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)")
          .hasMatch(text)) {
        showToastMsg("Please add valid url");
        return;
      }
      print("_onSubmited $text");
      if (!text.startsWith("http://") && !text.startsWith("https://")) {
        _goToWebSiteDetails("https://$text", "");
      } else {
        _goToWebSiteDetails(text, "");
      }
    }
  }

  @override
  void initState() {
    _bloc = SearchWebsiteBloc();
    _bloc.fetchAllWebsitewithText(20, offset, "");
    _controller.addListener(_scrollListener);

    super.initState();
  }

  _textChangeListener(String text) {
    _debouncer.run(() async {
      print("text $text");
      if (_searchWebsite.text.isNotEmpty) {
        print("_debouncer $text");
        _bloc.fetchAllWebsitewithText(20, 0, text);
      } else {
        _bloc.fetchAllWebsite();
      }
    });
  }

  _progressDialog() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            margin: EdgeInsets.only(bottom: 30),
            child: CircularProgressIndicator()));
  }

  @override
  void dispose() {
    _bloc?.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  _header() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20, right: 30, bottom: 10),
            child: Text(
              "Where do you want to shop ? ",
              style: searchTitle,
            ),
          ),
          Positioned(
            right: 5,
            top: 1,
            child: PopupMenuButton(
              elevation: 3.2,
              onCanceled: () {
                print('You have not chossed anything');
              },
              tooltip: 'This is tooltip',
              onSelected: (String option) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => VCard()));
              },
              itemBuilder: (BuildContext context) {
                return ["Your virtual cards"].map((String option) {
                  return PopupMenuItem(
                    value: option,
                    child: Text(option),
                  );
                }).toList();
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
//          SizedBox(height: 60),
//          Padding(
//            padding: EdgeInsets.only(left: 20, right: 30, bottom: 10),
//            child: Text(
//              "Where do you want to shop ? ",
//              style: searchTitle,
//            ),
//          ),
          _header(),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: TextField(
              onChanged: _textChangeListener,
              controller: _searchWebsite,
              onSubmitted: _onSubmited,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: "www.example.com",
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
            child: Stack(
              children: <Widget>[
                StreamBuilder(
                  stream: _bloc.allWebsite,
                  builder: (context, AsyncSnapshot<List<Result>> snapshot) {
                    if (snapshot.hasData && snapshot.data.length > 0) {
                      return ListView.builder(
                          controller: _controller,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            return _searchList(snapshot.data[index]);
                          });
                    } else if (snapshot.hasData) {
                      return Center(child: Text("No website found"));
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
                StreamBuilder<bool>(
                  stream: _bloc.isMoreLoading,
                  initialData: false,
                  builder: (context, snapshot) {
                    if (!snapshot.data) {
                      return Container();
                    } else {
                      return _progressDialog();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _searchList(Result data) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(left: 20, bottom: 5, top: 5, right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _imageView(data.img),
          SizedBox(
            width: 50,
          ),
          Expanded(
            child: Text(
              data.title,
              textAlign: TextAlign.left,
              style: searchTitle1,
            ),
          ),
          Expanded(
              child: GestureDetector(
            onTap: () => _goToWebSiteDetails(data.link, data.title),
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

  _imageView(String url) {
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
          imageUrl: url,
          height: 55,
          width: 55,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => Image.asset(
            Assets.Placeholder2,
            width: 55,
            fit: BoxFit.cover,
            height: 55,
          ),
        ),
      ),
    );
  }

  _goToWebSiteDetails(String link, String title) {
    Navigator.pushNamed(
      context,
      WebsiteDetails.routeName,
      arguments: WebsiteDetailsArguments(
        link,
        title,
      ),
    );
  }
}
