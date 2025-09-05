import 'package:flutter/material.dart';

import '../../core/constants/constant.dart';
import '../../features/result/presentation/pages/notice_model.dart';
import '../../features/result/presentation/pages/notice_view.dart';
import 'big_card_image.dart';
import 'dot_indicators.dart';

class BigCardImageSlide extends StatefulWidget {
  const BigCardImageSlide({super.key, required this.notices});

  final List<NoticeModel> notices;

  @override
  State<BigCardImageSlide> createState() => _BigCardImageSlideState();
}

class _BigCardImageSlideState extends State<BigCardImageSlide> {
  int intialIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.81,
      child: Stack(
        children: [
          PageView.builder(
            onPageChanged: (value) {
              setState(() {
                intialIndex = value;
              });
            },
            itemCount: widget.notices.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                if (widget.notices[index].route == "/notice") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NoticeView(notice: widget.notices[index]),
                    ),
                  );
                } else {
                  Navigator.pushNamed(context, widget.notices[index].route);
                }
              },
              child: BigCardImage(image: widget.notices[index].url),
            ),
          ),
          Positioned(
            bottom: defaultPadding,
            right: defaultPadding,
            child: Container(
              padding: EdgeInsets.all(defaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: List.generate(
                  widget.notices.length,
                  (index) => DotIndicator(
                    isActive: intialIndex == index,
                    activeColor: Colors.white,
                    inActiveColor: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: defaultPadding,
            left: defaultPadding,
            right: 100,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.notices[intialIndex].title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
