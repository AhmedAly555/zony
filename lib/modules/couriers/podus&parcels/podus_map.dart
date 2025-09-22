import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPoint {
  final String id;
  final String title;
  final LatLng location;
  final String category;
  final IconData icon;

  MapPoint({
    required this.id,
    required this.title,
    required this.location,
    required this.category,
    required this.icon,
  });
}

class MyPUDOsScreen extends StatefulWidget {
  const MyPUDOsScreen({super.key});

  @override
  State<MyPUDOsScreen> createState() => _MyPUDOsScreenState();
}

class _MyPUDOsScreenState extends State<MyPUDOsScreen> {
  final MapController _mapController = MapController();
  String _selectedFilter = 'All Parcels';

  // نقاط وهمية في منطقة واشنطن
  final List<MapPoint> _mapPoints = [
    MapPoint(
      id: '1',
      title: 'Columbia Heights',
      location: LatLng(38.9289, -77.0324),
      category: 'pickup',
      icon: Icons.local_shipping,
    ),
    MapPoint(
      id: '2',
      title: 'Silver Spring',
      location: LatLng(38.9906, -77.0261),
      category: 'delivery',
      icon: Icons.store,
    ),
    MapPoint(
      id: '3',
      title: 'Rockville',
      location: LatLng(39.0840, -77.1528),
      category: 'pickup',
      icon: Icons.local_shipping,
    ),
    MapPoint(
      id: '4',
      title: 'Germantown',
      location: LatLng(39.1732, -77.2717),
      category: 'delivery',
      icon: Icons.store,
    ),
    MapPoint(
      id: '5',
      title: 'Alexandria',
      location: LatLng(38.8048, -77.0469),
      category: 'pickup',
      icon: Icons.local_shipping,
    ),
    MapPoint(
      id: '6',
      title: 'Fort Washington',
      location: LatLng(38.7070, -77.0230),
      category: 'delivery',
      icon: Icons.store,
    ),
    MapPoint(
      id: '7',
      title: 'Burke',
      location: LatLng(38.7651, -77.2717),
      category: 'pickup',
      icon: Icons.local_shipping,
    ),
  ];

  List<MapPoint> get _filteredPoints {
    if (_selectedFilter == 'All Parcels') {
      return _mapPoints;
    }
    return _mapPoints.where((point) =>
        point.category.toLowerCase().contains(_selectedFilter.toLowerCase())
    ).toList();
  }

  Future<void> _openInGoogleMaps(LatLng location) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open Google Maps')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'My PUDOs',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // شريط البحث والفلتر
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey[600], size: 20),
                        const SizedBox(width: 8),
                        Text(
                          _selectedFilter,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6B46C1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.tune, color: Colors.white),
                    onPressed: _showFilterBottomSheet,
                  ),
                ),
              ],
            ),
          ),

          // الخريطة
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: LatLng(38.9072, -77.0369), // Washington DC
                initialZoom: 11.0,
                maxZoom: 18.0,
                minZoom: 3.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: _filteredPoints.map((point) => Marker(
                    point: point.location,
                    width: 60,
                    height: 60,
                    child: GestureDetector(
                      onTap: () => _openInGoogleMaps(point.location),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFFCD34D),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            point.icon,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF6B46C1),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Searching',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2),
            label: 'Collecting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'More',
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter Options',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildFilterOption('All Parcels', Icons.all_inclusive),
            _buildFilterOption('Pickup', Icons.local_shipping),
            _buildFilterOption('Delivery', Icons.store),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOption(String title, IconData icon) {
    final isSelected = _selectedFilter == title;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? const Color(0xFF6B46C1) : Colors.grey,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? const Color(0xFF6B46C1) : Colors.black,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check, color: Color(0xFF6B46C1))
          : null,
      onTap: () {
        setState(() {
          _selectedFilter = title;
        });
        Navigator.pop(context);
      },
    );
  }
}