import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'course_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int numberOfCourses = 0;
  List<TextEditingController> weightControllers = [];
  List<CourseField> courseFields = [];
  double CG = 0;

  @override
  void initState(){
    super.initState();
    _addCourse();
  }

  double _getGPAfromGrade(String grade){
    double ret = 0;
    if (grade == "A+")
      ret = 4;
    else if (grade == "A")
      ret = 3.75;
    else if (grade == "A-")
      ret = 3.5;
    else if (grade == "B+")
      ret = 3.25;
    else if (grade == "B")
      ret = 3;
    else if (grade == "B-")
      ret = 2.75;
    else if (grade == "C+")
      ret = 2.5;
    else if (grade == "C")
      ret = 2.25;
    else if (grade == "D")
      ret = 2.00;
    else ret = 10;
    print("grade: " + grade);
    print(ret);
    return ret;
  }

  double _returnWeightedSum() {
    double weightedSum = 0;
    for(int i=0; i<weightControllers.length; i++){
      if (weightControllers[i].text == "" || courseFields[i].currentGrade == "")
        weightedSum += 0;
      else {
        weightedSum += _getGPAfromGrade(courseFields[i].currentGrade) * double.parse(weightControllers[i].text);
      }
    }
    return weightedSum;
  }

  void _removeCourse(){
    if( numberOfCourses > 1) {
      setState(() {
        weightControllers.removeLast();
        courseFields.removeLast();
        numberOfCourses--;
      });
    }
  }

  void _addCourse(){
    weightControllers.add(TextEditingController());
    courseFields.add( CourseField(courseNumber: numberOfCourses+1, weightController: weightControllers[numberOfCourses]) );
    numberOfCourses++;

  }


  double _returnTotalWeight(){
    double total = 0;
    for(int i=0; i<weightControllers.length; i++){
      if (weightControllers[i].text == "")
        total += 0;
      else total += double.parse(weightControllers[i].text);
    }
    return total;
  }

  void _calculateCG() {
    double sum = _returnWeightedSum();
    double totalWeight = _returnTotalWeight();
    setState(() {
      print("sum: " + sum.toString());
      print("total weight: " + totalWeight.toString());

      print("CG: " + CG.toString());
      CG = sum/totalWeight;
    });
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      const SnackBar(
        content: Text('Calculated CG is: '),
        backgroundColor: Color(0xFF88e079),
        duration: Duration(milliseconds: 100),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(widget.title)),
        ),
        body: SingleChildScrollView(
          controller: ScrollController(),
          // physics: ,
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Text( "Your CG: "+ CG.toStringAsFixed(2), style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold
              )),
              const SizedBox(height: 30,),
              Container(
                height: 45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Expanded(flex: 1,child: Container()),
                    const Expanded(flex: 2,child: Center(
                      child: Text("#",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),),
                    )),

                    const Expanded(flex: 4,child: Center(
                      child: Text("Title",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),),
                    )),

                    Expanded(flex: 1,child: Container()),
                    const Expanded(flex: 4,child: Center(
                      child: Text("Grade",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),),
                    )),
                    Expanded(flex: 1,child: Container()),
                    const Expanded(flex: 3,child: Center(
                      child: Text("Weight",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),),
                    )),
                    Expanded(flex: 1,child: Container()  ),
                  ],
                ),
              ),
              ListView.builder(
                controller: ScrollController(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: courseFields.length,
                  itemBuilder: (context,index){
                    return courseFields[index];
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                ElevatedButton(onPressed: () {
                  setState(() {
                    _addCourse();
                  });
                }, child: const Icon(Icons.add),
                style: ElevatedButton.styleFrom(
                  // padding: const EdgeInsets.all(5),
                  primary: const Color(0xff88E079),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  )
                ),),
                  ElevatedButton(onPressed: () {
                    setState(() {
                      _calculateCG();
                      _showToast(context);
                    });
                  }, child: const Text("Calculate CG", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                      primary: const Color(0xff8949F5),
                    ),),

                ElevatedButton(onPressed: () {
                  setState(() {
                    _removeCourse();
                  });
                }, child: const Icon(Icons.remove),
                  style: ElevatedButton.styleFrom(
                    // padding: const EdgeInsets.all(5),
                      primary: const Color(0xffEF5350),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      )
                  ),
                ),

              ],),


              const SizedBox(height: 10,),
            ],

          ),
        )

    );}
}