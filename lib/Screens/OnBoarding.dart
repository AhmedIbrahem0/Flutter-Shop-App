// @dart=2.9
import 'package:flutter/material.dart';
import 'package:shop_app/Helpers/CacheHelper.dart';
import 'package:shop_app/Screens/LogInScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
  static String id = "OnBoardingPage";

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  PageController controller = PageController();

  final List<Widget> boardList = [
    BoardingItem(
        image: "assets/images/1.png", title: "title 1", subtitle: "subtitle 1"),
    BoardingItem(
        image: "assets/images/2.png", title: "title 2", subtitle: "subtitle 2"),
    BoardingItem(
        image: "assets/images/3.png", title: "title 3", subtitle: "subtitle 3")
  ];

  int pageViewIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
              onPressed: () {
                CacheHelper.saveData(key: "OnBoarding", value:true);
                Navigator.pushReplacementNamed(context, LogInScreen.id);
              },
              child: Text(
                "Skip",
                style: TextStyle(color: Colors.purple[900], fontSize: 20),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            
              flex: 5,
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                  controller: controller,
                  onPageChanged: (index) {
                    setState(() {
                      pageViewIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return boardList[index];
                  },
                  itemCount: 3)),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                
                SmoothPageIndicator(
                    effect: ExpandingDotsEffect(),
                    controller: controller,
                    count: 3),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {

                    if (pageViewIndex == 2) {
                       CacheHelper.saveData(key: "OnBoarding", value:true);
                      Navigator.pushReplacementNamed(context, LogInScreen.id);
                    }
                    controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.bounceOut);
                  },
                  backgroundColor: Colors.purple[900],
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class BoardingItem extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  const BoardingItem({this.image, this.title, this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Image.asset(
            image,
          ),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        Text(subtitle, style: TextStyle(fontSize: 30, color: Colors.grey)),
      ],
    );
  }
}
