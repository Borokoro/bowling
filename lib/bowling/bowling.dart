import 'dart:ui';
import 'functions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class Bowling extends StatefulWidget {
  const Bowling({Key? key}) : super(key: key);

  @override
  State<Bowling> createState() => _BowlingState();
}

class _BowlingState extends State<Bowling> {
  Functions f=Functions();
  List<int> scores = [];
  List<int> sumScore = [];
  List<bool> isStrike=[];
  int scoreOverall = 0;
  bool isError=false;
  @override
  void initState() {
    for (int i = 0; i < 23; i++) {
      sumScore.add(0);
      isStrike.add(false);
      scores.add(0);
    }
    super.initState();
  }

  Widget pickScore(int index, bool isLeft, bool wasIChecked) {
    bool checker=wasIChecked;
    int whichScores = index * 2;
    print(index);
    if (isLeft == false && checker==false) {
      checker=true;
      whichScores++;
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(width: 2, color: Colors.white30),
      ),
      child: (NumberPicker(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(width: 2, color: Colors.white30),
        ),
        infiniteLoop: true,
        minValue: 0,
        maxValue: 10,
        value: scores[whichScores],
        onChanged: (value) => setState(() {
          scores[whichScores] = value;
          sumScore[index]+=value;
          if(isLeft==true){
            if(f.isStrike(scores[whichScores])){
              isStrike[index]=true;
            }
            else {
              isStrike[index]=false;
            }
            if (f.isSumGreaterThan10(
                scores[whichScores], scores[whichScores+1], 0)) {
              isError = true;
            } else {
              isError = false;
            }
            sumScore[index]=f.countPoints(scores[whichScores], scores[whichScores+1], 0, isStrike[index+1], isStrike[index], sumScore[index+1], sumScore[index+2]);
          }
          else {
            if (f.isSumGreaterThan10(
                scores[whichScores-1], scores[whichScores], 0)) {
              isError = true;
            } else {
              isError = false;
            }
            sumScore[index]=f.countPoints(scores[whichScores], scores[whichScores-1], 0, isStrike[index+1], isStrike[index], sumScore[index+1], sumScore[index+2]);
          }
          scoreOverall=0;
          for(int i=0;i<10;i++){
            scoreOverall+=sumScore[i];
          }
        }),
      )),
    );
  }

  Widget scoreboard(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          child: Center(
            child: Text(
              'Throw number ${index + 1}',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text('First',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  SizedBox(height: 10,),
                  pickScore(index, true, false),
                ],
              ),
              Column(
                children: [
                  Text('Second',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  SizedBox(height: 10,),
                  pickScore(index, false, false),
                ],
              ),
            ],
          ),
        ),
        Container(
          child: Center(
            child: Text(
              isError==false ? 'Score: ${sumScore[index]}' : 'Wrong value somewhere',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget Carousel(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.27,
      height: MediaQuery.of(context).size.height / 1.5,
      child: CarouselSlider(
        items: [
          for (int i = 0; i < 10; i++) scoreboard(i),
        ],
        options: CarouselOptions(
          onPageChanged: (index, reason){
            setState(() {
              for(int i=0;i<10;i++){
                if(isStrike[i]){
                  sumScore[i]=10+f.sumPreviousShot(sumScore[i+1]);
                  if(isStrike[i+1]){
                    sumScore[i]=20+f.sumPreviousShot(sumScore[i+2]);
                  }
                }
              }
              scoreOverall=0;
              for(int i=0;i<10;i++){
                scoreOverall+=sumScore[i];
              }
            });
          },
          autoPlay: false,
          reverse: false,
          viewportFraction: 1.0,
          enlargeCenterPage: false,
          height: MediaQuery.of(context).size.height / 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/green-bowling-ball-in-front-of-bowling-lanes.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 10,),
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.25,
                    height: MediaQuery.of(context).size.height / 1.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white60, Colors.white10],
                      ),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(width: 2, color: Colors.white30),
                    ),
                    child: Center(
                      child: Row(
                        children: <Widget>[
                          Carousel(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    width: MediaQuery.of(context).size.width /1.25 ,
                    height: MediaQuery.of(context).size.height / 10,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white60, Colors.white10],
                      ),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(width: 2, color: Colors.white30),
                    ),
                    child: Center(
                      child:  Text(
                        isError==false ? 'Overall score: $scoreOverall' : 'There is an error somewhere',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
