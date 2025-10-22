import 'package:flutter/material.dart';
// Importa tu ProductListScreen aquí
import 'package:ihc_app/pages/navigation/compra/subcategorias_page.dart';
import 'package:ihc_app/pages/navigation/home/promo_bane_widget.dart';
import 'package:ihc_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

// import 'package:tu_app/screens/product_list_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> categorias = const [
    {
      "nombre": "Productos nuevos",
      "productos": [
        {
          "imagen": "assets/imagenes/categoria-despensa/imagen_aceite1.png",
          "nombre": "Aceite de Oliva Extra Virgen",
          "descripcion": "Botella 500ml",
          "precio": "BS 15",
          "descuento": "-10%",
        },
        {
          "imagen": "assets/imagenes/categoria-despensa/imagen-vinagre2.png",
          "nombre": "Vinagre de Manzana",
          "descripcion": "Natural 1L",
          "precio": "BS 18",
          "descuento": "-15%",
        },
        {
          "imagen": "assets/imagenes/categoria-despensa/imagen_aceite2.png",
          "nombre": "Vinagre de Manzana",
          "descripcion": "Natural 1L",
          "precio": "BS 18",
          "descuento": "-15%",
        },
        {
          "imagen": "assets/imagenes/categoria-despensa/imagen_vinagre1.png",
          "nombre": "Vinagre de Manzana",
          "descripcion": "Natural 1L",
          "precio": "BS 18",
          "descuento": "-15%",
        },
        {
          "imagen": "assets/imagenes/categoria-despensa/imagen_aceite3.png",
          "nombre": "Vinagre de Manzana",
          "descripcion": "Natural 1L",
          "precio": "BS 18",
          "descuento": "-15%",
        },
        {
          "imagen": "assets/imagenes/categoria-despensa/imagen_vinagre3.png",
          "nombre": "Vinagre de Manzana",
          "descripcion": "Natural 1L",
          "precio": "BS 18",
          "descuento": "-15%",
        },
      ],
    },
    {
      "nombre": "Productos en promo",
      "productos": [
        {
          "imagen": "assets/imagenes/categoria-despensa/imagen_arroz1.png",
          "nombre": "Arroz Premium 5kg",
          "descripcion": "Grano largo",
          "precio": "BS 60",
          "descuento": "-20%",
        },
        {
          "imagen": "assets/imagenes/categoria-despensa/imagen_grano1.png",
          "nombre": "Lentejas",
          "descripcion": "Bolsa 1kg",
          "precio": "BS 25",
          "descuento": "-10%",
        },
        {
          "imagen": "assets/imagenes/categoria-despensa/imagen_arroz2.png",
          "nombre": "Arroz Premium 5kg",
          "descripcion": "Grano largo",
          "precio": "BS 60",
          "descuento": "-20%",
        },
        {
          "imagen": "assets/imagenes/categoria-despensa/imagen_grano2.png",
          "nombre": "Lentejas",
          "descripcion": "Bolsa 1kg",
          "precio": "BS 25",
          "descuento": "-10%",
        },
        {
          "imagen": "assets/imagenes/categoria-despensa/imagen_arroz3.png",
          "nombre": "Arroz Premium 5kg",
          "descripcion": "Grano largo",
          "precio": "BS 60",
          "descuento": "-20%",
        },
        {
          "imagen": "assets/imagenes/categoria-despensa/imagen_grano3.png",
          "nombre": "Lentejas",
          "descripcion": "Bolsa 1kg",
          "precio": "BS 25",
          "descuento": "-10%",
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildExclusiveCouponsBanner(),
            //_buildPromoBanner(),
            PromoBanner(
              images: [
                'assets/imagenes/promo_banner3.png',
                'assets/imagenes/promo_banner1.jpeg',
                'assets/imagenes/promo_banner4.png',
              ],
            ),
            _buildCategories(context),
            // 🔹 Aquí recorres la lista de categorias
            ...categorias.map((categoria) {
              return _buildProductSection(
                context, // <-- Pasamos el context
                categoria["nombre"] as String,
                categoria["productos"] as List,
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  static Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey[400]),
                  const SizedBox(width: 8),
                  Text(
                    '¿Que estas buscando Raul?',
                    style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Stack(
            children: [
              Icon(
                Icons.notifications_outlined,
                color: Colors.grey[700],
                size: 28,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildExclusiveCouponsBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.pink[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.red[400],
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.local_offer, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '¡Cupones Exclusivos!',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Hasta 20% off en productos seleccionados',
                  style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    final categories = [
      {'nombre': 'despensa', 'icono': Icons.shopping_basket},
      {'nombre': 'bebidas', 'icono': Icons.local_drink},
      {'nombre': 'higiene', 'icono': Icons.face},
      {'nombre': 'bebes', 'icono': Icons.child_care},
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Descubra nuestras categorias',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
                categories.map((category) {
                  return _categoriaItem(
                    context: context,
                    nombre: category['nombre'] as String,
                    icono: category['icono'] as IconData,
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _categoriaItem({
    required BuildContext context,
    required String nombre,
    required IconData icono,
  }) {
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[100],
              border: Border.all(
                color: const Color.fromARGB(255, 219, 219, 219),
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

  Widget _buildProductSection(
    BuildContext context,
    String title,
    List productos,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título de categoría
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        // Lista horizontal de productos
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: productos.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: _buildProductCard(context, productos[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, Map producto) {
    return Container(
      width: 140,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Stack(
                children: [
                  // Imagen del producto
                  Center(
                    child: Image.asset(
                      producto['imagen'],
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.shopping_bag,
                          size: 60,
                          color: Colors.grey[400],
                        );
                      },
                    ),
                  ),
                  // Descuento
                  if (producto['descuento'] != null &&
                      producto['descuento'].toString().isNotEmpty)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  // Favorito

                  // Botón flotante "+"
                  Positioned(
                    bottom: 6,
                    right: 6,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 187, 2, 2),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        ),
                        onPressed: () {
                          // 1. Crea un objeto Product desde el mapa
                          final product = Product(
                            nombre: producto['nombre'],
                            descripcion: producto['descripcion'],
                            precio: producto['precio'],
                            imagen: producto['imagen'],
                            descuento: producto['descuento'],
                          );

                          // 2. Accede al CartProvider y añade el producto
                          Provider.of<CartProvider>(
                            context,
                            listen: false,
                          ).addProduct(product);

                          // 3. Muestra una confirmación
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${product.nombre} añadido al carrito',
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Info del producto
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  producto['precio'],
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  producto['nombre'],
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  producto['descripcion'],
                  style: TextStyle(fontSize: 9, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
