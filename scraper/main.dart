import 'dart:io';

import 'package:intl/intl.dart';
import 'package:web_scraper/web_scraper.dart';

void main() async {
  final webScraper = WebScraper('https://github.com');
  var output = '';

  // add the header
  output +=
      '| Package | Latest Tag | Last Updated | Melos | Link | Example | Features |\n';
  output +=
      '| ------- | ---------- | ------------ | ----- | ---- | ------- | -------- |\n';
  var pageIndex = 1;
  var lastPageReached = false;
  List elements = [];
  // first retrieve all elements
  while (!lastPageReached) {
    if (await webScraper.loadWebPage(
        '/orgs/Iconica-Development/repositories?page=$pageIndex')) {
      // add all web elements to the list
      elements += webScraper.getElement('a.d-inline-block', ['href']);
      // check if this is the last page
      if (webScraper.getElement('a.next_page', ['href']).isEmpty) {
        lastPageReached = true;
        print('Last page reached ($pageIndex)');
      } else {
        print('Page $pageIndex loaded');
        pageIndex++;
      }
    }
  }
  // sort the elements by name
  elements.sort((a, b) => a['attributes']['href'] == b['attributes']['href']
      ? 0
      : a['attributes']['href']
          .toString()
          .compareTo(b['attributes']['href'].toString()));

  for (var element in elements) {
    var name = element['attributes']['href']
        .toString()
        .split('/Iconica-Development/')
        .last;

    // Check if the repository name starts with 'flutter_' or has 'component' topic
    bool isComponent = name.startsWith('flutter_');
    if (!isComponent) {
      // Load the repository page to check for topics
      if (await webScraper.loadWebPage('/Iconica-Development/$name')) {
        var topics = webScraper.getElement('a.topic-tag.topic-tag-link', []);
        isComponent = topics
            .any((topic) => topic['title'].toString().contains('component'));
      }
    }

    if (isComponent) {
      var melos = false;
      var features = false;
      await Future.delayed(Duration(milliseconds: 100));
      if (await webScraper.loadWebPage('/Iconica-Development/$name')) {
        var elements = webScraper.getElement('a.Link--primary', ['href']);
        for (var element in elements) {
          if (element['title'].toString().contains('melos')) {
            melos = true;
          }
          // check to see if there is a FEATURES.md file if so link to it
          if (element['title'].toString().contains('FEATURES.md')) {
            features = true;
          }
          if (melos && features) break;
        }
      }
      await Future.delayed(Duration(milliseconds: 100));
      if (await webScraper.loadWebPage('/Iconica-Development/$name/releases')) {
        var elements = webScraper.getElement('a.Link--primary', ['href']);

        var releaseTimes =
            webScraper.getElement('relative-time.no-wrap', ['datetime']);

        var link = 'https://github.com/Iconica-Development/$name';
        var highestTag = (elements.isNotEmpty)
            ? elements.first['title'].toString()
            : 'Not Released';
        var releaseTime = releaseTimes.isNotEmpty
            ? DateFormat("yyyy-MM-dd").format(
                DateTime.parse(releaseTimes.first['attributes']['datetime']))
            : '';
        output +=
            '| $name | $highestTag | $releaseTime | ${melos ? 'Yes' : 'No'} | [code]($link) | [example]($link/tree/master/example) | ${features ? '[features]($link/tree/master/FEATURES.md)' : ''} |\n';
      }
    }
  }
  print(output);

  var file = File('../profile/README.md');
  var contents = file.readAsStringSync();
  contents = contents
      .split(
          'A list of all the Gifs of the packages can be found [here](./profile/FEATURES.md)')
      .first;
  output = contents +
      'A list of all the Gifs of the packages can be found [here](./profile/FEATURES.md)\n\n' +
      output;

  File('../profile/README.md').writeAsStringSync(output);
}
