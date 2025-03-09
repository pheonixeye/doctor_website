// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;
import 'dart:ui_web' as ui;

class MapViewIframe extends StatefulWidget {
  const MapViewIframe({
    super.key,
    required this.link,
    this.height,
    this.width,
  });
  final String link;
  final double? height;
  final double? width;
  @override
  State<MapViewIframe> createState() => _MapViewIframeState();
}

class _MapViewIframeState extends State<MapViewIframe> {
  final web.HTMLIFrameElement _iframeElement = web.HTMLIFrameElement();
  late final GlobalObjectKey key;
  @override
  void initState() {
    super.initState();
    //done CHECK LINK CHANGE WITH WIDGET CHANGE
    key = GlobalObjectKey(widget.link);

    _iframeElement.src = widget.link;
    _iframeElement.style.border = 'none';
    _iframeElement.style.height =
        widget.height == null ? '100%' : '${widget.height}%';
    _iframeElement.style.width =
        widget.width == null ? '100%' : '${widget.width}%';
    _iframeElement.name = widget.link;

    ui.platformViewRegistry.registerViewFactory(
      'iframeElement${widget.link}',
      (int viewId) => _iframeElement,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(20),
          boxShadow: const [
            BoxShadow(
              blurRadius: 3,
              spreadRadius: 3,
              offset: Offset(3, 3),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Center(
          child: IgnorePointer(
            child: HtmlElementView(
              key: key,
              viewType: 'iframeElement${widget.link}',
            ),
          ),
        ),
      ),
    );
  }
}
