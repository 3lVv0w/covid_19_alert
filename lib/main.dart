import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class CovidThData {
  final int confirmed;
  final int recovered;
  final int hospitalized;
  final int deaths;
  final int newConfirm;
  final int newRecovered;
  final int newHospitalized;
  final int newDeaths;
  final String updateDated;
  final String source;

  CovidThData({
    this.confirmed,
    this.recovered,
    this.hospitalized,
    this.deaths,
    this.newConfirm,
    this.newRecovered,
    this.newHospitalized,
    this.newDeaths,
    this.updateDated,
    this.source,
  });

  factory CovidThData.fromJson(Map<String, dynamic> json) {
    return CovidThData(
      confirmed: json['Confirmed'] as int,
      recovered: json['Recovered'] as int,
      hospitalized: json['Hospitalized'] as int,
      deaths: json['Deaths'] as int,
      newConfirm: json['NewConfirmed'] as int,
      newRecovered: json['NewRecovered'] as int,
      newHospitalized: json['NewHospitalized'] as int,
      newDeaths: json['NewDeaths'] as int,
      updateDated: json['UpdateDate'] as String,
      source: json['Source'] as String,
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid-19 TH | Flutter for web',
      theme: ThemeData.dark(),
      home: CovidAlert(title: 'Covid-19 TH | Flutter for web'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CovidAlert extends StatefulWidget {
  CovidAlert({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _CovidAlertState createState() => _CovidAlertState();
}

class _CovidAlertState extends State<CovidAlert> {
  int confirmed,
      recovered,
      hospitalized,
      deaths,
      newConfirm,
      newRecovered,
      newHospitalized,
      newDeaths;

  String updateDated, source;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    Dio _dio = Dio();
    final covidResponse = await _dio.get(
      'https://covid19.th-stat.com/api/open/today',
    );

    if (covidResponse.statusCode == 200) {
      CovidThData data = CovidThData.fromJson(covidResponse.data);
      setState(() {
        confirmed = data.confirmed;
        recovered = data.recovered;
        hospitalized = data.hospitalized;
        deaths = data.deaths;
        newConfirm = data.newConfirm;
        newRecovered = data.newRecovered;
        newDeaths = data.newDeaths;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SelectableText('Total effect'),
            Text('${confirmed.toString()}'),
            Text('Total recovered'),
            Text('${recovered.toString()}'),
            Text('Total effect'),
            Text('${hospitalized.toString()}'),
            Text('Total Deaths'),
            Text('${deaths.toString()}'),
            Text('New Confirm'),
            Text('${newConfirm.toString()}'),
            Text('New Recoverd'),
            Text('${newRecovered.toString()}'),
            Text('Total effect'),
            Text('${newDeaths.toString()}'),
          ],
        ),
      ),
    );
  }
}
