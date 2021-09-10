import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/bloc/trending_news/newstrending_bloc.dart';
import 'package:newsapp/models/trending_news.dart';
import 'package:newsapp/widgets/loading.dart';

class TrendingNews extends StatefulWidget {
  @override
  _TrendingNewsState createState() => _TrendingNewsState();
}

class _TrendingNewsState extends State<TrendingNews> {
  NewstrendingBloc newstrendingBloc = NewstrendingBloc();

  @override
  void initState() {
    super.initState();
    newstrendingBloc.add(GetDataTrendingNews());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => newstrendingBloc,
      child: BlocListener<NewstrendingBloc, NewstrendingState>(
        listener: (context, state) {
          if (state is NewstrendingError) {
            print('error di trending news');
          } else if (state is NewstrendingLoaded) {
            print('data trend load ok');
          }
        },
        child: BlocBuilder<NewstrendingBloc, NewstrendingState>(
            builder: (context, state) {
          if (state is NewstrendingInitial) {
            return isLoading();
          } else if (state is NewstrendingLoading) {
            return isLoading();
          } else if (state is NewstrendingLoaded) {
            return dataNewsVertical(state.trendingNewsModel);
          }
          return Container();
        }),
      ),
    );
  }

  Widget dataNewsVertical(TrendingNewsModel news) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: news.articles.length,
          itemBuilder: (context, i) {
            final dataNews = news.articles[i];
            return Card(
              shadowColor: Colors.black,
              elevation: 8,
              child: Container(
                width: double.infinity,
                height: 150,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            dataNews.urlToImage,
                            fit: BoxFit.cover,
                            height: 140,
                            width: 100,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dataNews.title,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            SizedBox(height: 10),
                            Text(dataNews.description, maxLines: 3),
                            SizedBox(height: 10),
                            Text(
                              dataNews.source.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
