import 'package:flutter/material.dart';

class JobRequirementsPage extends StatefulWidget {
  @override
  _JobRequirementsPageState createState() => _JobRequirementsPageState();
}

class _JobRequirementsPageState extends State<JobRequirementsPage> {
  List<String> _tag = ['18～25岁', '男女不限', '学历不限', '1-3年'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 26,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _requirementTagWidget(),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, top: 17),
          child: Text(
            '1、要求无纹身\n2、要求无犯罪记录\n3、要求籍贯是上海本地人\n4、身高170cm以',
            style: TextStyle(color: Color(0xFF4D4F5E), fontSize: 13, height: 1.5),
          ),
        ),
        SizedBox(
        height: 27,
        ),
      ],
    );
  }

  _requirementTagWidget() {
    return _tag.map((tag) {
      var index = _tag.indexOf(tag);
      return Padding(
        padding: EdgeInsets.only(left: index == 0 ? 0 : 28),
        child: Container(
          width: 61,
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Color(0xFFEFEFEF), borderRadius: BorderRadius.circular(4)),
          child: Text(
            tag,
            style: TextStyle(color: Color(0xFF4D4F5E), fontSize: 12),
          ),
        ),
      );
    }).toList();
  }
}
