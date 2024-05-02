import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:usersapiapp/model/news.dart';

class NewsDetailPage extends StatelessWidget {
  final NewsArticle article;
  const NewsDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    // Add this function to launch URLs
    Future<void> _launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Text(
                article.title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              if (article.imageUrl.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    article.imageUrl,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 5),
              Text(
                article.content,
                textAlign: TextAlign.center,
              ),
              Text(
                article.description,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text('Post by '), Text(article.author)],
              ),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  _launchURL(article.url);
                },
                child: Text(
                  article.url,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 30,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
