import 'dart:io';

import 'package:web_scraper/web_scraper.dart';

void main() async {
  var webScraper = WebScraper('https://github.com');
  var output = '';

  // add the header
  output += '| Package | Description | Link | Gif | Image | Figma |\n';
  output += '| ------- | ----------- | ---- | --- | ----- | ----- |\n';
  var pageIndex = 1;
  var lastPageReached = false;
  List elements = [];
  // first retrieve all elements
  while (!lastPageReached) {
    if (await webScraper.loadWebPage(
      '/orgs/Iconica-Development/repositories?page=$pageIndex',
    )) {
      // add all web elements to the list
      elements += webScraper.getElement('a.d-inline-block', ['href']);
      // check if this is the last page
      if (webScraper.getElement('a.next_page', ['href']).isEmpty) {
        lastPageReached = true;
      } else {
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
      await Future.delayed(Duration(milliseconds: 200));
      var figmaLink = '';

      var pageLink = 'https://github.com/Iconica-Development/$name';

      // check the master branch to search for .gif files
      if (await webScraper.loadWebPage('/Iconica-Development/$name')) {
        var images = <String>[];
        var gifs = <String>[];
        var descriptionElement = webScraper.getElement('p.f4%20my-3', []);

        // strip leading and ending whitespace from the string
        var description = (descriptionElement.isNotEmpty)
            ? descriptionElement.first['title'].toString().trim()
            : 'No description';
        var fileLinks = webScraper.getElement('a.Link--primary', ['href']);
        for (var fileLink in fileLinks) {
          var href = fileLink['attributes']['href'].toString();

          (switch (href) {
            (String a) when a.endsWith('.gif') => gifs,
            // check for jpg, jpeg, png, svg
            (String a) when a.endsWith('.jpg') => images,
            (String a) when a.endsWith('.jpeg') => images,
            (String a) when a.endsWith('.png') => images,
            (String a) when a.endsWith('.svg') => images,
            _ => [],
          })
              .add('https://github.com$href');
        }

        await Future.delayed(Duration(milliseconds: 100));
        // look in the readme.md file for a gif or mp4 reference
        if (await webScraper
            .loadWebPage('/Iconica-Development/$name/blob/master/README.md')) {
          var readmeContent = webScraper.getPageContent();
          var figmaLinkRegex = RegExp(r'https://[www.]*figma.com/[^)\s]*');
          var matches = figmaLinkRegex.allMatches(readmeContent);

          if (matches.isNotEmpty) {
            // Take the first Figma link found
            figmaLink = matches.first.group(0) ?? '';
          }
          var imageElements = webScraper.getElement('img', ['src']);
          for (var element in imageElements) {
            var src = element['attributes']['src'].toString();
            // check if src contains twitter
            // TODO(freek): filter out the images that are not in the readme.md file
            if (!src.contains('githubassets') || src.contains('Iconica')) {
              (switch (src) {
                (String a) when a.endsWith('.gif') => gifs,
                // check for jpg, jpeg, png, svg
                (String a) when a.endsWith('.jpg') => images,
                (String a) when a.endsWith('.jpeg') => images,
                (String a) when a.endsWith('.png') => images,
                (String a) when a.endsWith('.svg') => images,
                _ => <String>[],
              })
                  .add(src.startsWith('https://')
                      ? src
                      : 'https://github.com$src');
            }
          }
        }
        if (gifs.isNotEmpty || images.isNotEmpty) {
          // combine all the links into one string
          var chosenGif = gifs.isNotEmpty
              ? '![Example GIF of package](${gifs.first})'
              : ' no gif ';
          var chosenImage = images.isNotEmpty
              ? '![Example Image of package](${images.first})'
              : ' no image';
          // only show the figma link if it is not empty
          var figma = figmaLink.isNotEmpty ? '[Figma]($figmaLink)' : '';
          output +=
              '| $name | $description | [code]($pageLink) | $chosenGif | $chosenImage | $figma |\n';
        }
      }
    }
  }
  print(output);

  var file = File('../profile/FEATURES.md');
  var contents = file.readAsStringSync();
  contents = contents.split('List of Flutter Packages').first;
  output = contents + 'List of Flutter Packages\n\n' + output;

  File('../profile/FEATURES.md').writeAsStringSync(output);
}
