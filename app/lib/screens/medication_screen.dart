import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class _Reminder {
  _Reminder({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.time,
    this.hasActions = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String? time;
  final bool hasActions;
  bool done = false;
}

class MedicationScreen extends StatefulWidget {
  const MedicationScreen({super.key});

  @override
  State<MedicationScreen> createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  final List<_Reminder> _items = [
    _Reminder(
        title: 'Medication — Morning',
        subtitle: 'Take 1 tablet of Heartline',
        icon: Icons.medication,
        color: const Color(0xFFFFDDE0),
        time: '07:30 AM',
        hasActions: true),
    _Reminder(
        title: 'Doctor — Dr. Rao',
        subtitle: 'City Clinic — General check-up',
        icon: Icons.local_hospital,
        color: const Color(0xFFDDF5E7)),
    _Reminder(
        title: 'Exercise — Morning',
        subtitle: 'Walk 20 minutes',
        icon: Icons.directions_walk,
        color: const Color(0xFFFFEFD0),
        time: '06:00'),
    _Reminder(
        title: 'Social — Community',
        subtitle: 'Tea & chat at Senior Center',
        icon: Icons.groups,
        color: const Color(0xFFE2E6FF)),
  ];

  void _markAllDone() {
    setState(() {
      for (final r in _items) {
        r.done = true;
      }
    });
    showMsg(context, 'All reminders marked as done');
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.maybePop(context),
                  icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Good morning',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600)),
                      Text('Reminders',
                          style: TextStyle(
                              fontSize: 13, color: AppColors.muted)),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => showMsg(context, 'Add reminder (demo)'),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.navy,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.white),
                        Text('Add',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                  'Tap a reminder for quick actions. Large buttons for easy tapping.',
                  style: TextStyle(fontSize: 12)),
            ),
            const SizedBox(height: 14),
            ..._items.map(_card),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                      label: 'Mark All Done',
                      height: 54,
                      fontSize: 15,
                      onPressed: _markAllDone),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PrimaryButton(
                      label: 'Need Urgent Help',
                      height: 54,
                      fontSize: 15,
                      color: AppColors.red,
                      onPressed: () =>
                          showMsg(context, 'Caregiver & ambulance alerted (demo)')),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
                "Tip: Use 'Need Urgent Help' to contact caregiver & ambulance simultaneously.",
                style: TextStyle(fontSize: 11, color: AppColors.muted)),
            const SizedBox(height: 6),
            const Text('All times shown are local. Tap any tile to open details.',
                style: TextStyle(fontSize: 11, color: AppColors.muted)),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _card(_Reminder r) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration:
                    BoxDecoration(color: r.color, shape: BoxShape.circle),
                child: Icon(r.icon, color: AppColors.ink),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(r.title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 2),
                    Text(r.subtitle,
                        style: const TextStyle(
                            fontSize: 13, color: AppColors.muted)),
                  ],
                ),
              ),
              if (r.done)
                const Icon(Icons.check_circle, color: AppColors.green)
              else if (r.time != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F3FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(r.time!, style: const TextStyle(fontSize: 11)),
                ),
            ],
          ),
          if (r.hasActions && !r.done) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                _action('Done', AppColors.green, Colors.white, () {
                  setState(() => r.done = true);
                }),
                const SizedBox(width: 8),
                _action('Snooze', AppColors.amber, AppColors.ink,
                    () => showMsg(context, 'Snoozed for 10 minutes')),
                const SizedBox(width: 8),
                _action('Need Help', AppColors.red, Colors.white,
                    () => showMsg(context, 'Caregiver notified (demo)')),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _action(String label, Color bg, Color fg, VoidCallback onTap) {
    return Expanded(
      child: SizedBox(
        height: 36,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bg,
            foregroundColor: fg,
            elevation: 0,
            padding: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: onTap,
          child: Text(label,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }
}
