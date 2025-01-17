import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import '../../constants.dart';
import '../../theme.dart';
import 'common_widgets.dart';
import 'icons.dart';

class AudioCard extends StatefulWidget {
  const AudioCard({
    super.key,
    this.image,
    this.onTap,
    this.onPlay,
    this.bottom,
    this.height,
    this.width,
  });
  final Widget? image;
  final void Function()? onTap;
  final void Function()? onPlay;
  final Widget? bottom;
  final double? height;
  final double? width;

  @override
  State<AudioCard> createState() => _AudioCardState();
}

class _AudioCardState extends State<AudioCard> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final light = theme.brightness == Brightness.light;

    return Column(
      children: [
        SizedBox(
          height: widget.height ?? kSmallCardHeight,
          width: widget.width ?? kSmallCardHeight,
          child: YaruBanner(
            color: light ? theme.dividerColor : Colors.black,
            padding: EdgeInsets.zero,
            onTap: widget.onTap,
            onHover: (value) => setState(() {
              _hovered = value;
            }),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  widget.image ??
                      Shimmer.fromColors(
                        baseColor: light ? kShimmerBaseLight : kShimmerBaseDark,
                        highlightColor: light
                            ? kShimmerHighLightLight
                            : kShimmerHighLightDark,
                        child: Container(
                          color: light ? kShimmerBaseLight : kShimmerBaseDark,
                        ),
                      ),
                  if (widget.image != null) widget.image!,
                  if (_hovered && widget.onPlay != null)
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: CircleAvatar(
                        radius: avatarIconSize,
                        backgroundColor: theme.colorScheme.primary,
                        child: IconButton(
                          onPressed: widget.onPlay,
                          icon: Padding(
                            padding: appleStyled
                                ? const EdgeInsets.only(left: 3)
                                : EdgeInsets.zero,
                            child: Icon(
                              Iconz().playFilled,
                              color: contrastColor(theme.colorScheme.primary),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        if (widget.bottom != null) widget.bottom!,
      ],
    );
  }
}
