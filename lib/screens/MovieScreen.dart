import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/MovieCard.dart';
import 'package:movieapp/cubit/movie_cubit.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});


  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final kBg = Color(0xFF242A32);
  final searchController = TextEditingController();
  String searchQuery = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),

        backgroundColor: kBg,
        title: Text("What do you want to watch?",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.white
          ),),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              style: TextStyle(color: Colors.white),
              controller: searchController,
              onChanged: (value) {
                setState(() => searchQuery = value);
                context.read<MovieCubit>().searchMovie(value);
              },
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                hintText: "Search Movie",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: BlocBuilder<MovieCubit, MovieState>(
              builder: (context, state) {
                if (state is MovieLoading){
                  return Center(child: CircularProgressIndicator(),);
                }if(state is MovieError){
                  return Center(
                    child: Text(state.message),
                  );
                }if(state is MovieSuccess) {
                  if (state.movies.isEmpty) {
                    return Center(child: Text("No Product Found"),);
                  }
                  return SizedBox(
                    height: 200,
                    child: ListView.separated(
                      separatorBuilder: (context,index)=>SizedBox(
                      width: 16,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.movies.length,
                      itemBuilder: (context, index) =>
                          MovieCard(movie: state.movies[index]),
                    ),
                  );
                }return SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
