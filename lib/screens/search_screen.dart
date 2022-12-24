import 'package:flutter/material.dart';
import 'package:google_flutter/colors.dart';
import 'package:google_flutter/services/api_service.dart';
import 'package:google_flutter/widgets/search_footer.dart';

import '../widgets/search_header.dart';
import '../widgets/search_result_component.dart';
import '../widgets/search_tabs.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //web header
              const SearchHeader(),
              //tabs for new images etc
              const Padding(
                padding: EdgeInsets.only(left: 150),
                child: SearchTabs(),
              ),
              const Divider(
                height: 0,
                thickness: 0.5,
              ),
              //search results components
              FutureBuilder(
                future: ApiService().fetchData(queryTerm: 'Rivaan'),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: 150,
                            top: 12,
                          ),
                          child: Text(
                            'About ${snapshot.data?['searchInformation']['formattedTotalResults']} results (${snapshot.data?['searchInformation']['formattedSearchTime']} seconds)',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color(0xFF70757A),
                            ),
                          ),
                        ),
                        ListView.builder(
                          itemCount: snapshot.data?['items'].length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(top: 10, left: 150),
                            child: SearchResultComponent(
                              desc: snapshot.data?['items'][index]['snippet'],
                              link: snapshot.data?['items'][index]['formattedUrl'],
                              linkToGo: snapshot.data?['items'][index]['link'],
                              text: snapshot.data?['items'][index]['title'],
                            ),
                          );
                        }),
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),

              //pagination button
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        '< Prev',
                        style: TextStyle(
                          fontSize: 15,
                          color: blueColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Next >',
                        style: TextStyle(
                          fontSize: 15,
                          color: blueColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const SearchFooter(),
            ]),
      ),
    );
  }
}
