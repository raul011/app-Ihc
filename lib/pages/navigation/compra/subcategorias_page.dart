import 'package:flutter/material.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  // 🔹 Simulación de JSON en memoria
  final List<Map<String, dynamic>> categorias = const [
    {
      "nombre": "Aceites y Vinagres",
      "productos": [
        {
          "imagen": "assets/imagenes/categoria-despensa/imagen_aceite1.png",
          "nombre": "Aceite de Oliva Extra Virgen",
          "descripcion": "Botella 500ml",
          "precio": "BS 45",
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
      "nombre": "Arroz y Granos",
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
    {
      "nombre": "Café y Té",
      "productos": [
        {
          "imagen": "assets/imagenes/categoria-despensa/imagen_cafe1.png",
          "nombre": "Café Molido",
          "descripcion": "Paquete 500g",
          "precio": "BS 35",
          "descuento": "-25%",
        },
        {
          "imagen": "assets/imagenes/categoria-despensa/imagen_te1.png",
          "nombre": "Té Verde",
          "descripcion": "Caja 20 sobres",
          "precio": "BS 15",
          "descuento": "-5%",
        },
        {
          "imagen": "assets/imagenes/categoria-despensa/imagen_cafe2.png",
          "nombre": "Café Molido",
          "descripcion": "Paquete 500g",
          "precio": "BS 35",
          "descuento": "-25%",
        },
        {
          "imagen": "assets/imagenes/categoria-despensa/imagen_te2.png",
          "nombre": "Té Verde",
          "descripcion": "Caja 20 sobres",
          "precio": "BS 15",
          "descuento": "-5%",
        },
        {
          "imagen": "assets/imagenes/categoria-despensa/imagen_cafe3.png",
          "nombre": "Café Molido",
          "descripcion": "Paquete 500g",
          "precio": "BS 35",
          "descuento": "-25%",
        },
        {
          "imagen": "assets/imagenes/categoria-despensa/imagen_te3.png",
          "nombre": "Té Verde",
          "descripcion": "Caja 20 sobres",
          "precio": "BS 15",
          "descuento": "-5%",
        },
        {
          "imagen": "assets/imagenes/categoria-despensa/imagen_te4.png",
          "nombre": "Té Verde",
          "descripcion": "Caja 20 sobres",
          "precio": "BS 15",
          "descuento": "-5%",
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Productos"),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children:
              categorias.map((categoria) {
                return _buildProductSection(
                  categoria["nombre"],
                  categoria["productos"],
                );
              }).toList(),
        ),
      ),
    );
  }

  // 🔹 Sección de productos por categoría
  Widget _buildProductSection(String title, List productos) {
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
              const Text(
                "Ver todos",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
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
                child: _buildProductCard(productos[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(Map producto) {
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
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Stack(
                children: [
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
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      child: Text(
                        producto['descuento'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
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
                        color: const Color.fromARGB(255, 187, 2, 2), // rojo
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
                          // Aquí puedes integrar con tu Provider del carrito
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
