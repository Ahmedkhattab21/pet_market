import 'package:flutter/material.dart';
import 'package:pet_market/data.dart';
import 'package:pet_market/pet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "BalsamiqSans",
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(223, 224, 223, 1),
          titleTextStyle: TextStyle(
            fontSize: 30,
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
          centerTitle: true,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Pet> searchedList=[];
  TextEditingController searchText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Pet Market",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
          child: Column(
            children: [
              searchByPetType(context, searchText),
             const  SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(223, 224, 223, 1),
                  ),
                  child: searchText.text.trim().isEmpty?
                  ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 15,
                      );
                    },
                    itemBuilder: (BuildContext context, int index){
                      return petDesign(context, petList[index]);
                    },
                    itemCount: petList.length,
                  ):(searchText.text.trim().isNotEmpty && searchedList.isEmpty)?
                  Container(
                    alignment: Alignment.center,
                    child:const Text("No pet Yet",style: TextStyle(fontSize: 22),),
                  )
                      :ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 15,
                      );
                    },
                    itemBuilder: (BuildContext context, int index){
                      return petDesign(context, searchedList[index]);
                    },
                    itemCount: searchedList.length,
                  )
                  ,
                ),
              ),
            ],
          ),
        ));
  }



  Widget petDesign(BuildContext context ,Pet pet){
    print(pet.petLoveCount);
    print(pet.image);

    return Container(
      height: 125,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          SizedBox(
              height: 115,
              width: 115,
              child: Image.network(pet.image,fit: BoxFit.fitHeight,)),
          const SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                pet.petCategory,
                style: const TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.w400,
                    fontSize: 22),
              ),
              Text(
                pet.petType,
                style: const TextStyle(
                    color: Color.fromRGBO(172, 172, 172, 1),
                    fontWeight: FontWeight.w400,
                    fontSize: 15),
              ),
              Row(
                children: [
                  SizedBox(
                    height: 25,
                      width: 25,
                      child: Image.asset("assets/images/paw.png")),
                  const SizedBox(width: 10,),
                  Text(
                    "Pet Love:\t${pet.petLoveCount}",
                    style:const TextStyle(
                        color: Color.fromRGBO(219, 100, 0, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ),
                ],
              ),
            ],
          ),

        ],
      ),
    ) ;
}
  Widget searchByPetType(BuildContext context,TextEditingController textController) {
    return TextFormField(
      textInputAction: TextInputAction.done,
      controller: textController,
      cursorColor: Colors.black45,
      cursorHeight: 27,
      textAlign: TextAlign.start,
      enableSuggestions: true,
      keyboardType: TextInputType.text,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 22,
      ),
      onChanged: (String value){
        searchSubmitted(value);
        setState(() {
        });
      },
      onFieldSubmitted: (String? value) {
        searchSubmitted(value!);
      },
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 30),
          child: Image.asset("assets/images/search.png"),
        ),
        hintText: "Search by pet type",
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          color: Color.fromRGBO(172, 172, 172, 1),
          fontSize: 22,
        ),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        filled: true,
        fillColor: const Color.fromRGBO(223, 224, 223, 1),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromRGBO(223, 224, 223, 1),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromRGBO(223, 224, 223, 1),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromRGBO(223, 224, 223, 1),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  searchSubmitted(String text){
    searchedList=[];
    petList.forEach((element) {
      if(element.petType.toUpperCase()==text.toUpperCase()){
        searchedList.add(element);
      }
    });
    setState(() {
    });
  }

}
