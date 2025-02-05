import 'package:flutter/material.dart';

class ProfilePageSwitchButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function(bool)? onChanged;
  final bool value;
  const ProfilePageSwitchButton(
      {super.key,
      required this.text,
      required this.onChanged,
      required this.value,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
      child: Center(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 19, right: 7),
              child: Icon(Icons.power_settings_new),
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(color: Colors.grey.shade700, fontSize: 19),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Switch(
                  value: value,
                  onChanged: onChanged,
                  activeColor: Color(0xffD6F5F1),
                  thumbColor: WidgetStateProperty.all(Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}

class ProfilePageButtons extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  const ProfilePageButtons(
      {super.key,
      required this.text,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(
            color: Colors.grey.shade300,
            width: 2,
          )),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              icon,
              color: Colors.black,
            ),
          ),
          Text(
            text,
            style: TextStyle(color: Colors.grey.shade700, fontSize: 19),
          ),
        ],
      ),
    );
  }
}
