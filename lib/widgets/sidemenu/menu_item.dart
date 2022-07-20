// import 'package:hanouty/settings/themes.dart';
// import 'package:flutter/material.dart';

// class NavBarItem extends StatefulWidget {
//   final IconData? icon;
//   final Function? touched;
//   final bool? active;
//   final String? text;
//   final double? iconSize;

//   const NavBarItem({
//     Key? key,
//     this.icon,
//     this.touched,
//     this.active,
//     this.text,
//     this.iconSize,
//   }) : super(key: key);

//   @override
//   NavBarItemState createState() => NavBarItemState();
// }

// class NavBarItemState extends State<NavBarItem> {
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: widget.active!
//           ? Theme.of(context).colorScheme.background
//           : Colors.transparent,
//       child: InkWell(
//         onTap: () {
//           //  Exception(widget.icon);
//           widget.touched!();
//           widget.touched!();
//         },
//         hoverColor: MThemeData.accentColorm,
//         child: AnimatedContainer(
//           decoration: const BoxDecoration(
//             borderRadius: BorderRadius.only(
//                 bottomRight: Radius.circular(20),
//                 topRight: Radius.circular(20)),
//           ),
//           margin: const EdgeInsets.symmetric(vertical: 6),
//           height: 40,
//           width: 80,
//           duration: const Duration(milliseconds: 200),
//           child: Row(
//             children: [
//               Container(
//                 width: 3,
//                 color: widget.active!
//                     ? Theme.of(context).colorScheme.primary
//                     : Theme.of(context).colorScheme.onPrimary.withOpacity(0.6),
//               ),
//               const SizedBox(
//                 width: 15,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 4, right: 4),
//                 child: Icon(
//                   widget.icon,
//                   color: widget.active!
//                       ? Theme.of(context).colorScheme.primary
//                       : Theme.of(context).colorScheme.onPrimary,
//                   size: widget.iconSize ?? 24,
//                 ),
//               ),
//               const SizedBox(
//                 width: 15,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
