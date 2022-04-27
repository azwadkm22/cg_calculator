import 'package:flutter/material.dart';

class CourseField extends StatefulWidget {
  final courseNumber;
  final weightController;
  final titleController = TextEditingController();
  String currentGrade = "A+";
  CourseField({Key? key,required this.courseNumber, required this.weightController}) : super(key: key);
  @override
  _CourseFieldState createState() => _CourseFieldState();
}

class _CourseFieldState extends State<CourseField> {
  List<String> gradeList = ["A+", "A", "A-", "B+", "B", "B-", "C+", "C", "D", "F"];

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 2,child: Container(height: 40,child: Center(child:
              Text(widget.courseNumber.toString()),
          ),)),
          // Expanded(flex: 1,child: Container()),

          Expanded(flex: 1,child: Container()),
          Expanded(flex: 8,child: Container(height: 40,child: Center(child:
          TextField(controller: widget.titleController,
            style: const TextStyle(
              color: Colors.black,
            ),
            decoration: const InputDecoration(
              hintText: "Title/ID",
              counterText: "",
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          )
          ),)),
          Expanded(flex: 1,child: Container()),

          Expanded(
            flex: 4,
            child: DropdownButton(
              items: gradeList
                  .map((String item) =>
                  DropdownMenuItem<String>(child: Text(item), value: item))
                  .toList(),
              onChanged: (String? value) {
                setState(() {
                  widget.currentGrade = value!;
                });
              },
              value: widget.currentGrade,
            ),
          ),
          // Expanded(flex: 4,child: Container(height: 40,color: Colors.blue,child: TextField(controller: gradeController, keyboardType: TextInputType.number,maxLength: 5,) ,)),

          Expanded(flex: 2,child: Container()),
          Expanded(flex: 4,child: Container(height: 40,color: Color(0xFFdedede),
            child: TextField(controller: widget.weightController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 5,
              style: const TextStyle(
                color: Colors.black,
              ),
              decoration: const InputDecoration(
                hintText: "",
                counterText: "",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),) ,),

          Expanded(flex: 1,child: Container()),
        ],
      ),
    );
  }
}
