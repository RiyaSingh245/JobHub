import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:job_hub/constants/app_constants.dart';
import 'package:job_hub/models/response/jobs/jobs_response.dart';
import 'package:job_hub/services/helpers/jobs_helper.dart';
import 'package:job_hub/views/common/app_style.dart';
import 'package:job_hub/views/common/reusable_text.dart';
import 'package:job_hub/views/ui/jobs/widgets/job_tile.dart';
import 'package:job_hub/views/ui/search/widgets/custom_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(kOrange.value),
        iconTheme: IconThemeData(
          color: Color(kLight.value),
        ),
        title: CustomField(
          hintText: "Search for a job",
          controller: search,
          onEditingComplete: () {
            setState(() {
              
            });
          },
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: const Icon(AntDesign.search1),
          ),
        ),
        elevation: 0,
      ),
      body: search.text.isNotEmpty
          ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: FutureBuilder<List<JobsResponse>>(
                future: JobsHelper.searchJobs(search.text),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text("Error ${snapshot.error}");
                  } else if (snapshot.data!.isEmpty) {
                    return const SearchLoading(text: "Job Not Found");
                  }
                   else {
                    final jobs = snapshot.data;
                    return ListView.builder(
                      itemCount: jobs!.length,
                      itemBuilder: (context, index) {
                        final job = jobs[index];
                        return VerticalTileWidget(job: job,);
                      });
                  }
                }),
          )
          : const SearchLoading(text: "Start Searching for Job")
    );
  }
}

class SearchLoading extends StatelessWidget {


  const SearchLoading({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: EdgeInsets.all(20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/optimized_search.png"),
                  ReusableText(
                      text: text,
                      style: appstyle(24, Color(kDark.value), FontWeight.bold)),
                ],
              ),
            );
  }
}
