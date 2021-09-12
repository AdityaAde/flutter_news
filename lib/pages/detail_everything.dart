import 'package:flutter/material.dart';
import 'package:newsapp/models/news_models.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailNews extends StatelessWidget {
  final Article detailNews;

  const DetailNews({Key key, this.detailNews}) : super(key: key);

  Future<void> openUrl(String url) async {
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Today'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            ClipRRect(
              child: Image.network(detailNews.urlToImage) ??
                  Text('Tidak ada koneksi'),
            ),
            SizedBox(height: 10),
            Text(
              detailNews.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            SizedBox(height: 20),
            Text(detailNews.content),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await launch(detailNews.url,
                    forceWebView: true, enableJavaScript: true);
              },
              child: Text('Baca selengkapnya'),
            )
          ],
        ),
      ),
    );
  }
}
