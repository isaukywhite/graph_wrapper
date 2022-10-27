import 'package:flutter/material.dart';
import 'package:map_fields/map_fields.dart';

import 'widget/graph_wrapper_line_widget.dart';

class GraphWrapperData {
  final String name;
  final Map<String, dynamic> dados;
  GraphWrapperData({
    required this.name,
    required this.dados,
  });

  factory GraphWrapperData.fromMap(Map<String, dynamic> map) {
    final f = MapFields.load(map);
    return GraphWrapperData(
      name: f.getString('name', 'not_found'),
      dados: f.getMap<String, dynamic>('dados', {}),
    );
  }

  Widget build() {
    if (dados.keys.isEmpty) {
      return const Text('Nenhuma informação de dados.');
    }
    switch (name) {
      case 'line':
        final graph = GraphWrapperLineWidget.fromMap(dados);
        return graph.build();
      case 'not_found':
        return const Text('Campo nome não encontrado.');
      default:
        return const Text('Sem informação...');
    }
  }
}
