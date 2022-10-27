import 'package:flutter/material.dart';
import 'package:graph_wrapper/graph_wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final data = {
    "name": "line",
    "dados": {
      "title": "Totais mês 10/2022",
      "label_format": "{value}",
      "values": [
        {"subtitle": "Vendas", "division": 2019, "value": 100, "type": "int"},
        {"subtitle": "Compras", "division": 2019, "value": 50, "type": "int"},
        {"subtitle": "Vendas", "division": 2020, "value": 120, "type": "int"},
        {"subtitle": "Compras", "division": 2020, "value": 60, "type": "int"},
        {"subtitle": "Vendas", "division": 2021, "value": 90, "type": "int"},
        {"subtitle": "Compras", "division": 2021, "value": 35, "type": "int"},
        {"subtitle": "Vendas", "division": 2022, "value": 105, "type": "int"},
        {"subtitle": "Compras", "division": 2022, "value": 65, "type": "int"}
      ]
    }
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
      ),
      body: Center(
        child: GraphWrapperData.fromMap(data).build(),
      ),
    );
  }
}
