
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class Bowling extends StatefulWidget {
  const Bowling({Key? key}) : super(key: key);

  @override
  State<Bowling> createState() => _BowlingState();
}

class _BowlingState extends State<Bowling> {
  List<int> scores=[];
  List<int> sumScore=[];
  @override
  void initState() {
    for(int i=0;i<10;i++){
      scores.add(0);
      sumScore.add(0);
    }
    super.initState();
  }
  Widget pickScore(int index){
    return (
      NumberPicker(
          minValue: 0,
          maxValue: 10,
          value: scores[index],
          onChanged: (value) => setState(() => scores[index] = value),
      )
    );
  }
  MaterialAccentColor whichColor(int index){
    if(sumScore[index]==0)
      return Colors.indigoAccent;
    else if(sumScore[index]<30)
      return Colors.yellowAccent;
    else
      return Colors.greenAccent;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.deepPurple,
              Colors.white,
            ],
          ),
        ),
        child: ListView(
          children: [
            for(int i=0; i<9; i++)
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    height: MediaQuery.of(context).size.height/3,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      color: whichColor(i),
                      border: Border.all(
                        width: 5,
                        color: Colors.white,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [],
                        ),
                        Container(
                          //biała linia oddzielająca
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
