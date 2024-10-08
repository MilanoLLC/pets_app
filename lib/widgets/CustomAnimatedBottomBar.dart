import 'package:flutter/material.dart';
import 'package:pets_app/helpers/constant.dart';
import 'package:pets_app/widgets/CustomWidget.dart';

class CustomAnimatedBottomBar extends StatelessWidget {

  const CustomAnimatedBottomBar({
    Key? key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 24,
    this.backgroundColor,
    this.itemCornerRadius = 50,
    this.containerHeight = 56,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    required this.items,
    required this.onItemSelected,
    this.curve = Curves.linear,
  }) : assert(items.length >= 2 && items.length <= 5),
        super(key: key);

  final int selectedIndex;
  final double iconSize;
  final Color? backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double itemCornerRadius;
  final double containerHeight;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Theme.of(context).bottomAppBarColor;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          if (showElevation)
             BoxShadow(
              color: iconColor.withOpacity(0.5),

               offset: const Offset(
                 5.0,
                 5.0,
               ),
               blurRadius: 0.7,
               spreadRadius: 5.0,
             ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: containerHeight,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: items.map((item) {
              var index = items.indexOf(item);
              return InkWell(
                onTap: () => onItemSelected(index),
                child: _ItemWidget(
                  item: item,
                  containerHeight: containerHeight,
                  iconSize: iconSize,
                  isSelected: index == selectedIndex,
                  backgroundColor: bgColor,
                  itemCornerRadius: itemCornerRadius,
                  animationDuration: animationDuration,
                  curve: curve,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final BottomNavyBarItem item;
  final Color backgroundColor;
  final double itemCornerRadius;
  final double containerHeight;
  final Duration animationDuration;
  final Curve curve;

  const _ItemWidget({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.backgroundColor,
    required this.animationDuration,
    required this.itemCornerRadius,
    required this.containerHeight,
    required this.iconSize,
    this.curve = Curves.linear,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {

    double width= (getWidthPercentSize(context, 100)/5);
    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(

        height: double.maxFinite,
        duration: animationDuration,
        curve: curve,

        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            width: width,
            color: backgroundColor,


            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: getPercentSize(width, 45),
                  width: getPercentSize(width, 45),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color:isSelected? primaryColor.withOpacity(0.1):Colors.transparent,
                            blurRadius: 3,
                            spreadRadius: 2,
                            offset: const Offset(0, 6))
                      ],
                    color: isSelected?item.activeColor:Colors.transparent
                  ),
                  child: Center(
                    child: Icon(item.icon,size: isSelected?item.iconSize!:(item.iconSize!*1.4),color: isSelected?Colors.white:item.inactiveColor,),
                    // child: Image.asset(assetsPath+item.imageName!,height: isSelected?item.iconSize!:(item.iconSize!*1.4),color: isSelected?Colors.white:item.inactiveColor,),
                  ),
                ),

                // SizedBox(height:  getPercentSize(height, 20),),
                // getCustomTextWidget(item.title!,  isSelected? item ad.activeColor:item.inactiveColor!,
                //     textSize, FontWeight.w500, TextAlign.center,1)

              ],
            ),

          ),
        ),
      ),
    );
  }
}
class BottomNavyBarItem {

  BottomNavyBarItem({
    this.activeColor = Colors.blue,
    this.textAlign,
    this.inactiveColor,
    this.imageName,
    this.icon,
    this.iconSize,
    this.title,
  });

  final Color activeColor;
  final Color? inactiveColor;
  final TextAlign? textAlign;
  final String? imageName;
  final IconData? icon;
  final String? title;
  final double? iconSize;

}
