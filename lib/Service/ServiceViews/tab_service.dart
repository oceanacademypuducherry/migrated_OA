import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Footer/mobile_footer.dart';
import 'package:flutter_app_newocean/Service/service_widget/Mobile_Tab_widget/card_design.dart';
import 'package:flutter_app_newocean/TopNavigationBar/mobile_topnavigationbar.dart';
import 'package:flutter_app_newocean/common/constants.dart';
import 'package:flutter_app_newocean/common/text.dart';
import 'package:flutter_app_newocean/Footer/tablet_footer.dart';

class TabService extends StatefulWidget {
  @override
  _TabServiceState createState() => _TabServiceState();
}

class _TabServiceState extends State<TabService> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: 1,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0),
          child: Center(
            child: Column(
              children: [
                MobileTopNavigationBar(
                  title: "Service",
                ),
                SizedBox(
                  height: 50.0,
                ),
                ContainerServiceWidget(
                  title: 'On-Campus training',
                  content:
                      "We offer on-campus learning for students of various Universities and Colleges and help facilitate knowledge and develop their career.",
                  icon: 'images/campus-training.png',
                ),
                ContainerServiceWidget(
                  title: "Software development",
                  content:
                      "We offer various software development services such as designing, planning, and testing and also provide maintenance.",
                  icon: 'images/software-development.png',
                ),
                ContainerServiceWidget(
                  title: "Technical Workshops (Implant training)",
                  content:
                      "We devise and plan workshops targeted towards the practical needs of students and exploring new nuances in IT technology.",
                  icon: 'images/technical workshop.png',
                ),
                ContainerServiceWidget(
                  title: "IT consulting",
                  content:
                      "We provide data analysis services to companies, manage their data and infrastructure, and guide them according to their goals and needs using our technologies.",
                  icon: 'images/counseling.png',
                ),
                ContainerServiceWidget(
                  title: "Free Webinars",
                  content:
                      "The easiest way to host a webinar for free is to use a live streaming platform like Facebook Live or YouTube Live. The benefits include easy use, nearly unlimited participant counts, and simple event marketing",
                  icon: 'images/wbinar.png',
                ),
                ContainerServiceWidget(
                  title: "Free Webinars",
                  content:
                      "The easiest way to host a webinar for free is to use a live streaming platform like Facebook Live or YouTube Live. The benefits include easy use, nearly unlimited participant counts, and simple event marketing",
                  icon: 'images/wbinar.png',
                ),
                SizedBox(
                  height: 50.0,
                ),
                ImageWithContent(
                  title: serviceheading1,
                  image:
                      'https://firebasestorage.googleapis.com/v0/b/ocean-live-project-ea2e7.appspot.com/o/service%20images%20svgs%2Fcorporate%20trining.svg?alt=media&token=73464595-cf57-4c7e-b7c6-5dea4d5009ae',
                  content: servicecontent1,
                ),
                ImageWithContent(
                  title: serviceheading2,
                  image:
                      'https://firebasestorage.googleapis.com/v0/b/ocean-live-project-ea2e7.appspot.com/o/service%20images%20svgs%2Fcareer%20oriented.svg?alt=media&token=7dcee29f-ecea-4ed4-b4a5-485a90bdc3b2',
                  content: servicecontent2,
                ),
                ImageWithContent(
                  title: serviceheading3,
                  image:
                      'https://firebasestorage.googleapis.com/v0/b/ocean-live-project-ea2e7.appspot.com/o/service%20images%20svgs%2Fworkshops%20and%20value.svg?alt=media&token=6a4cc10d-a9c4-43f0-bf46-f0d6077a8456',
                  content: servicecontent3,
                ),
                ImageWithContent(
                  title: serviceheading4,
                  image:
                      'https://firebasestorage.googleapis.com/v0/b/ocean-live-project-ea2e7.appspot.com/o/service%20images%20svgs%2Flearn%20new%20skil.svg?alt=media&token=1d608f76-07dc-48f2-951f-819cee6f0b92',
                  content: servicecontent4,
                ),
                LayoutBuilder(
                  // ignore: missing_return
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 600) {
                      return Footer();
                    } else if (constraints.maxWidth > 600 &&
                        constraints.maxWidth < 950) {
                      return TabletFooter();
                    }
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class ContentWidget extends StatelessWidget {
  final String content;
  ContentWidget({this.content});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      child: Text(
        content,
        textAlign: TextAlign.justify,
        style: TextStyle(color: kcontentcolor, height: 1.5, fontSize: 18),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  final String title;
  TitleWidget({this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
            fontFamily: kfontname),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  final String photo;
  ImageWidget({this.photo});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image(
          image: NetworkImage(
            photo,
          ),
        ),
      ),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
    );
  }
}

// ignore: must_be_immutable
class ImageWithContent extends StatelessWidget {
  ImageWithContent({this.title, this.image, this.content});
  String title;
  String image;
  String content;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          TitleWidget(
            title: title,
          ),
          SizedBox(
            height: 10,
          ),
          ImageWidget(
            photo: image,
          ),
          SizedBox(
            height: 10,
          ),
          ContentWidget(
            content: content,
          ),
        ],
      ),
    );
  }
}
