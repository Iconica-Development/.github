import 'dart:io';

import 'package:web_scraper/web_scraper.dart';

void main() async {
  final webScraper = WebScraper('https://github.com');
  var output = '';

  // add the header
  output += '| Package | Latest Tag | Link | Example |\n';
  output += '| ------- | ---------- | ---- | ------- |\n';
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
    if (name.startsWith('flutter_')) {
      await Future.delayed(Duration(milliseconds: 200));
      if (await webScraper.loadWebPage('/Iconica-Development/$name/releases')) {
        var elements = webScraper.getElement('a.Link--primary', ['href']);
        var link = 'https://github.com/Iconica-Development/$name';
        var highestTag = (elements.isNotEmpty)
            ? elements.first['title'].toString()
            : 'Not Released';
        output +=
            '| $name | $highestTag | [code]($link) | [example]($link/tree/master/example) |\n';
      }
    }
  }
  print(output);

  var file = File('../profile/README.md');
  var contents = file.readAsStringSync();
  contents = contents.split('List of Flutter Packages').first;
  output = contents + 'List of Flutter Packages\n\n' + output;

  File('../profile/README.md').writeAsStringSync(output);
}
