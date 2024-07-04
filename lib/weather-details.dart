import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherDetails extends StatefulWidget {
  String city = "";
  WeatherDetails(this.city);

  @override
  State<WeatherDetails> createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails> {
  var weatherData;
  @override
  void initState() {
    super.initState();
    print("*********");
    getData(widget.city);
  }

  getData(String city) {
    print("Getting weather of " + city);
    String url =
        "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=8d0b498e0c23baa87d38280bb3847c44";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        print(resp.body);
        this.weatherData = json.decode(resp.body);
        print(this.weatherData);
        //print(weatherData['list']);
      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather of ${widget.city}',
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: (weatherData == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: weatherData == null ? 0 : weatherData.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.deepOrangeAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                              "images/${weatherData['weather'][0]['main'].toString().toLowerCase()}.jpg"),
                        ),
                        Text(
                          weatherData['dt'].toString(),
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          weatherData['main']['temp'].toString(),
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
