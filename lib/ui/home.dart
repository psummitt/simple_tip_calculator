import 'package:flutter/material.dart';

class BillSplitter extends StatefulWidget {
  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0;
  Color _lightBlue = Color(0xff2ab2f8);
  Color _lighterBlue = Color(0xff74caff);
  Color _darkBlue = Color(0xff5678e7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/cash.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.center,
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(20),
            children: <Widget>[
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                      colors: [_lightBlue, _darkBlue], stops: [0.0, 0.7]),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Total Per Person",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      Text(
                        "\$${calculateTotalPerPerson(_tipPercentage, _billAmount, _personCounter)}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 25),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white.withAlpha(220),
                ),
                child: Column(
                  children: <Widget>[
                    TextField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(color: _darkBlue),
                      decoration: InputDecoration(
                          prefixText: "Bill Amount   ",
                          prefixIcon: Icon(Icons.attach_money_outlined)),
                      onChanged: (String value) => _setBillAmount(value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Split",
                            style: TextStyle(
                                color: Colors.grey.shade700, fontSize: 16),
                          ),
                          Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (_personCounter > 1) _personCounter--;
                                  });
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: _darkBlue),
                                  child: Center(
                                    child: Icon(
                                      Icons.remove_rounded,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "$_personCounter",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: _darkBlue),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() => _personCounter++);
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: _darkBlue),
                                  child: Center(
                                    child: Icon(
                                      Icons.add_rounded,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // TIP
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Tip",
                            style: TextStyle(
                                color: Colors.grey.shade700, fontSize: 16),
                          ),
                          Text(
                            "\$${(calculateTotalTip(_billAmount, _personCounter, _tipPercentage)).toStringAsFixed(2)}",
                            style: TextStyle(
                                color: _darkBlue,
                                fontWeight: FontWeight.w800,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Column(
                        children: [
                          Text(
                            "$_tipPercentage%",
                            style: TextStyle(
                                color: _darkBlue,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                          Slider(
                              min: 0,
                              max: 100,
                              divisions: 20,
                              activeColor: _darkBlue,
                              inactiveColor: _lighterBlue,
                              value: _tipPercentage.toDouble(),
                              onChanged: (double value) => _calculateTip(value))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _setBillAmount(String value) {
    try {
      setState(() {
        _billAmount = double.parse(value);
      });
    } catch (exception) {
      setState(() {
        _billAmount = 0;
      });
    }
  }

  _calculateTip(double value) {
    setState(() {
      _tipPercentage = value.round();
    });
  }

  calculateTotalPerPerson(int tipPercentage, double billAmount, int splitBy) {
    return ((calculateTotalTip(billAmount, splitBy, tipPercentage) +
                billAmount) /
            splitBy)
        .toStringAsFixed(2);
  }

  calculateTotalTip(double billAmount, int splitBy, int tipPercentage) {
    if (billAmount < 0 || billAmount.toString().isEmpty) return;
    return (billAmount * tipPercentage) / 100;
  }
}
