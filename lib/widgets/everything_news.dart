import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/bloc/everything_news/news_bloc.dart';
import 'package:newsapp/models/news_models.dart';
import 'package:newsapp/widgets/loading.dart';
import 'package:url_launcher/url_launcher.dart';

class EverythingNews extends StatefulWidget {
  @override
  _EverythingNewsState createState() => _EverythingNewsState();
}

class _EverythingNewsState extends State<EverythingNews> {
  NewsBloc _newsBloc = NewsBloc();
  @override
  void initState() {
    super.initState();
    _newsBloc.add(GetNewsList());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _newsBloc,
      child: BlocListener<NewsBloc, NewsState>(
        listener: (context, state) {
          if (state is NewsError) {
            print('news error di horizontal');
          } else if (state is NewsLoaded) {
            print('data news horizontal ok');
          }
        },
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsInitial) {
              return isLoading();
            } else if (state is NewsLoading) {
              return isLoading();
            } else if (state is NewsLoaded) {
              return dataNewsHorizontal(state.newsModel);
            } else {
              return isLoading();
            }
          },
        ),
      ),
    );
  }

  Widget dataNewsHorizontal(NewsModel news) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: news.articles.length,
              itemBuilder: (context, i) {
                final dataNews = news.articles[i];
                return InkWell(
                  onTap: () async {
                    await launch(dataNews.url, forceWebView: true, enableJavaScript: true);
                  },
                  child: Card(
                    shadowColor: Colors.black,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      width: 300,
                      height: 100,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 3,
                              child: ClipRRect(
                                child: Image.network(
                                  dataNews.urlToImage,
                                  fit: BoxFit.cover,
                                ),
                              )),
                          SizedBox(height: 20),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dataNews.title,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                  ),
                                  SizedBox(height: 15),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }) ??
          Container(),
    );
  }
}
