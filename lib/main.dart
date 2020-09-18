import 'package:flutter/material.dart';
import 'dart:math' as Math;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'calc app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum CALC_TYPE { add, sub, multi, div }

class _MyHomePageState extends State<MyHomePage> {
  double _setNumber = 0;
  double _displayNumber = 0;
  double _firstNum = 0;
  CALC_TYPE _calcType;
  int _displayPow = 0;
  bool _decimalFlag = false;
  var _displayCalcNum;


  void _setNum(double num) {
    _displayPow = 0;
    if (_displayNumber == _setNumber) {
      if (10000000000 > _displayNumber) {
        setState(() {
          if (!_decimalFlag) _displayNumber = _displayNumber * 10 + num;
          else {
            int count = 1;
            for (int i = 0;
            _displayNumber * Math.pow(10, i) != (_displayNumber * Math.pow(10, i)).ceil();
            i++) {
              count++;
            }
            _displayNumber = double.parse((_displayNumber + (num / Math.pow(10, count))).toStringAsFixed(count));
            _checkDecimal();
          }
          _setNumber = _displayNumber;
        });
      }
    } else {
      setState(() {
        _displayNumber = num;
        _setNumber = _displayNumber;
        _calcType = null;
      });
    }
    if (_displayCalcNum != "0"){
      _displayCalcNum = _displayCalcNum + _displayNumber.toString();
    }
  }
  void _calcBtnPressed(CALC_TYPE type) {
    _setNumber = _displayNumber;
    _firstNum = _setNumber;
    _setNumber = 0;
    _displayNumber = 0;
    _calcType = type;

  }

  void _calcAdd() {
    setState(() {
      _displayNumber = _firstNum + _setNumber;
      _checkDecimal();
      _firstNum = _displayNumber;
    });
  }

  void _calcSub() {
    setState(() {
      _displayNumber = _firstNum - _setNumber;
      _checkDecimal();
      _firstNum = _displayNumber;
    });
  }

  void _calcMulti() {
    setState(() {
      _displayNumber = _firstNum * _setNumber;
      _checkDecimal();
      _firstNum = _displayNumber;
    });
  }

  void _calcDiv() {
    setState(() {
      _displayNumber = _firstNum / _setNumber;
      _checkDecimal();
      _firstNum = _displayNumber;
    });
  }

  void _checkDecimal() {
    double checkNum = _displayNumber;
    if (100000000000 < _displayNumber ||
        _displayNumber == _displayNumber.toInt()) {
      for (int i = 0; 100000000000 < _displayNumber / Math.pow(10, i); i++) {
        _displayPow = i;
        checkNum = checkNum / 10;
      }
      _displayNumber = checkNum.floor().toDouble();
    } else {
      int count = 0;
      for (int i = 0;
      1 < _displayNumber / Math.pow(10, i);
      i++) {
        count = i;
      }
      int displayCount = 10 - count;
      _displayNumber = double.parse(_displayNumber.toStringAsFixed(displayCount));
    }
  }

  void _clearNum() {
    setState(() {
      _setNumber = 0;
      _displayNumber = 0;
      _firstNum = 0;
      _calcType = null;
      _displayPow = 0;
      _decimalFlag = false;
      _displayCalcNum = "0";
    });
  }
  void _clearEntryNum() {
    setState(() {
      _setNumber = 0;
      _displayNumber = 0;
      _calcType = null;
      _displayPow = 0;
      _decimalFlag = false;
      _displayCalcNum = "0";
    });
  }
  void _invertedNum() {
    setState(() {
      _displayNumber = -_displayNumber;
      _setNumber = -_setNumber;
    });
    _displayCalcNum = _displayNumber.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            child: Text(_displayCalcNum!=null ?
            _displayCalcNum:"0",
              style: TextStyle(
                fontSize: 40,
                color: Colors.black12,
              ),
            ),
          ),
          Container(
            child: _displayPow > 0 ? Text(
              "10^${_displayPow.toString()}",
              style: TextStyle(
                fontSize: 20,
              ),
            ) : Container(),
          ),
          Text(
            _displayNumber == _displayNumber.toInt()?
            _displayNumber.toInt().toString()
                :_displayNumber.toString(),
            style: TextStyle(
              fontSize: 60,
            ),
          ),
          Container(
            height: 100,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: FlatButton(
                            color: Colors.grey[200],
                            child: Text("e",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 35,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                            onPressed: (){
                              _clearEntryNum();
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: FlatButton(
                            color: Colors.grey[200],
                            child: Text("π",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 35,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                            onPressed: (){
                              _clearEntryNum();
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: FlatButton(
                            color: Colors.grey[200],
                            child: Text("sin",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 35,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                            onPressed: (){
                              _clearEntryNum();
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: FlatButton(
                            color: Colors.grey[200],
                            child: Text("deg",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                            onPressed: (){
                              _clearEntryNum();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10,0,10,10),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: FlatButton(
                            color : Colors.red[50],
                            child: Text("c",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 50,
                                  color: Colors.red
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                            onPressed: (){
                              _clearNum();
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10,0,10,10),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: FlatButton(
                            color: Colors.grey[200],
                            child: Text("(",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                            onPressed: (){},
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10,0,10,10),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: FlatButton(
                            color: Colors.grey[200],
                            child: Text(")",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                            onPressed: (){},
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10,0,10,10),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: FlatButton(
                            color: Colors.orange,
                            child: Text("/",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.white
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                            onPressed: (){
                              _calcBtnPressed(CALC_TYPE.div);
                              setState(() {
                                _displayCalcNum = _firstNum.toString() + "÷";
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10,0,10,10),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: FlatButton(
                            color: Colors.grey[200],
                            child: Text("7",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                            onPressed: (){
                              _setNum(7);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10,0,10,10),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: FlatButton(
                            color: Colors.grey[200],
                            child: Text("8",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                            onPressed: (){
                              _setNum(8);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10,0,10,10),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: FlatButton(
                            color: Colors.grey[200],
                            child: Text("9",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                            onPressed: (){
                              _setNum(9);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10,0,10,10),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: FlatButton(
                            color: Colors.orange,
                            child: Text("×",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.white
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                            onPressed: (){
                              _calcBtnPressed(CALC_TYPE.multi);
                              setState(() {
                                _displayCalcNum = _firstNum.toString() + "×";
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10,0,10,10),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: FlatButton(
                            color: Colors.grey[200],
                            child: Text("4",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                            onPressed: (){
                              _setNum(4);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10,0,10,10),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: FlatButton(
                            color: Colors.grey[200],
                            child: Text("5",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                            onPressed: (){
                              _setNum(5);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10,0,10,10),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: FlatButton(
                            color: Colors.grey[200],
                            child: Text("6",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                            onPressed: (){
                              _setNum(6);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10,0,10,10),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: FlatButton(
                            color: Colors.orange,
                            child: Text("-",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 60,
                                  color: Colors.white
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                            onPressed: (){
                              _calcBtnPressed(CALC_TYPE.sub);
                              setState(() {
                                _displayCalcNum = _firstNum.toString() + "-";
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10,0,10,10),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: FlatButton(
                            color: Colors.grey[200],
                            child: Text("1",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                            onPressed: (){
                              _setNum(1);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10,0,10,10),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: FlatButton(
                            color: Colors.grey[200],
                            child: Text("2",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                            onPressed: (){
                              _setNum(2);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10,0,10,10),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: FlatButton(
                            color: Colors.grey[200],
                            child: Text("3",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                            onPressed: (){
                              _setNum(3);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10,0,10,10),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: FlatButton(
                            color: Colors.orange,
                            child: Text("+",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.white
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                            onPressed: (){
                              _calcBtnPressed(CALC_TYPE.add);
                              setState(() {
                                _displayCalcNum = _firstNum.toString() + "+";
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10,0,10,10),
                        child: SizedBox(
                          width: 180,
                          height: 80,
                          child: FlatButton(
                            color: Colors.grey[200],
                            child: Text("0",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                            onPressed: (){
                              _setNum(0);
                            },
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.fromLTRB(10,0,10,10),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: FlatButton(
                            color: Colors.grey[200],
                            child: Text(".",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                            onPressed: (){
                              _decimalFlag = true;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10,0,10,10),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: FlatButton(
                            color: Colors.green[400],
                            child: Text("=",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.white
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                            onPressed: (){
                              switch (_calcType) {
                                case CALC_TYPE.add:
                                  _calcAdd();
                                  break;
                                case CALC_TYPE.sub:
                                  _calcSub();
                                  break;
                                case CALC_TYPE.multi:
                                  _calcMulti();
                                  break;
                                case CALC_TYPE.div:
                                  _calcDiv();
                                  break;
                                default:
                                  break;
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}