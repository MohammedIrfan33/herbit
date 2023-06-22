import 'package:flutter/material.dart';
class result extends StatefulWidget {
 final String text;

  const result({super.key, required this.text});

  @override
  State<result> createState() => _resultState();
}

class _resultState extends State<result> {
  String description='';
  void prediction() {
    String predict = widget.text.trim();
    print("predict $predict");
    print('type ${predict.runtimeType}');
 // Define the 'description' variable here

    if (predict == "Tulsi") {
      description = "ulsi's broad-spectrum antimicrobial activity, which includes activity against a range of "
          "human and animal pathogens, suggests it can be used as a hand sanitizer, mouthwash and water purifier as"
          " well as in animal rearing, wound healing, the preservation of food stuffs and herbal raw materials and"
          " traveler's health";
    } else if (predict == "Curry") {
      description = "Curry leaves (Murraya koenigii) or sweet neem leaves...";
    } else if (predict == "Drumstick") {
      description = "Drumstick leaves are rich in antioxidants, such as vitamin C...";
    } else if (predict == "Mint") {
      description = "Mint leaves create a cool sensation in the mouth...";
    } else if (predict == "Mango") {
      description = "Mango leaves have antibacterial properties that help treat...";
    } else if (predict == "Lemon") {
      description = "Lemon leaves can be wrapped around seafood and meats...";
    } else if (predict == "Indian Mustard") {
      description = "May help boost immunity- Mustard leaves are loaded with...";
    } else if (predict == "Neem") {
      description = "All parts of the neem tree- leaves, flowers, seeds...";
    } else if (predict == "Jackfruit") {
      description = "It is a very effective anti-ageing herb since it slows...";
    } else if (predict == "Rasna") {
      description = "Laden with plant-based compounds that showcase strong Ushna...";
    } else {
      description = "Invalid";
    }

    print("description $description"); // Print the 'description' value
    // You can use the 'description' value in other parts of your code as needed
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    prediction();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 200,),
              Row(
                children: [
                  const Text('Name :',style: TextStyle(fontSize: 25),),
                  const SizedBox(width: 30,),
                  Text(widget.text,style: const TextStyle(fontSize: 25,color: Colors.green),),
                ],
              ),
              const SizedBox(height: 20,),
              const Text("Description :",style: TextStyle(fontSize: 25),),
              const SizedBox(height: 20,),
              Expanded(
                  flex: 3,
                  child: Text(description,maxLines: 20,style: const TextStyle(fontSize: 18,color: Colors.green)))
            ],
          ),
        ),
      ),
    );
  }
}
