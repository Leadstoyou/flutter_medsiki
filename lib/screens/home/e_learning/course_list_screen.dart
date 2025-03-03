import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:untitled/base/base._repository.dart';
import 'package:untitled/screens/home/e_learning/course_detail_screen.dart';
import 'package:untitled/utils/common.dart';
import 'package:untitled/utils/local_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CourseListScreen extends StatefulWidget {
  final int inputNumber;

  CourseListScreen(this.inputNumber, {Key? key}) : super(key: key);

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  late BuildContext _context;
  final List<Map<String, dynamic>> data = [
    {'id': 0, 'name': 'Thường gặp'},
    {'id': 1, 'name': 'Bệnh Nền'},
    {'id': 2, 'name': 'Phân Biệt'},
    {'id': 3, 'name': 'Bệnh Nhi'}
  ];

  List<Map<String, dynamic>> listCourse = [];
  final BaseRepository<Map<String, dynamic>> courseRepository =
      BaseRepository<Map<String, dynamic>>('courses');
  final BaseRepository<Map<String, dynamic>> historiesRepository =
      BaseRepository<Map<String, dynamic>>('histories');
  late var listWachingVideo;
  var _isLoading = true;

  Future<List<Map<String, dynamic>>?> getListCourse() async {
    try {
      var inputNumber = widget.inputNumber;
      if (inputNumber == 100) {
        var userHistory = await historiesRepository.search(
            'user', (await getUserFromLocalStorage())!.id ?? "");
        final courseMap =
            userHistory[0]['courses'] as Map<dynamic, dynamic>? ?? {};
        final courseIds = courseMap.keys.map((k) => k.toString()).toList();
        var data = await fetchCoursesBulk(courseIds);

        setState(() {
          _isLoading = false;
        });
        return data;
      } else {
        var data = await courseRepository.search('type', inputNumber);
        if (data.isNotEmpty) {
          return data;
        } else {
          return [];
        }
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch courses: $e');
    }
  }

  Future<List<Map<String, dynamic>>?> fetchCoursesBulk(List<String> ids) async {
    try {
      final Map<String, dynamic> results = {};
      final ref = courseRepository.getRef();

      final futures = ids.map((id) => ref.child(id).get()).toList();
      final snapshots = await Future.wait(futures);

      for (int i = 0; i < ids.length; i++) {
        if (snapshots[i].exists) {
          final value = snapshots[i].value;

          if (value is Map<Object?, Object?>) {
            results[ids[i]] = Map<String, dynamic>.from(value);
          }
        }
      }

      var data = results.keys
          .map((e) => {'id': e, ...results[e] as Map<String, dynamic>})
          .toList();

      return data;
    } catch (e) {
      print('Error while loading fetchCoursesBulk data: $e');
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _loadCourseData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadCourseData();
  }

  Future<void> _loadCourseData() async {
    try {
      setState(() {
        _isLoading = true;
      });

      var courses = await getListCourse();
      var user = await getUserFromLocalStorage();
      var listWachingVideos =
          await historiesRepository.search('user', user?.id ?? "");

      setState(() {
        if (listWachingVideos.isNotEmpty) {
          listWachingVideo = listWachingVideos[0]['courses'] ?? [];
        } else {
          listWachingVideo = [];
        }

        listCourse = courses ?? [];
        _isLoading = false;
      });
    } catch (e) {
      print('Error while loading course data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    String title;
    if (widget.inputNumber == 100) {
      title = "Tiến Độ";
    } else {
      title = data[widget.inputNumber]['name'];
    }
    if (_isLoading) {
      return Container(
        color: Color(0xFFFFD1D6),
        child: Center(
          child: LoadingAnimationWidget.twoRotatingArc(
              color: Colors.white, size: 200),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFFFD1D6),
      appBar: AppBar(
        backgroundColor: Color(0xFF990011),
        elevation: 0,
        title: Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: 'Manrope'),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          for (var course in listCourse)
            _buildIssueCard(course, 100, 'Hoàn thành')
        ],
      ),
    );
  }

  Widget _buildIssueCard(
      Map<String, dynamic> course, int progress, String status) {
    return InkWell(
      onTap: () {
        navigate(_context, CourseDetailScreen(course),
            callback: () async {
          setState(() {
            _loadCourseData();
          });
        });
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Color(0xFF990011)),
        ),
        margin: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.memory(
                  base64ToBytes(course['thumbnail']),
                  width: 135,
                  height: 135,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 180),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(course['title'],
                      style: TextStyle(
                          fontFamily: 'Manrope Medium',
                          fontSize: 16,
                          color: Color(0xFF364356))),
                  SizedBox(
                    height: 8,
                  ),
                  _getStarRate(course['star']),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      course['description'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: 'Manrope Medium', fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  if (listWachingVideo.length != 0)
                    _getProgressBar(handleRenderProgressBar(
                        listWachingVideo[course['id']], course)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  int handleRenderProgressBar(List? data, Map? data2) {
    int tuSo =
        data != null ? data.where((element) => element == true).length : 0;
    int mauSo = data2?['videos'] is List || data2?['videos'] is Map
        ? data2!['videos'].length
        : 0;
    return mauSo > 0 ? ((tuSo / mauSo) * 100).toInt() : 0;
  }

  Widget _getStarRate(int star) {
    int filledStars = star.clamp(0, 5);
    String type_txt = "Cơ bản";
    List<Widget> starWidgets = [];
    if (filledStars == 3) {
      type_txt = "Trung bình";
    }
    if (filledStars > 3) {
      type_txt = "Nâng Cao";
    }
    for (int i = 0; i < filledStars; i++) {
      starWidgets.add(Icon(
        Icons.star,
        color: Colors.yellow,
        size: 14,
      ));
    }

    for (int i = filledStars; i < 5; i++) {
      starWidgets.add(Icon(Icons.star_border, color: Colors.yellow, size: 14));
    }

    return Row(children: [
      ...starWidgets,
      Text(
        type_txt,
        style:
            TextStyle(color: Color(0xFF636D77), fontFamily: 'Manrope Regular'),
      )
    ]);
  }

  _getProgressBar(int progress) {
    Color progress_color = Color(0xFFE0E0E0);
    if (0 < progress && progress < 31) {
      progress_color = Color(0xFF0043CE);
    } else if (31 < progress && progress < 51) {
      progress_color = Color(0xFFF1C21B);
    } else if (51 < progress) {
      progress_color = Color(0xFF198038);
    }

    String progress_txt = "Chưa học";
    if (progress != 0) {
      progress_txt = "Tiến độ";
    }
    if (progress == 100) {
      progress_txt = "Hoàn thành";
    }
    return (Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Row(
          spacing: 10,
          children: [
            Text(
              '$progress%',
              style: TextStyle(fontFamily: 'Manrope SemiBold', fontSize: 14),
            ),
            Text(
              progress_txt,
              style: TextStyle(
                  fontFamily: 'Manrope Regular',
                  fontSize: 15,
                  color: Color(0xFF6F6F6F)),
            ),
          ],
        ),
        SizedBox(
            width: 160,
            child: LinearProgressIndicator(
              value: progress / 100,
              color: progress_color,
            )),
      ],
    ));
  }
}
