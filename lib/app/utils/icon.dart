import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppIcons {
  IconData? getIconDataByKey(String key) {
    key = key.trim();
    switch (key) {
      case 'washing_machine':
        return MdiIcons.washingMachine;
      case 'motorbike':
        return MdiIcons.motorbike;
      case 'air_condition':
        return MdiIcons.airConditioner;
      case 'window_closed_variant':
        return MdiIcons.windowClosedVariant;
      case 'television':
        return MdiIcons.television;
      case 'bed':
        return MdiIcons.bedOutline;
      case 'toilet':
        return MdiIcons.toilet;
      case 'fridge':
        return MdiIcons.fridgeOutline;
      case 'beekeeper':
        return MdiIcons.beekeeper;
      case 'clock':
        return MdiIcons.clockCheckOutline;
      case 'wifi':
        return MdiIcons.wifi;
    }

    return null;
  }
}
