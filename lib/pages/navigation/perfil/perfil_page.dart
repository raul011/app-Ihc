import 'package:flutter/material.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header rojo con datos de usuario
            Container(
              color: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Mi cuenta',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hola, Raul Alberto!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'raulalbertogut@gmail.com',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Opciones del menú
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _menuItem(
                    icon: Icons.person_outline,
                    title: 'Mi información',
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _menuItem(
                    icon: Icons.shopping_bag_outlined,
                    title: 'Mis pedidos',
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _menuItem(
                    icon: Icons.location_on_outlined,
                    title: 'Direcciones',
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _menuItem(
                    icon: Icons.credit_card_outlined,
                    title: 'Tarjetas de Crédito',
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _menuItem(
                    icon: Icons.description_outlined,
                    title: 'Términos y Condiciones',
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _menuItem(
                    icon: Icons.logout,
                    title: 'Cerrar Sesión',
                    titleColor: Colors.red,
                    onTap: () {
                      _mostrarConfirmacionCerrarSesion();
                    },
                  ),
                  const SizedBox(height: 12),
                  _menuItem(
                    icon: Icons.delete_outline,
                    title: 'Eliminar Cuenta',
                    titleColor: Colors.red,
                    onTap: () {
                      _mostrarConfirmacionEliminar();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color titleColor = Colors.black87,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: titleColor == Colors.red ? Colors.red : Colors.grey[600],
                  size: 24,
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: titleColor,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarConfirmacionCerrarSesion() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sesión cerrada')),
              );
            },
            child: const Text(
              'Cerrar sesión',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _mostrarConfirmacionEliminar() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar cuenta'),
        content: const Text(
          'Esta acción no se puede deshacer. ¿Estás seguro de que deseas eliminar tu cuenta?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cuenta eliminada')),
              );
            },
            child: const Text(
              'Eliminar',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}