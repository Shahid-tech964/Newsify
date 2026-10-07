import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/viewmodel/bloc/home/bloc.dart';
import 'package:news_app/viewmodel/bloc/home/event.dart';
import 'package:news_app/viewmodel/bloc/home/state.dart';
import 'package:skeletonizer/skeletonizer.dart';

// CHANGED: Created Home screen placeholder for the main app
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeBloc>().add(AlbumApiEvent());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        final bloc = context.read<HomeBloc>();

        bloc.add(AlbumApiEvent());

        await bloc.stream.firstWhere(
          (state) => state is Success || state is Failure,
        );
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 5),
        child: BlocBuilder<HomeBloc, AlbumApiState>(
          builder: (context, state) {
            if (state is Failure) {
              return Center(child: Text(state.error));
            }

            return Skeletonizer(
              enabled: state is Loading,
              effect: const ShimmerEffect(
                baseColor: Color(0xFFE5E7EB),
                highlightColor: Color(0xFFF9FAFB),
                duration: Duration(milliseconds: 1200),
              ),
              child: ListView.builder(
                itemCount: state is Success
                    ? state.data.length > 30
                          ? 30
                          : state.data.length
                    : 15,
                itemBuilder: (_, index) {
                  return state is Success
                      ? NewsCard(
                          id: state.data[index].id,
                          title: state.data[index].title,
                          url: state.data[index].image,
                        )
                      : NewsCard(
                          id: 0,
                          title: "Loading title",
                          url:
                              'https://images.unsplash.com/photo-1605496036006-fa36378ca4ab?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                        );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  int? id;
  String? title;
  String? url;
  NewsCard({
    super.key,
    required this.id,
    required this.title,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = (url != null && url!.isNotEmpty)
        ? url!
        : 'https://placehold.co/600x400?text=No+Image';

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Image.network(imageUrl, width: 70, height: 70),
        title: Text(id.toString()),
        subtitle: Text(title ?? ""),
      ),
    );
  }
}
