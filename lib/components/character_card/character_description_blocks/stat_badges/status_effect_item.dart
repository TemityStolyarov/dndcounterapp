import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum StatusEffectItemType {
  statusKdDebuff(
    svgPicture: 'assets/icons/status_kd_debuff.svg',
    backgoroundColorActive: ColorPalette.statusKdDebuffBackground,
    backgoroundColorOpacityActive: ColorPalette.statusKdDebuffBackground40,
    labelColor: ColorPalette.statusKdDebuffLabel,
  ),
  statusKdBuff(
    svgPicture: 'assets/icons/status_kd_buff.svg',
    backgoroundColorActive: ColorPalette.statusKdBuffBackground,
    backgoroundColorOpacityActive: ColorPalette.statusKdBuffBackground40,
    labelColor: ColorPalette.statusKdBuffLabel,
  ),
  statusRoped(
    svgPicture: 'assets/icons/status_roped.svg',
    backgoroundColorActive: ColorPalette.statusRopedBackground,
    backgoroundColorOpacityActive: ColorPalette.statusRopedBackground40,
    labelColor: ColorPalette.statusRopedLabel,
  ),
  statusDmgBuff(
    svgPicture: 'assets/icons/status_dmg_buff.svg',
    backgoroundColorActive: ColorPalette.statusDmgBuffBackground,
    backgoroundColorOpacityActive: ColorPalette.statusDmgBuffBackground40,
    labelColor: ColorPalette.statusDmgBuffLabel,
  ),
  statusFreezed(
    svgPicture: 'assets/icons/status_freezed.svg',
    backgoroundColorActive: ColorPalette.statusFreezedBackground,
    backgoroundColorOpacityActive: ColorPalette.statusFreezedBackground40,
    labelColor: ColorPalette.statusFreezedLabel,
  ),
  statusRollDebuff(
    svgPicture: 'assets/icons/status_roll_debuff.svg',
    backgoroundColorActive: ColorPalette.statusRollDebuffBackground,
    backgoroundColorOpacityActive: ColorPalette.statusRollDebuffBackground40,
    labelColor: ColorPalette.statusRollDebuffLabel,
  ),
  statusRollBuff(
    svgPicture: 'assets/icons/status_roll_buff.svg',
    backgoroundColorActive: ColorPalette.statusRollBuffBackground,
    backgoroundColorOpacityActive: ColorPalette.statusRollBuffBackground40,
    labelColor: ColorPalette.statusRollBuffLabel,
  ),
  statusProvocated(
    svgPicture: 'assets/icons/status_provocated.svg',
    backgoroundColorActive: ColorPalette.statusProvocatedBackground,
    backgoroundColorOpacityActive: ColorPalette.statusProvocatedBackground40,
    labelColor: ColorPalette.statusProvocatedLabel,
  );

  const StatusEffectItemType({
    required this.svgPicture,
    required this.backgoroundColorActive,
    required this.backgoroundColorOpacityActive,
    required this.labelColor,
  });

  final String svgPicture;
  final Color backgoroundColorActive;
  final Color backgoroundColorOpacityActive;
  final Color labelColor;
}

class StatusEffectItem extends StatelessWidget {
  const StatusEffectItem({
    super.key,
    required this.width,
    required this.height,
    required this.border,
    required this.shadow,
    required this.character,
    required this.padding,
    required this.isNotEmptyAndNotNull,
    required this.isEnabled,
    required this.type,
  });

  final double width;
  final double height;
  final Border border;
  final List<BoxShadow> shadow;
  final Character character;
  final double padding;
  final bool isNotEmptyAndNotNull;
  final bool isEnabled;
  final StatusEffectItemType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: border,
        boxShadow: shadow,
        color: isNotEmptyAndNotNull
            ? isEnabled
                ? type.backgoroundColorActive
                : type.backgoroundColorOpacityActive
            : isEnabled
                ? ColorPalette.backgroundColor50
                : ColorPalette.backgroundColor30,
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: SvgPicture.asset(
          type.svgPicture,
          colorFilter: ColorFilter.mode(
            isNotEmptyAndNotNull
                ? type.labelColor
                : ColorPalette.fontBaseColor.withOpacity(0.5),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
