import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AIndustrial extends StatefulWidget {
  const AIndustrial({super.key});

  @override
  State<AIndustrial> createState() => _AIndustrialState();
}

class _AIndustrialState extends State<AIndustrial> {
  GoogleMapController? mapController;

  static const LatLng _lojaLocation = LatLng(-25.2123885, -50.9845277);

  static const Marker _lojaMarker = Marker(
    markerId: MarkerId('loja'),
    position: _lojaLocation,
    infoWindow: InfoWindow(
      title: 'A Industrial Materiais Elétricos',
      snippet: 'Rua Afonso Pena, 1122 - Centro',
    ),
  );

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _launchWhatsApp(String phone, String message) async {
    final List<String> urls = [
      'whatsapp://send?phone=$phone&text=${Uri.encodeComponent(message)}',
      'https://wa.me/$phone?text=${Uri.encodeComponent(message)}',
      'https://api.whatsapp.com/send?phone=$phone&text=${Uri.encodeComponent(message)}',
    ];

    for (String url in urls) {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        try {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
          return;
        } catch (_) {
          // Tenta o próximo
        }
      }
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'WhatsApp não encontrado. Verifique se está instalado.',
        ),
        backgroundColor: Colors.orange,
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }

  Future<void> _launchMapsUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      try {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } catch (_) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Não foi possível abrir o aplicativo de mapas'),
          ),
        );
      }
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('URL inválida para o aplicativo de mapas'),
        ),
      );
    }
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
    bool isClickable = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: isClickable ? onTap : null,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color:
              isClickable
                  ? Colors.grey[200]
                  : const Color.fromARGB(255, 239, 238, 238),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[300]!, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 30, color: const Color.fromARGB(255, 55, 52, 53)),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 55, 52, 53),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    content,
                    style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                  ),
                  if (isClickable)
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        'Toque para abrir',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          fontStyle: FontStyle.italic,
                        ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logointpreto.png',
          height: 40,
          fit: BoxFit.contain,
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 55, 52, 53),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.bolt,
                size: 80,
                color: Color.fromARGB(255, 0, 168, 89),
              ),
              const SizedBox(height: 10),
              const Text(
                'A Industrial Materiais Elétricos',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sobre Nós',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: const Text(
                  'A Industrial Materiais Elétricos é especializada em fornecer produtos elétricos de alta qualidade para residências, indústrias e profissionais da área. Nossa equipe está pronta para te atender e ajudar a encontrar os melhores produtos para suas necessidades.',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Localização',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: const CameraPosition(
                      target: _lojaLocation,
                      zoom: 18.0,
                    ),
                    markers: {_lojaMarker},
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: true,
                    compassEnabled: true,
                    tiltGesturesEnabled: false,
                    rotateGesturesEnabled: true,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Endereço físico:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Rua Afonso Pena, 1122 - Centro',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton.icon(
                      onPressed:
                          () => _launchMapsUrl(
                            'https://www.google.com.br/maps/place/A+Industrial/@-25.2123836,-50.9871026,17z/data=!4m6!3m5!1s0x94e8ebcdc36ce201:0x60962f5f7926f519!8m2!3d-25.2123885!4d-50.9845277!16s%2Fg%2F11tcfjg9_x?entry=ttu&g_ep=EgoyMDI1MDYwMy4wIKXMDSoASAFQAw%3D%3D',
                          ),
                      icon: const Icon(Icons.map, color: Colors.white),
                      label: const Text(
                        'Abrir no Google Maps',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 55, 52, 53),
                        minimumSize: const Size(0, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildInfoCard(
                icon: Icons.schedule,
                title: 'Horário de Atendimento',
                content:
                    'Segunda a Sexta: 7:00 às 11:30 e 13:00 às 18:00\nSábado: 7:00 às 11:30',
              ),
              const SizedBox(height: 15),
              _buildInfoCard(
                icon: Icons.phone,
                title: 'Contato',
                content: 'WhatsApp: (42) 99842-0106',
                isClickable: true,
                onTap:
                    () => _launchWhatsApp(
                      '5542998420106',
                      'Olá, gostaria de mais informações.',
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
