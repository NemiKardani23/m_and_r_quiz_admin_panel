import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'dart:ui_web' as ui_web;


class NkWebVideoPlayer extends StatefulWidget {
  const NkWebVideoPlayer({
    required this.id,
    this.bytes,
    this.mimeType,
    this.networkUrl,
    super.key,
  });

  // Unique id
  final String id;

  // Mimetype like video/mp4, video/webm
  final String? mimeType;

  // Local video data
  final Uint8List? bytes;

  // Network video URL
  final String? networkUrl;

  @override
  State<NkWebVideoPlayer> createState() => _NkWebVideoPlayerState();
}

class _NkWebVideoPlayerState extends State<NkWebVideoPlayer> {
  late html.VideoElement _videoElement;

  @override
  void initState() {
    super.initState();
    _videoElement = html.VideoElement();
    _videoElement.controls = true;
    _videoElement.style.objectFit = 'contain'; // Maintain aspect ratio

    if (widget.networkUrl != null) {
      // Load video from network URL
      _videoElement.src = widget.networkUrl!;
    } else if (widget.bytes != null && widget.mimeType != null) {
      // Load video from local data bytes
      final sourceElement = html.SourceElement();
      sourceElement.type = "video/${widget.mimeType}";
      sourceElement.src = Uri.dataFromBytes(widget.bytes!, mimeType: "video/${widget.mimeType}").toString();
      _videoElement.children = [sourceElement];
    } else {
      throw ArgumentError("Either 'networkUrl' or 'bytes' and 'mimeType' must be provided.");
    }

    ui_web.platformViewRegistry.registerViewFactory(widget.id, (int viewId) => _videoElement);
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: widget.id);
  }
}
