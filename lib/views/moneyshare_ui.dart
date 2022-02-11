import 'package:flutter/material.dart';
import 'package:flutter_app_sau_moneyshared_sau/views/show_moneyshare_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MoneyshareUI extends StatefulWidget {
  const MoneyshareUI({Key? key}) : super(key: key);

  @override
  _MoneyshareUIState createState() => _MoneyshareUIState();
}

class _MoneyshareUIState extends State<MoneyshareUI> {
  bool? check_tip = false;

  TextEditingController money_ctrl = TextEditingController();
  TextEditingController person_ctrl = TextEditingController();
  TextEditingController tip_ctrl = TextEditingController();

  //เมธอด -> โค้ดแสดง Dialog เตือน โดยจะรับข้อความมาแสดงที่ Dialog
  showWarningDialog(context, msg) {
//เรียกใช้งานฟังก์ชัน showDialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Container(
            color: Colors.deepPurple,
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'คำเตือน',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          content: Text(
            msg,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'ตกลง',
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC1A0F1),
      appBar: AppBar(
        backgroundColor: Color(0xFF6B11EE),
        title: Text('แชร์เงินกันเถอะ'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30.0,
              ),
              Image.asset(
                'assets/images/Cash-register-icon.png',
                height: 170.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 40.0,
                  right: 40.0,
                  top: 30.0,
                ),
                child: TextField(
                  controller: money_ctrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'ป้อนจำนวนเงินบาท (บาท)',
                    hintStyle: TextStyle(
                      color: Color(0xFF818085),
                    ),
                    prefixIcon: Icon(
                      FontAwesomeIcons.moneyBillWaveAlt,
                      color: Color(0xFF380FDC),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF3B0CF5)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF3B0CF5)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 40.0,
                  right: 40.0,
                  top: 20.0,
                ),
                child: TextField(
                  controller: person_ctrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'ป้อนจำนวนคน (คน)',
                    hintStyle: TextStyle(
                      color: Color(0xFF818085),
                    ),
                    prefixIcon: Icon(
                      FontAwesomeIcons.pray,
                      color: Color(0xFF380FDC),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF3B0CF5)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF3B0CF5)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    onChanged: (checked) {
                      //เขียนโค้ดเอาค่าที user เลือกที่ส่งมาให้ chacked มากำหนดให้กับ check_tip
                      setState(() {
                        check_tip = checked;
                        if (checked == false) {
                          tip_ctrl.text = '';
                        }
                      });
                    },
                    value: check_tip,
                    activeColor: Color(0xFF5A026A),
                    side: BorderSide(
                      color: Color(0xFF5A026A),
                    ),
                  ),
                  Text('ทิปให้พนักงานเสริฟ'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 40.0,
                  right: 40.0,
                  top: 30.0,
                ),
                child: TextField(
                  controller: tip_ctrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'ป้อนจำนวนเงินบาท (บาท)',
                    hintStyle: TextStyle(
                      color: Color(0xFF818085),
                    ),
                    prefixIcon: Icon(
                      FontAwesomeIcons.bitcoin,
                      color: Color(0xFF380FDC),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF3B0CF5)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF3B0CF5)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                onPressed: () {
                  //สร้างตัวแปรมาเก็ฐผลลัพธ์ที่ได้จากการคำนวณ
                  double? moneyshare = 0;

                  //ตรวจสอบและคำนวณ
                  if ( money_ctrl.text.length == 0 ){
                    showWarningDialog(context, 'ป้อนเงินด้วยจ้าา...');
                    return;
                  } else if( person_ctrl.text.length == 0 ){
                    showWarningDialog(context, 'ป้อนคนเด้วยจ้าา...');
                    return;
                  } else if( check_tip == false ){
                    //คำนวณแบบไม่มี tip
                    double? money = double.parse( money_ctrl.text );
                    int? person = int.parse(person_ctrl.text);
                    moneyshare = double.parse( money_ctrl.text )/ int.parse(person_ctrl.text) ;
                  }else{
                    //ตรวจสอบว่าได้ป้อน tip หรือยัง
                    if(tip_ctrl.text.isEmpty){
                      showWarningDialog(context, 'ป้อนทิปด้วย...');
                      return;
                    }else{
                      //คำนวณแบบมี tip
                      double? money = double.parse(money_ctrl.text);
                      int? person = int.parse(person_ctrl.text);
                      double? tip = double.parse(tip_ctrl.text);
                      moneyshare = (money+tip) / person ;
                    }
                  }

                  //ส่งข้อมูลที่ป่้อนและที่คำนวณได้ไปแสดงอีกหน้า ShowMoneyshareUI
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowMoneyshareUI(
                        money: double.parse(money_ctrl.text),
                        person: int.parse(person_ctrl.text),
                        tip: double.parse( tip_ctrl.text.isEmpty ? '0' : tip_ctrl.text ),
                        moneyshare: moneyshare,
                      ),
                    ),
                  );
                },
                child: Text(
                  'คำนวณ',
                ),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(
                      MediaQuery.of(context).size.width - 80.0,
                      50.0,
                    ),
                    primary: Color(0xFF0004FF)),
              ),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  //กำหนดค่าของTextField ทั้ง3 ตัวให้ว่างและ CheckBox ไม่ติ๊ก
                  setState(() {
                    money_ctrl.text = '';
                    person_ctrl.text = '';
                    tip_ctrl.text = '';
                    check_tip = false;
                  });
                },
                label: Text('ยกเลิก'),
                icon: Icon(
                  FontAwesomeIcons.sync,
                ),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(
                      MediaQuery.of(context).size.width - 80.0,
                      50.0,
                    ),
                    primary: Color(0xFFFF0000)),
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                'Create by Ford SAU',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
