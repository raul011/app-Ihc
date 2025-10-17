import 'package:flutter/material.dart';
import 'package:ihc_app/pages/entrega/mapa_page.dart';

class DetalleEntrega {
  final String titulo;
  final String descripcion;
  final String precio;
  final String horario;
  final IconData icon;
  final List<String>? horariosDisponibles;

  DetalleEntrega({
    required this.titulo,
    required this.descripcion,
    required this.precio,
    required this.horario,
    required this.icon,
    this.horariosDisponibles,
  });
}

class ConfirmarEntregaScreen extends StatefulWidget {
  const ConfirmarEntregaScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmarEntregaScreen> createState() => _ConfirmarEntregaScreenState();
}

class _ConfirmarEntregaScreenState extends State<ConfirmarEntregaScreen> {
  final _direccionController = TextEditingController();
  final _calleController = TextEditingController();
  final _codigoPostalController = TextEditingController();
  final _ciudadController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _instruccionesController = TextEditingController();

  String _tipoEntregaSeleccionado = 'estándar';
  String _diaSeleccionado = 'mañana';

  // Detalles de cada tipo de entrega
  final Map<String, DetalleEntrega> detallesEntrega = {
    'estándar': DetalleEntrega(
      titulo: 'Entrega estándar',
      descripcion: 'Llega en 2-3 días',
      precio: 'Gratis desde Bs 150 - Bs 12 si es menor',
      horario: 'Horario: 09:00 - 18:00',
      icon: Icons.local_shipping,
    ),
    'express': DetalleEntrega(
      titulo: 'Entrega express',
      descripcion: 'Llega en 24 horas',
      precio: 'Bs 30',
      horario: 'Horario: 08:00 - 20:00',
      icon: Icons.flash_on,
      horariosDisponibles: [
        '12:00 PM - 4:00 PM',
        '4:00 PM - 6:00 PM',
        '6:00 PM - 8:00 PM',
        '8:00 PM - 10:00 PM',
      ],
    ),
    'retiro': DetalleEntrega(
      titulo: 'Retiro en tienda',
      descripcion: 'Retira tu pedido hoy',
      precio: 'Gratis',
      horario: 'Horario: 10:00 - 19:00',
      icon: Icons.store,
      horariosDisponibles: [
        'Sucursal la guardia',
        'Sucursal la guardia',
        'Sucursal la guardia',
      ],
    ),
    'programada': DetalleEntrega(
      titulo: 'Entrega programada',
      descripcion: 'Elige tu fecha y hora',
      precio: 'Bs 15',
      horario: 'Horario: 09:00 - 18:00',
      icon: Icons.calendar_today,
      horariosDisponibles: [
        '12:00 PM - 4:00 PM',
        '4:00 PM - 6:00 PM',
        '6:00 PM - 8:00 PM',
        '8:00 PM - 10:00 PM',
      ],
    ),
  };

  @override
  void dispose() {
    _direccionController.dispose();
    _calleController.dispose();
    _codigoPostalController.dispose();
    _ciudadController.dispose();
    _telefonoController.dispose();
    _instruccionesController.dispose();
    super.dispose();
  }

  void _mostrarComentarioModal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: const Color(0xFF1a1a1a),
          child: _ComentarioModal(
            controller: _instruccionesController,
            onGuardar: () => Navigator.pop(context),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DetalleEntrega detalleActual = detallesEntrega[_tipoEntregaSeleccionado]!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Entrega',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MapaScreen()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.grey[600],
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Mi Ubicación Actual',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Dirección de Entrega',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: _direccionController,
                decoration: InputDecoration(
                  hintText: 'Dirección o punto de referencia',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _calleController,
                      decoration: InputDecoration(
                        hintText: 'Calle y número',
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _ciudadController,
                      decoration: InputDecoration(
                        hintText: 'Ciudad ',
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Comentarios de entrega',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: _mostrarComentarioModal,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 126, 125, 128),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Comentarios',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 236, 228, 228),
                          fontSize: 14,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: const Color.fromARGB(255, 245, 243, 243),
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Tipo de entrega',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _tipoEntregaButton(
                      'estándar',
                      'Entrega\nestándar',
                      Icons.local_shipping,
                    ),
                    const SizedBox(width: 12),
                    _tipoEntregaButton(
                      'express',
                      'Entrega\nexpress',
                      Icons.flash_on,
                    ),
                    const SizedBox(width: 12),
                    _tipoEntregaButton(
                      'retiro',
                      'Retiro en\ntienda',
                      Icons.store,
                    ),
                    const SizedBox(width: 12),
                    _tipoEntregaButton(
                      'programada',
                      'Entrega\nprogramada',
                      Icons.calendar_today,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Card con los detalles de entrega
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      detalleActual.descripcion,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      detalleActual.precio,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      detalleActual.horario,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Mostrar horarios disponibles si existen
              if (detalleActual.horariosDisponibles != null) ...[
                const SizedBox(height: 20),
                if (_tipoEntregaSeleccionado == 'programada')
                  // Para entrega programada: mostrar selector de días
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap:
                                      () => setState(
                                        () => _diaSeleccionado = 'mañana',
                                      ),
                                  child: Row(
                                    children: [
                                      Radio<String>(
                                        value: 'mañana',
                                        groupValue: _diaSeleccionado,
                                        onChanged: (value) {
                                          setState(
                                            () => _diaSeleccionado = value!,
                                          );
                                        },
                                      ),
                                      const Text('mañana'),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap:
                                      () => setState(
                                        () => _diaSeleccionado = 'Jueves',
                                      ),
                                  child: Row(
                                    children: [
                                      Radio<String>(
                                        value: 'Jueves',
                                        groupValue: _diaSeleccionado,
                                        onChanged: (value) {
                                          setState(
                                            () => _diaSeleccionado = value!,
                                          );
                                        },
                                      ),
                                      const Text('Jueves'),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap:
                                      () => setState(
                                        () => _diaSeleccionado = 'Viernes',
                                      ),
                                  child: Row(
                                    children: [
                                      Radio<String>(
                                        value: 'Viernes',
                                        groupValue: _diaSeleccionado,
                                        onChanged: (value) {
                                          setState(
                                            () => _diaSeleccionado = value!,
                                          );
                                        },
                                      ),
                                      const Text('Viernes'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Horarios Disponibles',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            detalleActual.precio,
                            style: TextStyle(
                              color: Colors.blue[600],
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Column(
                        children: [
                          for (String horario
                              in detalleActual.horariosDisponibles!)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]!),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.grey[400]!,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      horario,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  )
                else
                  // Para express y retiro: mostrar horarios/sucursales
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _tipoEntregaSeleccionado == 'retiro'
                            ? 'Sucursales Disponibles'
                            : 'Horarios Disponibles',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        detalleActual.precio,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                      const SizedBox(height: 12),
                      Column(
                        children: [
                          for (String item
                              in detalleActual.horariosDisponibles!)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]!),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          _tipoEntregaSeleccionado == 'retiro'
                                              ? Icons.location_on
                                              : Icons.access_time,
                                          color: Colors.grey[600],
                                          size: 20,
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (_tipoEntregaSeleccionado == 'retiro')
                                      Text(
                                        'Disponible',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.green[600],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    else
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.grey[400]!,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
              ],

              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Entrega confirmada')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text(
                    'Confirmar entrega',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tipoEntregaButton(String id, String label, IconData icon) {
    bool isSelected = _tipoEntregaSeleccionado == id;
    return GestureDetector(
      onTap: () => setState(() => _tipoEntregaSeleccionado = id),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: isSelected ? Colors.red : Colors.white,
              border: Border.all(
                color: isSelected ? Colors.red : Colors.grey[300]!,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: isSelected ? Colors.white : Colors.grey[600],
                  size: 24,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[600],
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ComentarioModal extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onGuardar;

  const _ComentarioModal({required this.controller, required this.onGuardar});

  @override
  State<_ComentarioModal> createState() => _ComentarioModalState();
}

class _ComentarioModalState extends State<_ComentarioModal> {
  late TextEditingController _tempController;

  @override
  void initState() {
    super.initState();
    _tempController = TextEditingController(text: widget.controller.text);
  }

  @override
  void dispose() {
    _tempController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1a1a1a),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    'Comentario',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _tempController,
                maxLines: 5,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Información importante para el repartidor',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[700]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[700]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    widget.controller.text = _tempController.text;
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 243, 3, 3),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Guardar',
                    style: TextStyle(
                      color: Color.fromARGB(255, 245, 241, 241),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
