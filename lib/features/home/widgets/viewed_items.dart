import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

class ViewedItems extends StatefulWidget {
  const ViewedItems({Key? key}) : super(key: key);

  @override
  State<ViewedItems> createState() => _ViewedItemsState();
}

class _ViewedItemsState extends State<ViewedItems> {
  final List<String> viewedItems = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9D9BF3fLStmwf-TRvBKm3TxcQETcu6O3jpg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGBL5vKGaS6DrLGNyvEr3mDMQrBu2us2z7_g&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5sR7D2kTep2vKlKfQ6QlKvdX4_WfQ66WFug&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLTWedIclPMBY1_qOMt0nxMtMm70p28MzJdw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXxHlQU19oFZewzbwLa_FMV1vtneqd_ICn_g&usqp=CAU',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Related to items you\'ve viewed',
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 20,
                    color: GlobalVariables.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 16,
                ),
              ),
            ],
          ),
          Container(
            height: 200,
            color: GlobalVariables.backgroundColor,
            padding: const EdgeInsets.all(10),
            child: Card(
              color: GlobalVariables.whiteColor,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: viewedItems.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff000000),
                          spreadRadius: 1,
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        fit: BoxFit.fitHeight,
                        // width: 150,
                        image: NetworkImage(
                          viewedItems[index],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
