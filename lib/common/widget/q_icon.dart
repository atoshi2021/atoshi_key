import 'package:atoshi_key/common/res/z_res.dart';
import 'package:flutter/material.dart';

Icon buildArrowRight({Color? color}) => Icon(
      Icons.arrow_forward_ios,
      size: QSize.space15,
      color: color ?? QColor.grey80,
    );

///
/// [isFavorite] 收藏 是否收藏
Icon buildFavorite(bool isFavorite) => Icon(
      Icons.star_purple500_outlined,
      size: QSize.space20,
      shadows: [
        Shadow(
            color: isFavorite ? QColor.white : QColor.transparent,
            blurRadius: QSize.space2,
            offset: Offset(QSize.space1, QSize.space1))
      ],
      color: !isFavorite ? QColor.transparent : QColor.colorYellow,
    );
