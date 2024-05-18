import 'package:flutter/material.dart';
import 'monitor.dart';
import '../weather/home_page.dart'; // Assuming you have a WeatherPage defined in weather.dart

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text('Dashboard'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
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
              child: Text('TAP PLANTO'),
            ),
          ),
        ],
      ),
    );
  }

  _buildButtonsDialog(BuildContext context) {
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
              SizedBox(height: 10),
              _buildButtonWithIcon(context, 'Plant Growth Activity', Icons.spa,
                  _showPlantGrowthForm),
              SizedBox(height: 10),
              _buildButtonWithIcon(context, 'Soil Moisture', Icons.opacity,
                  _showSoilMoistureForm),
              SizedBox(height: 10),
              _buildButtonWithIcon(
                  context, 'Water Levels', Icons.pool, _showWaterLevelsForm),
              SizedBox(height: 10),
              _buildButtonWithIcon(context, 'Crop Management', Icons.input,
                  _showCropManagementForm),
              SizedBox(height: 10),
              _buildButtonWithIcon(context, 'Livestock Records', Icons.input,
                  _showLivestockRecordsForm),
              SizedBox(height: 10),
              _buildButtonWithIcon(
                  context, 'Harvest Data', Icons.input, _showHarvestDataForm),
              SizedBox(height: 10),
              _buildButtonWithIcon(context, 'Latest Agriculture News',
                  Icons.article, _showLatestAgricultureNewsForm),
              SizedBox(height: 10),
              _buildButtonWithIcon(
                  context, 'Trends', Icons.article, _showTrendsForm),
              SizedBox(height: 10),
              _buildButtonWithIcon(context, 'Task Reminder', Icons.article,
                  _showTaskReminderForm),
              SizedBox(height: 10),
              _buildButtonWithIcon(
                  context, 'Metrics', Icons.article, _showMetricsForm),
              SizedBox(height: 10),
              _buildButtonWithIcon(
                  context, 'Monitor', Icons.monitor, _goToMonitorPage),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToWeatherPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  void _goToMonitorPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MonitorPage()),
    );
  }

  // Function to create a button with an icon
  Widget _buildButtonWithIcon(BuildContext context, String label, IconData icon,
      Function(BuildContext) onPressed) {
    return ElevatedButton.icon(
      onPressed: () => onPressed(context),
      icon: Icon(icon),
      label: Text(label),
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(Colors.blue.withOpacity(0.7)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }

  // Functions to show various forms
  void _showPlantGrowthForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Plant Growth Activity'),
          content: Text('seed phase,vegetation,final growth.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
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
          title: Text('Soil Moisture'),
          content: Text('low,high,optimal.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
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
          title: Text('Water Levels'),
          content: Text('high,low.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
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
          title: Text('Crop Management'),
          content: Text('crop type,plant date,harvest date.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
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
          title: Text('Livestock Records'),
          content: Text(
              'livestock type,number of livestock,date of birth,vaccination date.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
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
          title: Text('Harvest Data'),
          content: Text('crop type,harvest quantity,harvest date,quality.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showLatestAgricultureNewsForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Latest Agriculture News'),
          content: Text('news headlines,content.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
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
          title: Text('Trends'),
          content: Text('courses,modules.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
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
          title: Text('Task Reminder'),
          content: Text('vaccination,machinery maintainance.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
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
          title: Text('Metrics'),
          content: Text('1,2,3.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
