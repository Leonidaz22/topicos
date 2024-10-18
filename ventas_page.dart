import 'package:flutter/material.dart';

class VentasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ventas'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text(
          'Aquí se mostrarán las ventas',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
