import 'package:flutter/material.dart';
import 'package:proyecto_topicos/categorias_page.dart';
import 'package:proyecto_topicos/productospage.dart';
import 'package:proyecto_topicos/ventaspage.dart'; // Importa la clase VentasPage

class AlmacenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Almacén'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _almacenOption(
                  context, 'Productos', Icons.inventory, Colors.orange),
              SizedBox(height: 20),
              _almacenOption(
                  context, 'Categorías', Icons.category, Colors.blue),
              SizedBox(height: 20),
              _almacenOption(context, 'Ventas', Icons.attach_money,
                  Colors.red), // Nuevo botón de ventas
            ],
          ),
        ),
      ),
    );
  }

  Widget _almacenOption(
      BuildContext context, String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        if (title == 'Categorías') {
          // Redirige a la página de categorías
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CategoriasPage()),
          );
        } else if (title == 'Productos') {
          // Navega a la página de productos
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductosPage()),
          );
        } else if (title == 'Ventas') {
          // Redirige a la página de ventas
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VentasPage()),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.7),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
