import 'dart:math';
import 'dart:developer' as dev;

import 'package:bottom_sheet_screen_transition_app/presentation/home/components/bottom_sheet_header.dart';
import 'package:bottom_sheet_screen_transition_app/presentation/home/components/gap.dart';
import 'package:bottom_sheet_screen_transition_app/presentation/home/components/icon_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// part 'components/appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final DraggableScrollableController _scrollController;
  late final ScrollController _customScrollController;

  bool maxExtendReached = false;
  bool _isWidgetVisible = true;
  final Duration animationDuration = const Duration(milliseconds: 300);

  final List<double> itemHeights = List.generate(20, (index) {
    // Generate random heights between 100 and 300
    return Random().nextInt(201) + 100.0;
  });

  @override
  void initState() {
    _scrollController = DraggableScrollableController();
    _customScrollController = ScrollController();
    _scrollController.addListener(_handleBottomSheetScroll);
    super.initState();
  }

  void _handleBottomSheetScroll() {
    if (_scrollController.isAttached) {
      final extent = _scrollController.size;

      // Check if the bottom sheet has reached its maximum extent
      if (extent >= 1) {
        setState(() {
          maxExtendReached = true;
        });
        dev.log('greater than 0.9');
      }
      if (extent < 1 && extent > 0.95) {
        setState(() {
          maxExtendReached = false;
        });
        dev.log('lower than 0.9');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 1.sh,
              width: 1.sw,
              color: Colors.blueAccent,
            ),
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconCircle(
                      onPressed: () {},
                      iconSize: 26.r,
                      icon: CupertinoIcons.ant,
                      badgeValue: '99'),
                  Gap(13.w),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 4.h),
                                  blurRadius: 2.r,
                                  color: Colors.black.withOpacity(0.25))
                            ]),
                        child: TextFormField(
                          // style: context.textTheme.bodyMedium,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0.h, horizontal: 10.w),
                            fillColor: Colors.white,
                            enabled: false,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100.w),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100.w),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(1),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            hintText: 'Search place',
                          ),
                        ),
                      ),
                    ),
                  ),
                  maxExtendReached ? const SizedBox.shrink() : Gap(13.w),
                  maxExtendReached
                      ? const SizedBox.shrink()
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconCircle(
                              onPressed: () {},
                              // icon: CupertinoIcons.el,
                              icon: CupertinoIcons.person,
                            ),
                            Gap(12.h),
                            IconCircle(
                                onPressed: () {},
                                // icon: CupertinoIcons.el,
                                icon: CupertinoIcons.bubble_right,
                                badgeValue: '99'),
                          ],
                        )
                ],
              ),
            ),
            Positioned(
              bottom: ScreenUtil().scaleHeight * 200,
              right: 20.w,
              child: IconCircle(
                onPressed: () {},
                icon: CupertinoIcons.location,
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.20,
              minChildSize: 0.20,
              maxChildSize: 1,
              controller: _scrollController,
              builder: (context, bottomSheetScrollController) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: maxExtendReached
                          ? []
                          : [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 8,
                                  spreadRadius: 3)
                            ],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(maxExtendReached ? 0 : 8.r),
                        topRight: Radius.circular(maxExtendReached ? 0 : 8.r),
                      )),
                  child: CustomScrollView(
                    shrinkWrap: true,
                    controller: bottomSheetScrollController,
                    slivers: [
                      maxExtendReached
                          ? const SliverPadding(padding: EdgeInsets.zero)
                          : SliverToBoxAdapter(
                              child: Container(
                              padding: EdgeInsets.only(
                                  left: 180.w, right: 180.w, top: 10.h),
                              child: Container(
                                height: 5.h,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF9E9E9E),
                                    borderRadius: BorderRadius.circular(50.r)),
                                child: const SizedBox.shrink(),
                              ),
                            )),
                      SliverPersistentHeader(
                          pinned: true,
                          delegate: Myheader(
                              maxExtendReached: maxExtendReached,
                              customScrollController:
                                  bottomSheetScrollController,
                              draggableScrollableController:
                                  _scrollController)),
                      SliverToBoxAdapter(
                        child: MasonryGridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: itemHeights.length,
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          itemBuilder: (context, index) {
                            return Container(
                              height: itemHeights[index],
                              decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12.r)),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

