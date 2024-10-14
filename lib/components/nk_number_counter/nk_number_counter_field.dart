import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';

class NkTimeCounterField extends StatefulWidget {
  final int minValueMinutes;
  final int maxValueMinutes;
  final int minValueSeconds;
  final int maxValueSeconds;

  final ValueChanged<Duration>? onChanged;

  // Make initialDuration nullable
  final Duration? initialDuration;

  const NkTimeCounterField({
    super.key,
    this.minValueMinutes = 0,
    this.maxValueMinutes = 59,
    this.minValueSeconds = 0,
    this.maxValueSeconds = 59,
    this.onChanged,
    this.initialDuration, // Nullable initial duration
  });

  @override
  State<NkTimeCounterField> createState() {
    return _NkTimeCounterFieldState();
  }
}

class _NkTimeCounterFieldState extends State<NkTimeCounterField> {
  late int minutes;
  late int seconds;

  late TextEditingController minutesController;
  late TextEditingController secondsController;

  @override
  void initState() {
    super.initState();

    // If initialDuration is provided, use its values, otherwise default to 0
    minutes = widget.initialDuration?.inMinutes ?? 0;
    seconds = (widget.initialDuration?.inSeconds??0) % 60 ;

    // Initialize the text controllers with the initial values
    minutesController = TextEditingController(text: "$minutes");
    secondsController = TextEditingController(text: "$seconds");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Minutes Counter
        Column(
          children: [
            const Text("Minutes"),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_drop_up),
                  onPressed: () {
                    setState(() {
                      if (minutes < widget.maxValueMinutes) {
                        minutes++;
                      }
                      minutesController.text = "$minutes";
                      widget.onChanged?.call(Duration(minutes: minutes, seconds: seconds));
                    });
                  },
                ),
                SizedBox(
                  width: 40,
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: minutesController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      setState(() {
                        minutes = int.tryParse(value) ?? minutes;
                        widget.onChanged?.call(Duration(minutes: minutes, seconds: seconds));
                      });
                    },
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_drop_down),
                  onPressed: () {
                    setState(() {
                      if (minutes > widget.minValueMinutes) {
                        minutes--;
                      }
                      minutesController.text = "$minutes";
                      widget.onChanged?.call(Duration(minutes: minutes, seconds: seconds));
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 16),
        // Seconds Counter
        Column(
          children: [
            const Text("Seconds"),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_drop_up),
                  onPressed: () {
                    setState(() {
                      if (seconds < widget.maxValueSeconds) {
                        seconds++;
                      } else {
                        // Increment minutes if seconds exceed 59
                        if (minutes < widget.maxValueMinutes) {
                          minutes++;
                          seconds = 0;
                        }
                      }
                      secondsController.text = "$seconds";
                      minutesController.text = "$minutes";
                      widget.onChanged?.call(Duration(minutes: minutes, seconds: seconds));
                    });
                  },
                ),
                SizedBox(
                  width: 40,
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: secondsController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      setState(() {
                        int totalSeconds = int.tryParse(value) ?? seconds;
                        // Convert total seconds into minutes and seconds
                        minutes = totalSeconds ~/ 60;
                        seconds = totalSeconds % 60;

                        minutesController.text = "$minutes";
                        secondsController.text = "$seconds";
                        widget.onChanged?.call(Duration(minutes: minutes, seconds: seconds));
                      });
                    },
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_drop_down),
                  onPressed: () {
                    setState(() {
                      if (seconds > widget.minValueSeconds) {
                        seconds--;
                      } else {
                        // Decrease minutes if seconds go below 0
                        if (minutes > widget.minValueMinutes) {
                          minutes--;
                          seconds = 59;
                        }
                      }
                      secondsController.text = "$seconds";
                      minutesController.text = "$minutes";
                      widget.onChanged?.call(Duration(minutes: minutes, seconds: seconds));
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
