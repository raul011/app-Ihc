import 'package:flutter/material.dart';
import 'package:ihc_app/pages/navigation/compra/subcategorias_page.dart';
import 'package:ihc_app/pages/navigation/compra/todos_productos_page.dart';

class CategoriasPage extends StatefulWidget {
  const CategoriasPage({Key? key}) : super(key: key);

  @override
  State<CategoriasPage> createState() => _CategoriaPageState();
}

class _CategoriaPageState extends State<CategoriasPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              // Barra de búsqueda
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Buscar producto o marca',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Badge(
                      label: const Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: Colors.red,
                      child: const Icon(Icons.notifications_none),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Agiliza tu compra
              const Text(
                'Agiliza tu compra',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 15),
              // Grid de categorías destacadas (2x2)
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                padding: EdgeInsets.zero, // 👈 elimina espacio extra arriba
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _categoriaDestacadaCard(
                    nombre: 'cocina',
                    titulo: 'Lo que nunca falta en tu cocina',
                    color: const Color.fromARGB(255, 255, 107, 53),
                    imagen: Icons.kitchen,
                  ),
                  _categoriaDestacadaCard(
                    nombre: 'bebidas',
                    titulo: 'Para cada momento, una bebida ideal',
                    color: const Color.fromARGB(255, 26, 188, 156),
                    imagen: Icons.local_drink,
                  ),
                  _categoriaDestacadaCard(
                    nombre: 'bebes',
                    titulo: 'Productos suaves como su ternura',
                    color: const Color.fromARGB(255, 52, 73, 211),
                    imagen: Icons.child_care,
                  ),
                  _categoriaDestacadaCard(
                    nombre: 'cuidado',
                    titulo: 'Limpieza, frescura y bienestar en cada uso',
                    color: const Color.fromARGB(255, 186, 85, 211),
                    imagen: Icons.spa,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Categorías
              const Text(
                'Categorías',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 15),
              // Grid de categorías
              GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                padding: EdgeInsets.zero, // 👈 elimina espacio extra arriba
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 0.75,
                children: [
                  _categoriaItem(nombre: 'despensa', icono: Icons.fastfood),
                  _categoriaItem(nombre: 'bebidas', icono: Icons.local_bar),
                  _categoriaItem(nombre: 'higiene', icono: Icons.shower),
                  _categoriaItem(nombre: 'bebes', icono: Icons.child_care),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoriaDestacadaCard({
    required String nombre,
    required String titulo,
    required Color color,
    required IconData imagen,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => const ProductDetailScreen(
                  categoryTitle: 'alguna categoría',
                ),
          ),
        );

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(titulo)));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage('assets/imagenes/destacados_$nombre.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // 👇 Franja sólida en la parte inferior
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 45,
              child: Container(
                decoration: BoxDecoration(
                  color: color.withOpacity(0.70), // 👈 color sólido
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(16),
                  ),
                ),
              ),
            ),

            // 👇 Contenido (icono + texto)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/categoria_${titulo.hashCode}.jpg',
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        imagen,
                        color: const Color.fromARGB(255, 233, 83, 14),
                        size: 32,
                      );
                    },
                  ),
                  Text(
                    titulo,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      height: 0.9,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoriaItem({required String nombre, required IconData icono}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProductListScreen()),
        );
        final messenger = ScaffoldMessenger.of(context);
        messenger.hideCurrentSnackBar();
        messenger.showSnackBar(SnackBar(content: Text(nombre)));
      },
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // 👈 centra dentro de la celda
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[100],
              border: Border.all(
                color: const Color.fromARGB(255, 214, 212, 212),
                width: 2,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/imagenes/categoria_$nombre.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(icono, color: Colors.blue, size: 28);
                },
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            nombre,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
