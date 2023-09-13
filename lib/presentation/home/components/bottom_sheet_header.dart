import 'dart:math';

import 'package:bottom_sheet_screen_transition_app/presentation/home/components/gap.dart';
import 'package:bottom_sheet_screen_transition_app/presentation/home/components/icon_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Myheader extends SliverPersistentHeaderDelegate {
  bool maxExtendReached;
  ScrollController customScrollController;
  DraggableScrollableController draggableScrollableController;

  Myheader(
      {required this.maxExtendReached,
      required this.customScrollController,
      required this.draggableScrollableController});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double shrinkPercentage = min(1, shrinkOffset / (maxExtent - minExtent));

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: shrinkPercentage != 1
              ? []
              : [
                  BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 6,
                      color: Colors.black.withOpacity(0.4))
                ]),
      child: Column(
        children: [
          !maxExtendReached
              ? const SizedBox.shrink()
              : Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 20.w,
                  ),
                  child: Row(
                    children: [
                      IconCircle(
                          hasShadow: false,
                          icon: CupertinoIcons.chevron_down,
                          iconSize: 30,
                          onPressed: () {
                            draggableScrollableController
                                .animateTo(0.20,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut)
                                .then((value) =>
                                    customScrollController.animateTo(0.0,
                                        duration:
                                            const Duration(milliseconds: 100),
                                        curve: Curves.easeInOut));
                          }),
                      Gap(14.w),
                      Visibility(
                        visible: shrinkPercentage == 1 ? false : true,
                        child: Expanded(
                          child: AnimatedOpacity(
                              opacity: (1 - shrinkPercentage),
                              duration: const Duration(milliseconds: 300),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5.h, horizontal: 10.w),
                                  fillColor: Colors.white,
                                  enabled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100.r),
                                    borderSide: const BorderSide(
                                      width: 1.5,
                                      color: Colors.black,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100.r),
                                    borderSide: const BorderSide(
                                      width: 1.5,
                                      color: Colors.black,
                                    ),
                                  ),
                                  filled: true,
                                  hintText: 'Search place',
                                ),
                              )),
                        ),
                      ),
                      Visibility(
                        visible: shrinkPercentage == 1 ? true : false,
                        child: Expanded(
                          child: Text(
                            'Nearest Events',
                            style: TextStyle(
                                fontSize: 24.sp, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: shrinkPercentage == 1 ? true : false,
                        child: const Icon(CupertinoIcons.ellipsis_vertical),
                      )
                    ],
                  ),
                ),
          Transform.translate(
            offset: Offset(0, -(200 * shrinkPercentage)),
            child: Visibility(
              visible: shrinkPercentage < 0.12 ? true : false,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                  horizontal: 20.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AnimatedOpacity(
                        opacity: (1 - shrinkPercentage),
                        duration: const Duration(milliseconds: 10),
                        child: Text(
                          'Nearest Events',
                          style: TextStyle(
                              fontSize: 24.sp, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                        opacity: (1 - shrinkPercentage),
                        duration: const Duration(milliseconds: 150),
                        child: const Icon(CupertinoIcons.ellipsis_vertical)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => maxExtendReached ? 140.h : (57.h);

  @override
  double get minExtent => maxExtendReached ? (kToolbarHeight + 12.h) : 50.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
