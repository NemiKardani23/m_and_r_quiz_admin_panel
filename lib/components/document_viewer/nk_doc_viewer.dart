import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';

class NkWebDocumentViewer extends StatefulWidget {
  const NkWebDocumentViewer({
    required this.id,
    this.networkUrl,
    super.key,
  });

  // Unique id
  final String id;

  // Network document URL
  final String? networkUrl;

  @override
  State<NkWebDocumentViewer> createState() => _NkWebDocumentViewerState();
}

class _NkWebDocumentViewerState extends State<NkWebDocumentViewer> {
  late html.IFrameElement _iframeElement;
  bool _iframeRegistered = false;
  bool _isLoading = true; // Track loading state
  String _loadingStatus = "0%"; // Track loading percentage
  bool _loadError = false; // Track error state

  @override
  void initState() {
    super.initState();
    _createIFrame();
    _registerView();
  }

  // Create the iframe element and choose appropriate viewer based on file extension
  void _createIFrame() {
    _iframeElement = html.IFrameElement();

    if (widget.networkUrl != null) {
      if (_isPdf()) {
        // Use Google Docs Viewer for PDF files
        _iframeElement.src = widget.networkUrl!;
        setState(() {
          _isLoading = false; // Document is loaded
        });
      } else if (_isOfficeFormat()) {
        // Use Microsoft Office Viewer for Word, Excel, PowerPoint formats
        setState(() {
          _isLoading = false; // Document is loaded
        });
        _iframeElement.src =
            'https://view.officeapps.live.com/op/embed.aspx?src=${Uri.encodeComponent(widget.networkUrl!)}&embedded=false';
      } else {
        throw UnsupportedError("Unsupported document format");
      }
    } else {
      throw ArgumentError(
          "Network URL must be provided for viewing documents.");
    }

    // Configure iframe element properties
    _iframeElement.style.border = 'none';
    _iframeElement.style.width = '100%';
    _iframeElement.style.height = '100%';

    // Handle iframe load event
    _iframeElement.onLoad.listen((event) {
      if (mounted) {
        setState(() {
          _isLoading = false; // Document is loaded
        });
      }
    });

    // Handle iframe error event
    _iframeElement.onError.listen((event) {
      setState(() {
        _loadError = true; // Error occurred while loading
        _isLoading = false;
      });
    });
  }

  // Register the iframe as a platform view
  void _registerView() {
    if (!_iframeRegistered) {
      ui_web.platformViewRegistry
          .registerViewFactory(widget.id, (int viewId) => _iframeElement);
      _iframeRegistered = true;
    }
  }

  // Helper to check if the document is a PDF
  bool _isPdf() {
    return widget.networkUrl != null &&
        widget.networkUrl!.toLowerCase().endsWith('.pdf');
  }

  // Helper to check if the document is an Office format (Word, Excel, PowerPoint)
  bool _isOfficeFormat() {
    return widget.networkUrl != null &&
        (widget.networkUrl!.toLowerCase().endsWith('.docx') ||
            widget.networkUrl!.toLowerCase().endsWith('.pptx') ||
            widget.networkUrl!.toLowerCase().endsWith('.xlsx'));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Document view (iframe)
        LayoutBuilder(
          builder: (context, constraints) {
            // Only update iframe size dynamically without recreating the iframe
            _iframeElement.style.width = '${constraints.maxWidth}px';
            _iframeElement.style.height = '${constraints.maxHeight}px';

            return SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: HtmlElementView(viewType: widget.id),
            );
          },
        ),

        // Loading indicator
        if (_isLoading)
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const NkLoadingWidget(),
                const SizedBox(height: 16),
                Text('Loading... $_loadingStatus'),
              ],
            ),
          ),

        // Error message if the document fails to load
        if (_loadError)
          const Center(
            child: Text(
              'Error loading document.',
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          ),
      ],
    );
  }

  @override
  void didUpdateWidget(covariant NkWebDocumentViewer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Only recreate iframe if widget properties change
    if (widget.networkUrl != oldWidget.networkUrl) {
      _createIFrame();
      setState(() {
        _isLoading = true; // Show loading indicator again
        _loadError = false; // Reset error state
        _loadingStatus = "0%"; // Reset loading status
      });
    }
  }

  @override
  void dispose() {
    // No need to unregister the view since it cannot be unregistered
    super.dispose();
  }
}
