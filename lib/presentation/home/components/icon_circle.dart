import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class IconCircle extends StatelessWidget {
  final IconData icon;
  final String? badgeValue;
  final Color borderColor, iconColor;
  final Function() onPressed;
  final bool hasShadow;
  final double iconSize;
  final String? svgAssetPath;
  final bool showIcon;
  final double height;
  IconCircle({
    this.badgeValue,
    this.icon = Icons.question_mark,
    required this.onPressed,
    this.hasShadow = true,
    this.borderColor = Colors.black,
    this.iconColor = Colors.black,
    this.iconSize = 27,
    this.svgAssetPath,
    this.height = 57,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: height.h,
        width: height.h,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: double.infinity,
                // padding: EdgeInsets.all(AppSize.s10.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: !hasShadow
                        ? []
                        : [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 2.r,
                              offset: Offset(0, 4.h),
                            )
                          ],
                    border: Border.all(color: borderColor, width: 1.5.w)),
                child: showIcon
                    ? Icon(
                        icon,
                        color: iconColor,
                        size: iconSize.h,
                      )
                    : SvgPicture.asset(
                        svgAssetPath!,
                        height: iconSize.h,
                      )),
            badgeValue == null
                ? const SizedBox()
                : Positioned(
                    right: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(16.r)),
                      padding:
                          EdgeInsets.symmetric(vertical: 2.r, horizontal: 6.r),
                      child: Text(
                        badgeValue!,
                        style: TextStyle(fontSize: 6.sp, color: Colors.white),
                      ),
                    ))
          ],
        ),
      ),
    );
  }
}
