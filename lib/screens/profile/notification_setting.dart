import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool _generalNotifications = true;
  bool _sound = true;
  bool _callSound = true;
  bool _vibration = true;
  bool _specialOffers = true;
  bool _payment = true;
  bool _promotions = true;
  bool _refund = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF93000A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Thông Báo',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSwitchTile('Thông báo chung', _generalNotifications,
                    (value) {
                  setState(() {
                    _generalNotifications = value;
                  });
                }),
            _buildSwitchTile('Âm thanh', _sound, (value) {
              setState(() {
                _sound = value;
              });
            }),
            _buildSwitchTile('Âm thanh cuộc gọi', _callSound, (value) {
              setState(() {
                _callSound = value;
              });
            }),
            _buildSwitchTile('Rung', _vibration, (value) {
              setState(() {
                _vibration = value;
              });
            }),
            _buildSwitchTile('Ưu đãi đặc biệt', _specialOffers, (value) {
              setState(() {
                _specialOffers = value;
              });
            }),
            _buildSwitchTile('Thanh toán', _payment, (value) {
              setState(() {
                _payment = value;
              });
            }),
            _buildSwitchTile('Khuyến mãi, giảm giá', _promotions, (value) {
              setState(() {
                _promotions = value;
              });
            }),
            _buildSwitchTile('Hoàn tiền', _refund, (value) {
              setState(() {
                _refund = value;
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      activeColor: const Color(0xFF93000A),
      onChanged: onChanged,
    );
  }
}