import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductosPage extends StatefulWidget {
  @override
  _ProductosPageState createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {
  List<String> _productos = [];
  List<String> _categorias = [];
  String? selectedCategoria;

  @override
  void initState() {
    super.initState();
    _loadProductos();
    _loadCategorias();
  }

  // Carga los productos almacenados en SharedPreferences
  void _loadProductos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _productos = prefs.getStringList('productos') ?? [];
    });
  }

  // Carga las categorías almacenadas en SharedPreferences
  void _loadCategorias() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _categorias = prefs.getStringList('categorias') ?? [];
    });
  }

  // Guarda los productos en SharedPreferences
  void _saveProductos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('productos', _productos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        backgroundColor: Colors.blue,
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
                  onTap: () {
                    // Lógica para editar el producto
                    _editarProducto(index);
                  },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _agregarProducto(context),
                child: Text('Agregar'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: _eliminarProducto,
                child: Text('Eliminar'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  void _agregarProducto(BuildContext context) {
    TextEditingController nombreController = TextEditingController();
    TextEditingController precioController = TextEditingController();
    TextEditingController cantidadController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Agregar Producto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nombreController,
                decoration: InputDecoration(labelText: 'Nombre del Producto'),
              ),
              TextField(
                controller: precioController,
                decoration: InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: cantidadController,
                decoration: InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
              ),
              DropdownButton<String>(
                hint: Text('Selecciona una categoría'),
                value: selectedCategoria,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategoria = newValue;
                  });
                },
                items: _categorias
                    .map<DropdownMenuItem<String>>((String categoria) {
                  return DropdownMenuItem<String>(
                    value: categoria,
                    child: Text(categoria),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nombreController.text.isNotEmpty &&
                    precioController.text.isNotEmpty &&
                    cantidadController.text.isNotEmpty &&
                    selectedCategoria != null) {
                  String producto =
                      '${nombreController.text} - ${precioController.text} - ${cantidadController.text} - $selectedCategoria';
                  setState(() {
                    _productos.add(producto);
                    _saveProductos(); // Guardar productos después de agregar
                  });
                  Navigator.of(context).pop();
                } else {
                  // Mostrar mensaje de error si los campos están vacíos
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Por favor completa todos los campos.'),
                  ));
                }
              },
              child: Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  void _eliminarProducto() {
    // Lógica para eliminar el producto seleccionado (no implementada en este ejemplo)
  }

  void _editarProducto(int index) {
    // Lógica para editar el producto (no implementada en este ejemplo)
  }
}
