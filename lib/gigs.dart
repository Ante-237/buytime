import 'package:buytime/Maps/map_page.dart';
import 'package:buytime/search_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:buytime/UI/DetailsPage.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);


class GigsParallax extends StatelessWidget {

  final SearchManager searchManager;

  const GigsParallax({ required super.key, required this.searchManager
  });


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (final location in searchManager.displayedItems)
            LocationListItem(
              imageUrl: location.imageUrl,
              name: location.name,
              distance: location.distance,
              price: location.price,
              place : location.place,
            ),
        ],
      ),
    );
  }
}


class LocationListItem extends StatelessWidget {
  LocationListItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.distance,
    required this.place,

  });

  final String imageUrl;
  final String name;
  final String price;
  final String place;
  final String distance;
  final GlobalKey _backgroundImageKey = GlobalKey();



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => MapsPage(currentGigLocation: cLocation(name: name, place: place, distance: distance, imageUrl: imageUrl, price: price))),
      ); },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                _buildParallaxBackground(context),
                _buildGradient(),
                _buildTitleAndSubtitle(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildParallaxBackground(BuildContext context) {
    return Flow(
      delegate: ParallaxFlowDelegate(
        scrollable: Scrollable.of(context),
        listItemContext: context,
        backgroundImageKey: _backgroundImageKey,
      ),
      children: [
        Image.network(
          imageUrl,
          key: _backgroundImageKey,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.6, 0.95],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndSubtitle() {
    return Positioned(
      left: 20,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(
                price,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.end,
                softWrap: true,
              ),
              const SizedBox(width: 20,),
              Text(
                place,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 100,),
              const Icon(Icons.share_location),
              const SizedBox(width: 10),
              Text(
                distance,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              )

            ],
          )
        ],
      ),
    );
  }
}


class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({
    required this.scrollable,
    required this.listItemContext,
    required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);


  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Calculate the position of this list item within the viewport.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.centerLeft(Offset.zero),
        ancestor: scrollableBox);

    // Determine the percent position of this list item within the
    // scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
    (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect =
    verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // Paint the background.
    context.paintChild(
      0,
      transform:
      Transform.translate(offset: Offset(0.0, childRect.top)).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}

class Parallax extends SingleChildRenderObjectWidget {
  const Parallax({
    super.key,
    required Widget background,
  }) : super(child: background);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderParallax(scrollable: Scrollable.of(context));
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderParallax renderObject) {
    renderObject.scrollable = Scrollable.of(context);
  }
}

class ParallaxParentData extends ContainerBoxParentData<RenderBox> {}

class RenderParallax extends RenderBox
    with RenderObjectWithChildMixin<RenderBox>, RenderProxyBoxMixin {
  RenderParallax({
    required ScrollableState scrollable,
  }) : _scrollable = scrollable;

  ScrollableState _scrollable;

  ScrollableState get scrollable => _scrollable;

  set scrollable(ScrollableState value) {
    if (value != _scrollable) {
      if (attached) {
        _scrollable.position.removeListener(markNeedsLayout);
      }
      _scrollable = value;
      if (attached) {
        _scrollable.position.addListener(markNeedsLayout);

        // shall fetch other content when the position changes.
       // _scrollable.position.addListener(() { });
      }
    }
  }

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);
    _scrollable.position.addListener(markNeedsLayout);
  }

  @override
  void detach() {
    _scrollable.position.removeListener(markNeedsLayout);
    super.detach();
  }

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! ParallaxParentData) {
      child.parentData = ParallaxParentData();
    }
  }

  @override
  void performLayout() {
    size = constraints.biggest;

    // Force the background to take up all available width
    // and then scale its height based on the image's aspect ratio.
    final background = child!;
    final backgroundImageConstraints =
    BoxConstraints.tightFor(width: size.width);
    background.layout(backgroundImageConstraints, parentUsesSize: true);

    // Set the background's local offset, which is zero.
    (background.parentData as ParallaxParentData).offset = Offset.zero;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // Get the size of the scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;

    // Calculate the global position of this list item.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final backgroundOffset =
    localToGlobal(size.centerLeft(Offset.zero), ancestor: scrollableBox);

    // Determine the percent position of this list item within the
    // scrollable area.
    final scrollFraction =
    (backgroundOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final background = child!;
    final backgroundSize = background.size;
    final listItemSize = size;
    final childRect =
    verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // Paint the background.
    context.paintChild(
        background,
        (background.parentData as ParallaxParentData).offset +
            offset +
            Offset(0.0, childRect.top));
  }
}


class cLocation {
  const cLocation({
    required this.name,
    required this.place,
    required this.distance,
    required this.imageUrl,
    required this.price,
  });

  final String name;
  final String place;
  final String price;
  final String distance;
  final String imageUrl;
}

const urlPrefix =
    'https://docs.flutter.dev/cookbook/img-files/effects/parallax';
const locations = [
  cLocation(
    name: 'Cleaning Shoes',
    place: 'Kigali, Gasabp ',
    distance: '1 km',
    price: "\$12",
    imageUrl: '$urlPrefix/01-mount-rushmore.jpg',
  ),
  cLocation(
    name: 'Gardens By The Bay',
    place: 'Kigali, Nyarugenge',
    distance: '30 m',
    price: "\$8",
    imageUrl: '$urlPrefix/02-singapore.jpg',
  ),
  cLocation(
    name: 'Moving to Town, Two seats available',
    place: 'Kigali',
    distance: '50 km',
    price: "\$50",
    imageUrl: '$urlPrefix/03-machu-picchu.jpg',
  ),
  cLocation(
    name: 'In need of a house Agent',
    place: 'Kigali',
    distance: '2 km',
    price: "\$15",
    imageUrl: '$urlPrefix/04-vitznau.jpg',
  ),
  cLocation(
    name: 'In need of a cleaner',
    place: 'Kigali',
    distance: '20 m',
    price: "\$4",
    imageUrl: '$urlPrefix/05-bali.jpg',
  ),
  cLocation(
    name: 'Need someone to take out my trash',
    place: 'Kigali, Kimironko',
    distance: '7 km',
    price: "\$23",
    imageUrl: '$urlPrefix/06-mexico-city.jpg',
  ),
  cLocation(
    name: 'I need a guide around Kigali',
    price: "\$78",
    distance: '120 km',
    place: 'Kigali',
    imageUrl: '$urlPrefix/07-cairo.jpg',
  ),
];