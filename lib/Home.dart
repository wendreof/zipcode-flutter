import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _result = "Result!";
  TextEditingController _controller = TextEditingController();

  _getZipCode() async {
    String zip = _controller.text;
    String url = "https://viacep.com.br/ws/$zip/json";

    http.Response response;

    response = await http.get(url);
    Map<String, dynamic> ret = json.decode(response.body);
    String neigh = ret["bairro"];
    String street = ret["logradouro"];
    String state = ret["localidade"];

    setState(() {
      _result = "${street}, ${neigh}, ${state}";
    });

    //print("response: $neigh");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Services"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Type ur zip code. Example: 13874058"),
              style: TextStyle(fontSize: 20),
              controller: _controller,
            ),
            RaisedButton(
              child: Text('Click me'),
              onPressed: _getZipCode,
            ),
            Text(_result)
          ],
        ),
      ),
    );
  }
}
