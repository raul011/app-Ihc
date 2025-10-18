import 'package:flutter/material.dart';
import 'package:ihc_app/pages/entrega/confirmar_entrega_page.dart';

class CarritoPage extends StatefulWidget {
  const CarritoPage({Key? key}) : super(key: key);

  @override
  State<CarritoPage> createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarritoPage> {
  List<CartItem> cartItems = [
    CartItem(
      id: '1',
      name: '[Carne y Embutidos] Leche Entera 1L',
      description: 'Leche Entera 1L',
      price: 35,
      quantity: 1,
      store: 'Tienda de Productos',
      imageUrl: 'assets/milk.png',
    ),
    CartItem(
      id: '2',
      name: '[Carne y Embutidos] Leche Entera 1L',
      description: 'Leche Entera 1L',
      price: 35,
      quantity: 1,
      store: 'Tienda de Productos',
      imageUrl: 'assets/milk.png',
    ),
    CartItem(
      id: '3',
      name: '[Carne y Embutidos] Leche Entera 1L',
      description: 'Leche Entera 1L',
      price: 35,
      quantity: 1,
      store: 'Tienda de Productos',
      imageUrl: 'assets/milk.png',
    ),
    CartItem(
      id: '4',
      name: '[Carne y Embutidos] Leche Entera 1L',
      description: 'Leche Entera 1L',
      price: 35,
      quantity: 1,
      store: 'Tienda de Productos',
      imageUrl: 'assets/milk.png',
    ),
  ];

  bool selectAll = false;
  String couponCode = '';

  int get totalItems => cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice {
    return cartItems.fold(0, (sum, item) {
      if (item.isSelected) {
        return sum + (item.price * item.quantity);
      }
      return sum;
    });
  }

  void toggleSelectAll(bool? value) {
    setState(() {
      selectAll = value ?? false;
      for (var item in cartItems) {
        item.isSelected = selectAll;
      }
    });
  }

  void toggleItemSelection(int index, bool? value) {
    setState(() {
      cartItems[index].isSelected = value ?? false;
      selectAll = cartItems.every((item) => item.isSelected);
    });
  }

  void updateQuantity(int index, int change) {
    setState(() {
      int newQuantity = cartItems[index].quantity + change;
      if (newQuantity > 0) {
        cartItems[index].quantity = newQuantity;
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE53935), Color(0xFFC62828)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            if (index == 0 ||
                                cartItems[index].store !=
                                    cartItems[index - 1].store) {
                              return Column(
                                children: [
                                  _buildStoreHeader(cartItems[index].store),
                                  _buildCartItem(index),
                                ],
                              );
                            }
                            return _buildCartItem(index);
                          },
                        ),
                      ),
                      _buildCouponSection(),
                      _buildFooter(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Carrito de compra',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
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

  Widget _buildStoreHeader(String storeName) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Radio<bool>(
            value: true,
            groupValue: selectAll,
            onChanged: (value) {},
            activeColor: Colors.red,
          ),
          const Icon(Icons.storefront, color: Colors.grey, size: 20),
          const SizedBox(width: 8),
          Text(
            storeName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        ],
      ),
    );
  }

  Widget _buildCartItem(int index) {
    final item = cartItems[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Radio<bool>(
            value: true,
            groupValue: item.isSelected,
            onChanged: (value) => toggleItemSelection(index, value),
            activeColor: Colors.red,
          ),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              item.imageUrl,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.local_drink,
                  size: 40,
                  color: Colors.blue[200],
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  item.description,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${item.price}\$',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    Row(
                      children: [
                        _buildQuantityButton(
                          Icons.add,
                          () => updateQuantity(index, 1),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            '${item.quantity}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        _buildQuantityButton(
                          Icons.remove,
                          () => updateQuantity(index, -1),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () => removeItem(index),
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                            size: 22,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(icon, size: 16, color: Colors.grey[700]),
      ),
    );
  }

  Widget _buildCouponSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ingrese Código de cupón Válido',
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      couponCode = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  // Aplicar cupón
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Aplicar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Radio<bool>(
            value: true,
            groupValue: selectAll,
            onChanged: toggleSelectAll,
            activeColor: Colors.red,
          ),
          const Text('Seleccionar todo', style: TextStyle(fontSize: 14)),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Total:',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Text(
                '${totalPrice.toInt()}\$',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: () {
              // Procesar pago
              /*
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ConfirmarEntregaScreen(),
                ),
              );
              */
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConfirmarEntregaScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Pagar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Modelo de datos para items del carrito
class CartItem {
  final String id;
  final String name;
  final String description;
  final int price;
  int quantity;
  final String store;
  final String imageUrl;
  bool isSelected;

  CartItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.store,
    required this.imageUrl,
    this.isSelected = false,
  });
}
