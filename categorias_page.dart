import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoriasPage extends StatefulWidget {
  @override
  _CategoriasPageState createState() => _CategoriasPageState();
}

class _CategoriasPageState extends State<CategoriasPage> {
  List<String> _categorias = [];
  String? selectedCategoria;

  @override
  void initState() {
    super.initState();
    _loadCategorias();
  }

  // Carga las categorías almacenadas en SharedPreferences
  void _loadCategorias() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _categorias = prefs.getStringList('categorias') ?? [];
    });
  }

  // Guarda las categorías en SharedPreferences
  void _saveCategorias() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('categorias', _categorias);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorías'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _categorias.length,
              itemBuilder: (context, index) {
                final categoria = _categorias[index];
                return ListTile(
                  title: Text(categoria),
                  selected: selectedCategoria == categoria,
                  onTap: () {
                    setState(() {
                      selectedCategoria = categoria;
                    });
                  },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _agregarCategoria(context),
                child: Text('Agregar'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: selectedCategoria != null
                    ? _eliminarCategoria
                    : null, // Solo habilitado si hay una categoría seleccionada
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

  void _agregarCategoria(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Agregar Categoría'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Nombre de la categoría'),
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
                setState(() {
                  _categorias.add(_controller.text);
                  _saveCategorias(); // Guardar categorías después de agregar
                });
                Navigator.of(context).pop();
              },
              child: Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  void _eliminarCategoria() {
    setState(() {
      _categorias.remove(selectedCategoria);
      _saveCategorias(); // Guardar cambios después de eliminar
      selectedCategoria = null;
    });
  }
}
