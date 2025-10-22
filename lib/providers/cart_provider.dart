// lib/providers/cart_provider.dart

import 'package:flutter/material.dart';

// Modelo para representar un producto
class Product {
  final String imagen;
  final String nombre;
  final String descripcion;
  final String precio;
  final String? descuento;

  Product({
    required this.imagen,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    this.descuento,
  });
}

// Modelo para los items dentro del carrito, que incluye la cantidad
class CartItem {
  final String id; // Usaremos el nombre del producto como ID único
  final Product product;
  int quantity;
  bool isSelected;

  CartItem({
    required this.id,
    required this.product,
    this.quantity = 1,
    this.isSelected = true,
  });

  // Helper para convertir el precio String a double (ej: "BS 45" -> 45.0)
  double get priceAsDouble {
    return double.tryParse(product.precio.replaceAll(RegExp(r'[^0-9.]'), '')) ??
        0.0;
  }
}

// El cerebro del carrito
class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  double get totalPrice {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      if (cartItem.isSelected) {
        total += cartItem.priceAsDouble * cartItem.quantity;
      }
    });
    return total;
  }

  void addProduct(Product product) {
    // Si el producto ya está en el carrito, solo aumenta la cantidad
    if (_items.containsKey(product.nombre)) {
      _items.update(
        product.nombre,
        (existingItem) => CartItem(
          id: existingItem.id,
          product: existingItem.product,
          quantity: existingItem.quantity + 1,
          isSelected: existingItem.isSelected,
        ),
      );
    } else {
      // Si es un producto nuevo, lo añade al mapa
      _items.putIfAbsent(
        product.nombre,
        () => CartItem(id: product.nombre, product: product),
      );
    }
    // Notifica a todos los widgets que están "escuchando" que el carrito ha cambiado.
    notifyListeners();
  }

  void updateQuantity(String productId, int newQuantity) {
    if (_items.containsKey(productId)) {
      if (newQuantity > 0) {
        _items.update(
          productId,
          (existing) => existing..quantity = newQuantity,
        );
      } else {
        // Si la cantidad es 0 o menos, elimina el item
        _items.remove(productId);
      }
      notifyListeners();
    }
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void toggleItemSelection(String productId, bool isSelected) {
    if (_items.containsKey(productId)) {
      _items.update(productId, (existing) => existing..isSelected = isSelected);
      notifyListeners();
    }
  }

  void toggleSelectAll(bool selectAll) {
    _items.forEach((key, item) {
      item.isSelected = selectAll;
    });
    notifyListeners();
  }
}
