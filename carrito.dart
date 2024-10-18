import 'package:proyecto_topicos/producto.dart';

class Carrito {
  List<Producto> productos = [];

  void agregarProducto(Producto producto) {
    productos.add(producto);
  }

  void eliminarProducto(Producto producto) {
    productos.remove(producto);
  }

  double calcularTotal() {
    return productos.fold(0, (total, item) => total + item.precio);
  }

  List<Producto> obtenerProductos() {
    return productos;
  }
}
