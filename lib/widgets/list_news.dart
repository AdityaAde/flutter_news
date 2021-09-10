import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/bloc/everything_news/news_bloc.dart';
import 'package:newsapp/models/news_models.dart';

class ListNews extends StatefulWidget {
  @override
  _ListNewsState createState() => _ListNewsState();
}

class _ListNewsState extends State<ListNews> {
  final NewsBloc newsBloc = NewsBloc();

  @override
  void initState() {
    super.initState();
    newsBloc.add(GetNewsList());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => newsBloc,
        //memunculkan pesan error
        child: BlocListener<NewsBloc, NewsState>(
          listener: (context, state) {
            if (state is NewsError) {
              // ignore: deprecated_member_use
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.msgError),
                ),
              );
            }
          },
          //membangun output dari covidState
          child: BlocBuilder<NewsBloc, NewsState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is NewsInitial) {
                return _buildLoading();
              } else if (state is NewsLoading) {
                return _buildLoading();
              } else if (state is NewsLoaded) {
                return _buildCard(context, state.newsModel);
              } else if (state is NewsError) {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, NewsModel model) {
    return ListView.builder(
      itemCount: model.articles.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(8.0),
          child: Card(
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text((model != null)
                      ? model.articles[index].title
                      : 'tidak ada data')
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
