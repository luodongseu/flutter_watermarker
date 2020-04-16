
/// 背景水印画笔
class BackgroundWaterMarkerPainter extends CustomPainter {
  /// 水印文字
  final String text;

  /// 文字大小
  final double textSize;

  /// 水平空间
  final double verticalSpacing;

  /// 垂直空间
  final double horizontalSpacing;

  BackgroundWaterMarkerPainter({
    this.text,
    this.textSize = 14.0,
    this.verticalSpacing = 28.0,
    this.horizontalSpacing = 68.0,
  });

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    TextPainter painter = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          text: '${text ?? '自定义文字'}',
          style: TextStyle(color: Colors.grey.withOpacity(0.1), fontSize: 14),
        ));
    painter.layout(minWidth: 0);
//    canvas.drawRect(
//        Rect.fromCenter(
//            center: Offset(size.width / 2, size.height / 2),
//            width: size.width,
//            height: size.height),
//        new Paint()
//          ..color = Colors.white
//          ..style = PaintingStyle.fill);
    double textHeight = painter.height;
    double textWidth = painter.width;
    double dy = -horizontalSpacing;
    while (dy < size.height) {
      dy += horizontalSpacing + textHeight;
      double dx = -(dy / verticalSpacing);
      while (dx < size.width) {
        canvas.save();
        canvas.translate(dx, dy);
        canvas.rotate(-45.0 * math.pi / 180.0);
        painter.paint(canvas, Offset(0, 0));
        canvas.restore();
        dx += verticalSpacing + textWidth;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}


/// 背景水印器
/// 
/// @author luodong
/// 
/// ```
/// BackgroundWaterMarker(
///   text: '我的水印文字',
///   child: Container(
///     ....
///   )
/// )
/// ```
class BackgroundWaterMarker extends StatelessWidget {
  /// 子元素
  final Widget child;

  /// 水印文字
  final String text;

  /// 文字大小
  final double textSize;

  /// 水平空间
  final double verticalSpacing;

  /// 垂直空间
  final double horizontalSpacing;

  const BackgroundWaterMarker(
      {Key key,
      this.child,
      this.text,
      this.textSize,
      this.verticalSpacing,
      this.horizontalSpacing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
            child: CustomPaint(
          painter: BackgroundWaterMarkerPainter(
              text: text,
              textSize: textSize,
              horizontalSpacing: horizontalSpacing,
              verticalSpacing: verticalSpacing),
        )),
        child ?? Container(),
      ],
    );
  }
