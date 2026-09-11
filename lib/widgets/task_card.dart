import 'package:flutter/material.dart';
import '../models/task_data.dart';

class TaskCard extends StatelessWidget {
  final TaskData task;
  final double? cardHeight;

  const TaskCard({
    super.key,
    required this.task,
    this.cardHeight,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double responsiveHeight = cardHeight ?? size.height * 0.115;

    return Container(
      width: double.infinity,
      height: responsiveHeight,
      padding: EdgeInsets.fromLTRB(
        size.width * 0.035,
        size.height * 0.012,
        size.width * 0.035,
        size.height * 0.010,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFCDEBDD),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.22),
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF72777A),
                  ),
                ),
                SizedBox(height: size.height * 0.008),
                Text(
                  task.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.25,
                    color: Color(0xFF353A3D),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: size.width * 0.025),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                task.date,
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFF64696C),
                ),
              ),
              Text(
                task.time,
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFF64696C),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}