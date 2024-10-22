import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';

class NkToggleButton extends StatefulWidget {
  final List<String> options;
  final Color activeColor;
  final Color inactiveColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final Function(int) onToggle;
  final int initialIndex; // New parameter for initial index

  const NkToggleButton({
    super.key,
    required this.options,
    this.activeColor = selectionColor,
    this.inactiveColor = Colors.grey,
    this.selectedTextColor = Colors.white,
    this.unselectedTextColor = primaryTextColor,
    required this.onToggle,
    this.initialIndex = 0, // Default value for initial index
  });

  @override
  State<NkToggleButton> createState() => _NkToggleButtonState();
}

class _NkToggleButtonState extends State<NkToggleButton> {
  late List<bool> _selections;

  @override
  void initState() {
    super.initState();
    _selections = List<bool>.filled(widget.options.length, false);
    // Set the initial selection based on the initialIndex
    if (widget.initialIndex >= 0 &&
        widget.initialIndex < widget.options.length) {
      _selections[widget.initialIndex] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: _selections,
      onPressed: (int index) {
        setState(() {
          // Deselect all other buttons
          for (int i = 0; i < _selections.length; i++) {
            _selections[i] = i == index;
          }
          widget
              .onToggle(index); // Call the onToggle callback with the new index
        });
      },
      color: widget.unselectedTextColor,
      selectedColor: widget.selectedTextColor,
      fillColor: widget.activeColor,
      borderColor: widget.inactiveColor,
      borderRadius: NkGeneralSize.nkCommonBorderRadius,
      constraints: const BoxConstraints(minWidth: 48.0, minHeight: 30.0),
      children: widget.options
          .map((option) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: MyRegularText(
                  label: option,
                  color: _selections[widget.options.indexOf(option)]
                      ? widget.selectedTextColor
                      : widget.unselectedTextColor,
                  fontSize: NkFontSize.smallFont,
                ),
              ))
          .toList(),
    );
  }
}
