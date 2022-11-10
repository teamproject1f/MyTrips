import 'package:flutter/material.dart';

Widget searchBar({
  required context,
  bool readOnly = true,
  double height = 40,
  double width = double.infinity,

}){
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    height: height,
    width: width,
    child: TextFormField(
      readOnly: readOnly,
      style: const TextStyle(color: Colors.grey),
      // onTap: () => navigateTo(context, SearchScreen()),
      decoration: InputDecoration(
        border: OutlineInputBorder( borderRadius: BorderRadius.circular(15)),
        filled: true,
        // fillColor: SocialCubit.get(context).unreadMessage,
        disabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(15)),
        hintText: 'LocaleKeys.search.tr()',
        hintStyle: const TextStyle(fontSize: 15,color: Colors.grey),
        prefixIcon: const Icon(Icons.search,color: Colors.grey,),
      ),
    ),
  );
}