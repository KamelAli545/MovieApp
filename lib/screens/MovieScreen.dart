import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/MovieCard.dart';
import 'package:movieapp/cubit/movie_cubit.dart';
import 'package:movieapp/widgets/categoryRow.dart';
import 'package:movieapp/widgets/movieSkeleton.dart';
import 'package:movieapp/widgets/movieTab.dart';
import 'package:movieapp/widgets/drawer.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});


  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final kBg = Color(0xFF242A32);
  final searchController = TextEditingController();
  String searchQuery = '';
  int _selectedTab=0;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
  void _selectTab(int index) {
    searchController.clear();
    setState(() {
      _selectedTab = index;
      searchQuery = '';
    });
    context.read<MovieCubit>().loadCategory(movieTabs[index].category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
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
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              controller: searchController,
              onChanged: (value) {
                setState(() => searchQuery = value);
                context.read<MovieCubit>().searchMovie(value);
              },
              decoration: InputDecoration(
                focusedBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.white)
                ),

                suffixIcon: Icon(Icons.search,
                color: Colors.white,
                ),
                hintText: "Search Movie",
                hintStyle: TextStyle(
                  color: Colors.white
                ),
                border: OutlineInputBorder(

                    borderRadius: BorderRadius.circular(20)
                ),
              ),
            ),
          ),
          CategoryRow(
            selected: _selectedTab,
            onTap: _selectTab,
          ),
          SizedBox(height: 10,),
          Expanded(
            child: BlocBuilder<MovieCubit, MovieState>(
              builder: (context, state) {
                if (state is MovieLoading) {
                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    itemCount: 6,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.5,
                    ),
                    itemBuilder: (_, __) => const MovieSkeleton(),
                  );                }
                if (state is MovieError) {
                  return Center(child: Text(state.message, style: const TextStyle(color: Colors.white)));
                }
                if (state is MovieSuccess) {
                  if (state.movies.isEmpty) {
                    return const Center(child: Text('No Movies Found', style: TextStyle(color: Colors.white)));
                  }
                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    itemCount: state.movies.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.5,
                    ),
                    itemBuilder: (context, index) => MovieCard(movie: state.movies[index]).
                      animate(delay: (index <8?index*80:0).ms)
                    .fadeIn()
                    .slideY(begin: 0.2,),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          )        ],
      ),
    );
  }
}
