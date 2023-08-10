import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:tinder_clone/data/explore_json.dart';
import 'package:tinder_clone/theme/colors.dart';
import 'package:tinder_clone/pages/pop_up_sharing.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with TickerProviderStateMixin {
  CardController controller;

  List itemsTemp = [];
  int itemLength = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      itemsTemp = explore_json;
      itemLength = explore_json.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xf3f3f3),
      body: getBody(),
      bottomSheet: getBottomSheet(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(bottom: 120),
      child: Container(
        height: size.height,
        child: TinderSwapCard(
          totalNum: itemLength,
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height * 0.75,
          minWidth: MediaQuery.of(context).size.width * 0.75,
          minHeight: MediaQuery.of(context).size.height * 0.6,
          cardBuilder: (context, index) => Container(

            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: grey.withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 2),
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  Container(
                    width: size.width,
                    height: size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(itemsTemp[index]['img']),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: size.height,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              primary_one,
                              //black.withOpacity(0.25),
                              //black.withOpacity(0),
                            ],
                            end: Alignment.topCenter,
                            begin: Alignment.bottomCenter)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Container(
                                width: size.width * 0.72,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          itemsTemp[index]['name'],
                                          style: TextStyle(
                                              color: white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: List.generate(
                                          itemsTemp[index]['likes'].length,
                                              (indexLikes) {
                                            if (indexLikes == 0) {
                                              return Padding(
                                                padding:
                                                const EdgeInsets.only(right: 8),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: white,
                                                          width: 2),
                                                      borderRadius:
                                                      BorderRadius.circular(30),
                                                      color:
                                                      white.withOpacity(0.4)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .only(
                                                        top: 3,
                                                        bottom: 3,
                                                        left: 10,
                                                        right: 10),
                                                    child: Text(
                                                      itemsTemp[index]['likes']
                                                      [indexLikes],
                                                      style:
                                                      TextStyle(color: white),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            return Padding(
                                              padding:
                                              const EdgeInsets.only(right: 8),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(30),
                                                    color: white.withOpacity(
                                                        0.2)),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .only(
                                                      top: 3,
                                                      bottom: 3,
                                                      left: 10,
                                                      right: 10),
                                                  child: Text(
                                                    itemsTemp[index]['likes']
                                                    [indexLikes],
                                                    style: TextStyle(
                                                        color: white),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    )
                                  ],
                                ),
                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          cardController: controller = CardController(),
          swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
            /// Get swiping card's alignment
            if (align.x < 0) {
            
            }
            else if(align.x > 0) {
              setState(() {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>                         
                                  PopUpSharing(),
                                  );
                        controller.triggerRight();                          
                      }); 
              }
            // print(itemsTemp.length);
          },
          swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
            /// Get orientation & index of swiped card!
            if (index == (itemsTemp.length - 1)) {
              setState(() {
                itemLength = itemsTemp.length - 1;
              });
            }
          },
        ),
      ),
    );
  }

  Widget getBottomSheet() {
    var size = MediaQuery.of(context).size;
    var buttonName = ['Passer', "Editer le texte", "Partager"];

    return Container(
      width: size.width,
      height: 120,
      decoration: BoxDecoration(color: primary_one),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
            new ElevatedButton(
                child: Text("Passer"),
                onPressed: () {
                  setState(() {
                    controller.triggerLeft();
                  });
                },
            ),
            new ElevatedButton(
                child: Text("Editer le texte"),
                onPressed: null,
            ),
            new ElevatedButton(
                child: Text("Partager"),
                onPressed: () {
                  setState(() {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          PopUpSharing(),
                    );
                    controller.triggerRight();
                  });
                },
            ),
          ],
          /*List.generate(buttonName.length, (index) {
            return Container(
              width: 100,
              height: 58,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primary_one,
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 10,
                      // changes position of shadow
                    ),
                  ]),
                child: ElevatedButton (
                child: Text(buttonName[index]),
                  onPressed: (){
                    if (index == 2){
                      setState(() {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>                         
                                  PopUpSharing(),
                        );
                        controller.triggerRight();                          
                      });
                      }
                    else if (index == 0) { 
                      setState(() {
                          controller.triggerLeft();
                        });
                    }
                  },
              ),
            );
          }),*/
        ),
      ),
    );
  }
}
