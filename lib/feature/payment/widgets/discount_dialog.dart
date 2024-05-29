import 'package:erpku_pos/core/theme/color_values.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiscountDialog extends StatefulWidget {
  const DiscountDialog({Key? key}) : super(key: key);

  @override
  _DiscountDialogState createState() => _DiscountDialogState();
}

class _DiscountDialogState extends State<DiscountDialog> {
  late SharedPreferences _prefs;
  late bool bukaPuasaDiscount = false;
  late bool welcomeCWBDiscount = false;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  _loadSavedData() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      bukaPuasaDiscount = _prefs.getBool('bukaPuasaDiscount') ?? false;
      welcomeCWBDiscount = _prefs.getBool('welcomeCWBDiscount') ?? false;
    });
  }

  _saveData() async {
    await _prefs.setBool('bukaPuasaDiscount', bukaPuasaDiscount);
    await _prefs.setBool('welcomeCWBDiscount', welcomeCWBDiscount);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Stack(
        alignment: Alignment.center,
        children: [
          const Text(
            'DISKON',
            style: TextStyle(
              color: ColorValues.primary,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.cancel,
                color: ColorValues.primary,
                size: 30.0,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Nama Diskon: BUKAPUASA'),
            subtitle: const Text('Potongan harga (20%)'),
            contentPadding: EdgeInsets.zero,
            textColor: ColorValues.primary,
            trailing: Checkbox(
              value: bukaPuasaDiscount,
              onChanged: (value) {
                setState(() {
                  bukaPuasaDiscount = value!;
                  welcomeCWBDiscount = false;
                  if (value) {
                    _saveData();
                    welcomeCWBDiscount = false;
                    Navigator.of(context).pop('BUKAPUASA'); // Ubah baris ini untuk mengirimkan 'WELCOMECWB'
                  }else{
                    _saveData();
                    Navigator.of(context).pop('BACK');
                  }
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Nama Diskon: WELCOMECWB'),
            subtitle: const Text('Potongan harga (30%)'),
            contentPadding: EdgeInsets.zero,
            textColor: ColorValues.primary,
            trailing: Checkbox(
              value: welcomeCWBDiscount,
              onChanged: (value) {
                setState(() {
                  welcomeCWBDiscount = value!;
                  bukaPuasaDiscount = false;
                  if (value) {
                    _saveData();
                    bukaPuasaDiscount = false;
                    Navigator.of(context).pop('WELCOMECWB'); // Ubah baris ini untuk mengirimkan 'WELCOMECWB'
                  }else{
                    _saveData();
                    Navigator.of(context).pop('BACK');
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
