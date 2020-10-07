import 'package:flutter/material.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

void sheetView(BuildContext context) async {
  final BorderSide bs = BorderSide( width: 2.0,
    color: Theme.of(context).dividerColor );

  final result = await showSlidingBottomSheet(context, builder: (context) {
    return SlidingSheetDialog(
      duration: const Duration(milliseconds: 500),
      elevation: 8,
      cornerRadius: 8,
      cornerRadiusOnFullscreen: 0,
      //isBackdropInteractable: true,
      shadowColor: Theme.of(context).shadowColor.withOpacity(0.5),
      //border: Border.all(
      //  color: Theme.of(context).shadowColor.withOpacity(0.2),
      //  width: 3,
      snapSpec: const SnapSpec(
        snap: true,
        snappings: [SnapSpec.headerSnap, 0.6, 1.0],
        positioning: SnapPositioning.relativeToAvailableSpace,
      ),
      headerBuilder: (context, state) {
        return Container(
          height: 112,
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(4, 24, 4, 4),
          //color: Colors.green,
          alignment: Alignment.center,
          child: Text(
            'This is the header',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          foregroundDecoration: BoxDecoration(
            border: Border(
              bottom: bs,
            ),
          ),
        );
      },
      footerBuilder: (context, state) {
        return Container(
          height: 56,
          width: double.infinity,
          //color: Colors.yellow,
          alignment: Alignment.center,
          child: Text(
            'This is the footer',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          foregroundDecoration: BoxDecoration(
            border: Border(
              top: bs,
            ),
          ),
        );
      },
      builder: (context, state) {
        return Container(
          height: 1400,
          child: Center(
            child: Material(
              child: InkWell(
                onTap: () => Navigator.pop(context, 'This is the result.'),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'This is the content of the sheet',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  });

  print(result); // This is the result.
}
