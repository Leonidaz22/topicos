import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VentasPage extends StatefulWidget {
  @override
  _VentasPageState createState() => _VentasPageState();
}

class _VentasPageState extends State<VentasPage> {
  List<String> _productos = [];
  List<String> _carrito = [];
  Map<String, int> _cantidades =
      {}; // Almacena las cantidades deseadas para cada producto

  @override
  void initState() {
    super.initState();
    _loadProductos();
  }

  // Carga los productos almacenados en SharedPreferences
  void _loadProductos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _productos = prefs.getStringList('productos') ?? [];
      // Inicializa las cantidades de los productos en cero
      for (String producto in _productos) {
        _cantidades[producto] = 0;
      }
    });
  }

  // Agrega un producto al carrito
  void _agregarAlCarrito(String producto) {
    if (_cantidades[producto]! > 0) {
      setState(() {
        for (int i = 0; i < _cantidades[producto]!; i++) {
          _carrito.add(producto);
        }
        _cantidades[producto] =
            0; // Resetea la cantidad después de agregar al carrito
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            '$producto agregado al carrito. Cantidad: ${_cantidades[producto]}'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Por favor, ingrese una cantidad válida.'),
      ));
    }
  }

  // Finaliza la compra y muestra el ticket
  void _finalizarCompra() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Ticket de Compra'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ..._carrito.map((producto) => Text(producto)).toList(),
              SizedBox(height: 20),
              Text('Total: ${_carrito.length} productos'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _carrito
                      .clear(); // Limpiar el carrito después de mostrar el ticket
                });
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  // Método para mostrar el carrito
  void _mostrarCarrito() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Productos en el Carrito'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_carrito.isEmpty)
                Text('El carrito está vacío.')
              else
                ..._carrito.map((producto) => Text(producto)).toList(),
              SizedBox(height: 20),
              Text('Total: ${_carrito.length} productos'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ventas'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: _mostrarCarrito,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _productos.length,
              itemBuilder: (context, index) {
                final producto = _productos[index];
                return ListTile(
                  title: Text(producto),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 50,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: '0',
                          ),
                          onChanged: (value) {
                            setState(() {
                              _cantidades[producto] = int.tryParse(value) ?? 0;
                            });
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _agregarAlCarrito(producto),
                        child: Text('Agregar'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _carrito.isNotEmpty ? _finalizarCompra : null,
            child: Text('Finalizar Compra'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
