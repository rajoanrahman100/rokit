
import 'package:flutter/material.dart';
import 'package:rokit/utils/styles.dart';

class HomeScreenGridView {
  final String image;
  final String title;
  final Color color;
  const HomeScreenGridView({this.image, this.title,this.color});
}

const List<HomeScreenGridView> adminItemsGridView =[
  HomeScreenGridView(image: "assets/home_lock.png", title: "Smart Switch",color:Color(0xFFFFEEDE),),
  HomeScreenGridView(image: "assets/home_lock.png", title: "Smart Lock",color:Color(0xFFF0FFDD),),
  HomeScreenGridView(image: "assets/light_control.png", title: "Video Intercom",color:Color(0xFFD9E5FB),),
  HomeScreenGridView(image: "assets/home_lock.png", title: "Smart Switch",color:Color(0xFFDBFFEB),),
  HomeScreenGridView(image: "assets/video_com.png", title: "Video Intercom", color:Color(0xFFFFEEFD),),
  HomeScreenGridView(image: "assets/home_lock.png", title: "Door Lock",color:Color(0xFFFFD9D9),),
];

class HomeItemsNewUI extends StatelessWidget {
  const HomeItemsNewUI({Key key, this.callback, this.homeScreenGridView}) : super(key: key);

  final VoidCallback callback;
  final HomeScreenGridView homeScreenGridView;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: callback,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 12.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(height: 15.0,),

                Container(
                  height: 38.0,width: 38.0,
                  decoration: BoxDecoration(
                    color: homeScreenGridView.color,
                    shape: BoxShape.circle
                  ),
                  child: Center(
                    child: Image.asset(
                      homeScreenGridView.image,
                      height: 20.0,
                    ),
                  ),
                ),
                SizedBox(height: 8.0,),
                Text(
                  homeScreenGridView.title,
                  textAlign: TextAlign.center,
                  style: text_StyleRoboto(headerColor, 13.0, FontWeight.w500),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

