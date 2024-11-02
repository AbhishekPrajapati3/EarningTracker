import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Model/EarningsData.dart';
import 'EarningsTranscriptScreen.dart';

class EarningsHomePage extends StatefulWidget {
  @override
  _EarningsHomePageState createState() => _EarningsHomePageState();
}

class _EarningsHomePageState extends State<EarningsHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState(

    );
  }
  final TextEditingController _controller = TextEditingController();
  List<EarningsData> _earningsData = [];

  Future<void> _fetchEarningsData(String ticker) async {
    final response = await http.get(Uri.parse('https://api.api-ninjas.com/v1/earningscalendar?ticker=$ticker'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _earningsData = data.map((e) => EarningsData.fromJson(e)).toList();
      });
    } else {
      throw Exception('Failed to load earnings data');
    }
  }

  void _onPointTapped(String date,String ticker) {

    DateTime dateTime = DateTime.parse(date);
    int year = dateTime.year;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EarningsTranscriptScreen(ticker: ticker, year:year, quarter:getQuarter(dateTime)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Icon(Icons.menu,color: Colors.white,),backgroundColor: Colors.cyan,centerTitle:true,title: Text("Earning Graph",style: TextStyle(color: Colors.white),),actions: [Padding(
        padding:  EdgeInsets.only(right:8),
        child: Icon(Icons.notifications,color: Colors.white,),
      )],),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.cyan[700],
                  border: Border.all(color: Colors.cyan.shade900),borderRadius: BorderRadius.circular(25)),
              child: Padding(
                padding: const EdgeInsets.only(left: 25,),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                  enableSuggestions: false,
                        obscureText: false,
                        style: TextStyle(color: Colors.white,fontSize: 15),
                        controller: _controller,
                        decoration: InputDecoration(fillColor: Colors.white,border: InputBorder.none,labelText:'Enter Company Ticker (e.g., MSFT)',labelStyle: TextStyle(color: Colors.white,fontSize: 14)),
                      ),
                    ),
                    IconButton(onPressed: (){
                      _fetchEarningsData(_controller.text);

                    }, icon:Icon(Icons.search,color: Colors.white,))
                  ],
                ),
              ),
            ),
            Expanded(
              child: _earningsData.isNotEmpty && _earningsData[0].ticker== _controller.text
                  ? SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                legend: Legend(isVisible: true,position: LegendPosition.bottom,textStyle: TextStyle(color: Colors.black45)),
                title: ChartTitle(text: '${_controller.text}',textStyle: TextStyle(color: Colors.teal[900],fontWeight:FontWeight.bold,)),
                series: <CartesianSeries<EarningsData, String>>[
                  LineSeries<EarningsData, String>(
                    dataSource: _earningsData,
                    xValueMapper: (EarningsData data, _) => data.pricedate,
                    yValueMapper: (EarningsData data, _) => data.estimated_revenue,
                    color: Colors.teal,
                    legendIconType: LegendIconType.seriesType,
                    isVisibleInLegend: true,
                    markerSettings: MarkerSettings(isVisible: true),
                    name: 'Estimated Earnings',
                    onPointTap: (var details) {
                      CartesianChartPoint cartesianChartPoint = CartesianChartPoint();
                      cartesianChartPoint = details.dataPoints![details.pointIndex!.toInt()];
                      DateTime date = DateTime.parse(cartesianChartPoint.x);
                      _onPointTapped(cartesianChartPoint.x,_controller.text);
                    },
                  ),
                  LineSeries<EarningsData, String>(
                    dataSource: _earningsData,
                    xValueMapper: (EarningsData data, _) => data.pricedate,
                    yValueMapper: (EarningsData data, _) => data.actual_revenue,
                    markerSettings: MarkerSettings(isVisible: true),
                    isVisibleInLegend: true ,
                    legendIconType: LegendIconType.seriesType,
                    name: 'Actual Earnings',
                    onPointTap: (var details) {
                      CartesianChartPoint cartesianChartPoint = CartesianChartPoint();
                      cartesianChartPoint = details.dataPoints![details.pointIndex!.toInt()];
                      DateTime date = DateTime.parse(cartesianChartPoint.x);
                     _onPointTapped(cartesianChartPoint.x,_controller.text);
                    },
                  ),
                ],
              )
                  : Center(child:CircularProgressIndicator()),
            ),
            //Card(child: Row(children: [Text()],),)
          ],
        ),
      ),
    );
  }

  int getQuarter(DateTime dateTime)
  {
    int month = dateTime.month;
    if(month<=3)
      return 1;
    else if(month<=6)
      return 2;
    else if(month<=9)
      return 3;
    else if(month<=12)
      return 4;
    return 0 ;
  }
}