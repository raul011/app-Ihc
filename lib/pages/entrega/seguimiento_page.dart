import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ihc_app/pages/navigation/compra/detalle_compra_page.dart';

class SeguimientoScreen extends StatefulWidget {
  const SeguimientoScreen({Key? key}) : super(key: key);

  @override
  State<SeguimientoScreen> createState() => _SeguimientoScreenState();
}

class _SeguimientoScreenState extends State<SeguimientoScreen> {
  GoogleMapController? _mapController;

  // Coordenadas de ejemplo
  final LatLng _origen = const LatLng(-17.780603, -63.180795); // Vehículo
  final LatLng _destino = const LatLng(-17.7890, -63.1800); // Destino

  // Variables para los íconos personalizados
  BitmapDescriptor _vehiculoIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor _destinoIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    super.initState();
    _cargarIconosPersonalizados();
  }

  // Carga los íconos desde los assets
  void _cargarIconosPersonalizados() async {
    // Asegúrate de que las rutas a tus imágenes sean correctas
    final vehiculoIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(100, 100)),
      'assets/imagenes/icon4.png',
    );
    final destinoIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/iconos/destino.png',
    );

    // Actualiza el estado para que el mapa se redibuje con los nuevos íconos
    setState(() {
      _vehiculoIcon = vehiculoIcon;
      _destinoIcon = destinoIcon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌍 Mapa ocupando toda la pantalla
          GoogleMap(
            initialCameraPosition: CameraPosition(target: _origen, zoom: 15),
            markers: {
              Marker(
                markerId: const MarkerId("vehiculo"),
                position: _origen,
                icon: _vehiculoIcon, // <-- Usamos el ícono personalizado
              ),
              Marker(
                markerId: const MarkerId("destino"),
                position: _destino,
                icon: _destinoIcon, // <-- Usamos el ícono personalizado
              ),
            },
            polylines: {
              Polyline(
                polylineId: const PolylineId("ruta"),
                color: Colors.blue,
                width: 5,
                points: [_origen, _destino],
              ),
            },
            onMapCreated: (controller) {
              _mapController = controller;
            },
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          ),

          // 📋 Panel inferior con info del pedido
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Fila con foto, nombre y botones
                  Row(
                    children: [
                      // Foto del conductor
                      ClipOval(
                        child: Image.asset(
                          'assets/imagenes/repartidor.jpg', // Asegúrate que esta imagen exista
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            // En caso de error al cargar la imagen, muestra el ícono
                            return CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.grey[300],
                              child: const Icon(Icons.person, size: 30),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Nombre y fecha
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Alberto Aguilar",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "4 Oct 2025 10:45",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Botones de acción
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.phone),
                          onPressed: () {},
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.message),
                          onPressed: () {},
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Información del pedido
                  Text(
                    "Pedido #325621",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Tiempo de entrega estimado  1 día 2 horas",
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),

                  const SizedBox(height: 16),

                  // Estados del pedido
                  _buildEstadoItem(
                    icon: Icons.radio_button_checked,
                    iconColor: Colors.red,
                    titulo: "Solicitar Confirmación",
                    subtitulo: "Recogeremos su paquete pronto",
                    completado: true,
                    mostrarLinea: true,
                  ),
                  _buildEstadoItem(
                    icon: Icons.radio_button_checked,
                    iconColor: Colors.red,
                    titulo: "En tránsito",
                    subtitulo: "Su artículo fue recogido",
                    completado: true,
                    mostrarLinea: true,
                  ),
                  _buildEstadoItem(
                    icon: Icons.circle_outlined,
                    iconColor: Colors.grey,
                    titulo: "Entregado",
                    subtitulo: "¡El paquete ha sido enviado!",
                    completado: false,
                    mostrarLinea: false,
                  ),

                  const SizedBox(height: 20),

                  // Botón "Ver más"
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetallesCompraScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE50914),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Ver más",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEstadoItem({
    required IconData icon,
    required Color iconColor,
    required String titulo,
    required String subtitulo,
    required bool completado,
    bool mostrarLinea = true,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Columna con ícono y línea conectora
        SizedBox(
          width: 20,
          child: Column(
            children: [
              Icon(icon, color: iconColor, size: 20),
              if (mostrarLinea)
                Container(
                  width: 2,
                  height: 30,
                  margin: const EdgeInsets.only(top: 4),
                  color: Colors.grey[300],
                ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: completado ? Colors.black87 : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitulo,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
