import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:readmore/readmore.dart';
class EarningsTranscriptScreen extends StatelessWidget {
  final String ticker;
  final int year;
  final int quarter;

  EarningsTranscriptScreen({required this.ticker, required this.year, required this.quarter});

  Future<String> _fetchEarningsTranscript() async {
    final response = await http.get(Uri.parse('https://api.api-ninjas.com/v1/earningstranscript?ticker=$ticker&year=$year&quarter=$quarter'));

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load earnings transcript');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Earnings Transcript'),backgroundColor: Colors.blue,),
      body: FutureBuilder(
        future: _fetchEarningsTranscript(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container( height: MediaQuery.of(context).size.height*.80,
                child: Card( borderOnForeground: true,color: Colors.grey.shade400,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 14),
                      child: ReadMoreText(snapshot.data!,
                        trimMode: TrimMode.Line,
                        trimLines: 27,
                        colorClickableText: Colors.pink,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        style: TextStyle(fontSize: 16),
                        moreStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}