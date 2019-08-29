import 'package:flutter/material.dart';
import 'package:flutter_bd/server/routes.dart';

class WorkInfoPage extends StatefulWidget {
  @override
  _WorkInfoPageState createState() => _WorkInfoPageState();
}

class _WorkInfoPageState extends State<WorkInfoPage> {

  String _temp = '鹿角巷的足迹遍布十多个城市，上海的第一家鹿角巷，就坐落在人文荟萃，充满悠闲异国情调的大学路，优美的空间设计，营造出随便拍随便美的舒适环境，高颜质的饮品外型与绝对五颗星好评的口味，迅速成为时尚潮流年轻男女的拔草新据点。 懂吃的人都知道，看似越简单的背后，从来都不简单，没有茶叶、人工香料，糖浆以及任何可以蒙蔽味蕾的干扰，必须在仅有的两个元素上做到完美：半部盛满透过繁复工法熬成的温热正宗台湾黑糖珍珠，上半部配上香浓冰凉的纯鲜奶，上冷下热在口中交融成绝妙的口感，这是化繁为简的极致，美味到让人难以停下，为什么呢?因为纯粹 就是好吃。\n\n 备注：要吃苦耐劳的男生';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 10,
          color: Color(0xFFF4F4F4),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 20),
          child: Text(
            '工作环境',
            style: TextStyle(
                color: Color(0xFF4A4C5B),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        _photoWidget(),
      _createCompanyInfoWidget()
      ],
    );
  }

  _createCompanyInfoWidget() {
      return Padding(padding: EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 26), child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '企业信息',
            style: TextStyle(
                color: Color(0xFF4A4C5B),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 19,),
          Row(
            children: <Widget>[
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(30)
                ),
              ),
              SizedBox(width: 18,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '鹿角巷',
                    style: TextStyle(
                        color: Color(0xFF4A4C5B),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6,),
                  Text(
                    '上海市鹿角巷有限公司',
                    style: TextStyle(
                        color: Color(0xFF4A4C5B),
                        fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20,),
          Text(_temp, style: TextStyle(color: Color(0xFF4A4C5B),
              fontSize: 13, height: 1.5),),
        ],
      ),);
  }

  _photoWidget() {
    switch (3) {
      case 1:
        return _onePhotoWidget();
      case 2:
        return _twoPhotoWidget();
      default:
        return _threeOverPhotoWidget();
    }
  }

  _onePhotoWidget() {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 20),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 162,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.green),
        ),
      ),
    );
  }

  _twoPhotoWidget() {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 20),
      child: Container(
        height: 162,
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.green),
                ),
              ),
              flex: 1,
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.green),
                ),
              ),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }

  _threeOverPhotoWidget() {
    return Padding(
      padding: EdgeInsets.only(left: 15, top: 20),
      child: Container(
        height: 130,
        width: double.infinity,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return _photoItemWidget();
          },
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
        ),
      ),
    );
  }

  _photoItemWidget() {
    return Padding(
      padding: EdgeInsets.only(right: 21),
      child: GestureDetector(
        child: Container(
          height: 130,
          width: 130,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.green),
        ),
        onTap: () {
            Navigator.pushNamed(context, galleryRoutesName);
        },
      ),
    );
  }
}
