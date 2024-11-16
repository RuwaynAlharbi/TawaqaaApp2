import 'package:flutter/material.dart';

class AlertsPage extends StatefulWidget {
  @override
  _AlertsPageState createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  String selectedFilter = 'خطر';

  final List<Map<String, String>> alerts = [
    {
      'icon': 'assets/img/med.jpg',
      'type': 'متوسط',
      'location': 'شارع قريش',
      'height': '40 سم'
    },
    {
      'icon': 'assets/img/deng.jpg',
      'type': 'خطر',
      'location': 'شارع ابو يزيد',
      'height': '80 سم',
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredAlerts = alerts
        .where((alert) =>
            selectedFilter == 'الكل' || alert['type'] == selectedFilter)
        .toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/img/back.jpg', width: 30, height: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'الإنذارات',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilterButton(
                      label: 'متوسط',
                      isActive: selectedFilter == 'متوسط',
                      onTap: () {
                        setState(() {
                          selectedFilter = 'متوسط';
                        });
                      },
                    ),
                    SizedBox(width: 8),
                    FilterButton(
                      label: 'خطر',
                      isActive: selectedFilter == 'خطر',
                      onTap: () {
                        setState(() {
                          selectedFilter = 'خطر';
                        });
                      },
                    ),
                    SizedBox(width: 8),
                    FilterButton(
                      label: 'الكل',
                      isActive: selectedFilter == 'الكل',
                      onTap: () {
                        setState(() {
                          selectedFilter = 'الكل';
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredAlerts.length,
              itemBuilder: (context, index) {
                final alert = filteredAlerts[index];
                return AlertCard(
                  type: alert['type']!,
                  location: alert['location']!,
                  height: alert['height']!,
                  iconPath: alert['icon']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const FilterButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.transparent,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

class AlertCard extends StatelessWidget {
  final String type;
  final String location;
  final String height;
  final String iconPath;

  const AlertCard({
    required this.type,
    required this.location,
    required this.height,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    // تعيين اللون حسب نوع التنبيه
    Color borderColor;
    Color backgroundColor;
    if (type == 'خطر') {
      borderColor = Colors.red;
      backgroundColor = Color(0x33D61919); // 20% شفاف للون الأحمر
    } else if (type == 'متوسط') {
      borderColor = Colors.orange;
      backgroundColor = Color(0x33F59E08); // 20% شفاف للون البرتقالي
    } else {
      borderColor = Colors.grey;
      backgroundColor = Colors.grey.withOpacity(0.1); // لون افتراضي
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  type,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  location,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.right,
                ),
                Text(
                  height,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              // border: Border.all(color: borderColor, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(8),
            child: Image.asset(
              iconPath,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
