import 'package:flutter/material.dart';
import 'package:smartfarm/chat/pages/home_page.dart';
import 'package:smartfarm/screens/deseaseDetection/screens/MonitorPage.dart';
import '../weather/home_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('Dashboard'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child:
                Text('Welcome back, Tasha!!!', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/im9.jpg',
            fit: BoxFit.fill,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return _buildButtonsDialog(context);
                  },
                );
              },
              child: const Text('TAP PLANTO'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonsDialog(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildButtonWithIcon(context, 'Weather Forecast', Icons.wb_sunny,
                  _navigateToWeatherPage),
              const SizedBox(height: 10),
              _buildButtonWithIcon(context, 'Plant Growth Activity', Icons.spa,
                  _showPlantGrowthForm),
              const SizedBox(height: 10),
              _buildButtonWithIcon(context, 'Soil Moisture', Icons.opacity,
                  _showSoilMoistureForm),
              const SizedBox(height: 10),
              _buildButtonWithIcon(
                  context, 'Water Levels', Icons.pool, _showWaterLevelsForm),
              const SizedBox(height: 10),
              _buildButtonWithIcon(context, 'Crop Management', Icons.grass,
                  _showCropManagementForm),
              const SizedBox(height: 10),
              _buildButtonWithIcon(context, 'Livestock Records', Icons.pets,
                  _showLivestockRecordsForm),
              const SizedBox(height: 10),
              _buildButtonWithIcon(context, 'Harvest Data', Icons.agriculture,
                  _showHarvestDataForm),
              const SizedBox(height: 10),
              _buildButtonWithIcon(context, 'Latest Agriculture News',
                  Icons.article, _navigateToChat),
              const SizedBox(height: 10),
              _buildButtonWithIcon(
                  context, 'Trends', Icons.trending_up, _showTrendsForm),
              const SizedBox(height: 10),
              _buildButtonWithIcon(
                  context, 'Task Reminder', Icons.alarm, _showTaskReminderForm),
              const SizedBox(height: 10),
              _buildButtonWithIcon(
                  context, 'Metrics', Icons.analytics, _showMetricsForm),
              const SizedBox(height: 10),
              _buildButtonWithIcon(
                  context, 'Scanner', Icons.monitor, _goToDiseaseDetection),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToWeatherPage(BuildContext context) {
    Navigator.pop(context); // Close the dialog first
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  void _goToDiseaseDetection(BuildContext context) {
    Navigator.pop(context); // Close the dialog first
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DiseaseDetection()),
    );
  }

  void _navigateToChat(BuildContext context) {
    Navigator.pop(context); // Close the dialog first
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChatScreen()),
    );
  }

  Widget _buildButtonWithIcon(BuildContext context, String label, IconData icon,
      Function(BuildContext) onPressed) {
    return ElevatedButton.icon(
      onPressed: () => onPressed(context),
      icon: Icon(icon),
      label: Text(label),
      style: ButtonStyle(
        backgroundColor:
            WidgetStateProperty.all<Color>(Colors.blue.withOpacity(0.7)),
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }

  void _showPlantGrowthForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Plant Growth Activity'),
          content: const Text('seed phase,vegetation,final growth.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showSoilMoistureForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Soil Moisture'),
          content: const Text('low,high,optimal.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showWaterLevelsForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Water Levels'),
          content: const Text('high,low.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showCropManagementForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Crop Management'),
          content: const Text('crop type,plant date,harvest date.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showLivestockRecordsForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Livestock Records'),
          content: const Text(
              'livestock type,number of livestock,date of birth,vaccination date.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showHarvestDataForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Harvest Data'),
          content:
              const Text('crop type,harvest quantity,harvest date,quality.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showTrendsForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Trends'),
          content: const Text('courses,modules.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showTaskReminderForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Task Reminder'),
          content: const Text('vaccination,machinery maintenance.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showMetricsForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Metrics'),
          content: const Text('data analysis.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
