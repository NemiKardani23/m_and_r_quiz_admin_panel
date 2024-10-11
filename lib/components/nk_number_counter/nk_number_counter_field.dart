import 'package:m_and_r_quiz_admin_panel/export/___app_file_exporter.dart';

class NkTimeCounterField extends StatefulWidget {
  final int minValueMinutes;
  final int maxValueMinutes;
  final int minValueSeconds;
  final int maxValueSeconds;

  final ValueChanged<Duration>? onChanged;

  const NkTimeCounterField(
      {super.key,
      this.minValueMinutes = 0,
      this.maxValueMinutes = 59,
      this.minValueSeconds = 0,
      this.maxValueSeconds = 59,
      this.onChanged});

  @override
  State<NkTimeCounterField> createState() {
    return _NkTimeCounterFieldState();
  }
}

class _NkTimeCounterFieldState extends State<NkTimeCounterField> {
  int minutes = 0;
  int seconds = 0;

  TextEditingController minutesController = TextEditingController(text: "0");
  TextEditingController secondsController = TextEditingController(text: "0");

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
