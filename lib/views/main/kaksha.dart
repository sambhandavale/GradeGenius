import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradegenius/api/routes/get/kaksha/list_posts.dart';
import 'package:gradegenius/components/kaksha/post_card.dart';
import 'package:gradegenius/components/shared/kaksha_app_bar.dart';
import 'package:gradegenius/models/kaksha_post.dart';
import 'package:gradegenius/models/users.dart';
import 'package:gradegenius/providers/authProvider.dart';
import 'package:gradegenius/utils/constants.dart';
import 'package:gradegenius/views/main/add_assignment.dart';
import 'package:gradegenius/views/main/assignment.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Kaksha extends StatefulWidget {
  final String kakshaId;
  final int members;
  final String kakshaName;

  const Kaksha({super.key, required this.kakshaId, required this.members, required this.kakshaName});

  @override
  _KakshaState createState() => _KakshaState();
}

class _KakshaState extends State<Kaksha> { 
  bool isAuth = true;
  int selectedIndex = 0;
  List<Post> posts = [];
  bool isLoading = true;
  User? _user;

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _user = authProvider.user;
    fetchKakshaPosts();
  }

  String _formatDate(DateTime date) {
    final months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    final localDate = DateFormat('HH:mm').format(date.toLocal());

    return '${months[date.month]} ${date.day}, $localDate';
  }



  Future<void> fetchKakshaPosts() async {
    try {
      final res = await allKakshaPosts(widget.kakshaId);

      final dataMap = res['data'] as Map<String, dynamic>;
      final postList = dataMap['posts'] as List;

      setState(() {
        posts = postList.map((json) => Post.fromJson(json)).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error fetching posts: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
  return Scaffold(
    extendBodyBehindAppBar: true,
    backgroundColor: Constants.darkThemeBg,
    appBar: KakshaAppBar(
      kakshaName: widget.kakshaName,
      kakshaMembers: "${widget.members} Members",
      avatarImage: AssetImage('assets/images/avatar.png'),
    ),
    body: buildKakshaControls()
  );
  
  }

  Widget buildKakshaControls() {
    return Padding(
      padding: const EdgeInsets.only(top:120,bottom: 0, left: 40,right:40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildSlideOption(0,'Posts', 'assets/icons/kaksha/posts.svg'),
                SizedBox(width: 10),
                // _buildSlideOption(1,'Files', 'assets/icons/kaksha/files.svg'),
                // SizedBox(width: 10),
                _buildSlideOption(2,'Doubts', 'assets/icons/kaksha/files.svg'),
                SizedBox(width: 10),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if(_user?.role == 'teacher'){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddAssignment(kakshaId: widget.kakshaId,)),
                      );
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      children: [
                        Text(
                          _user?.role == 'teacher' ? "Add Assignment" : 'Ask Doubt',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontFamily: 'GoogleSans',
                          ),
                        ),
                        const SizedBox(width: 8),
                        if(_user?.role == 'teacher')
                        SvgPicture.asset(
                          'assets/icons/kaksha/files.svg',
                          width: 28,
                          height: 28,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.auto_awesome, color: Colors.blueAccent, size: 20),
              ),
            ],
          ),

          SizedBox(height: 16),
          if(selectedIndex == 0)
          _buildPosts(widget.kakshaId,widget.members,widget.kakshaName),
          // if(selectedIndex == 1)
          // _buildFiles(),
          if(selectedIndex == 2)
          _buildDoubts()
        ],
      ),
    );
  }
 
  Widget _buildSlideOption(int index, String text, String logo) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color.fromARGB(255, 255, 184, 60) : Colors.grey[800],
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontFamily: 'GoogleSans',
                fontSize: 22,
              ),
            ),
            SizedBox(width: 10),
            SvgPicture.asset(
              logo,
              width: 28,
              height: 28,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPosts(String kakshaId,int members,String name) {
    return Expanded(
      child: posts.isEmpty
          ? Center(
              child: Text(
                'No posts yet.',
                style: TextStyle(color: Colors.white),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: posts.map((post) {
                  return Column(
                    children: [
                      PostCard(
                        name: post.createdBy.username,
                        dateTime: _formatDate(post.createdAt),
                        buttonText: 'View',
                        profilePic: '',
                        title: post.title,
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AboutAssignment(kakshaId: kakshaId,members: members,kakshaName: name,assignmentId: post.typeId!,),
                            ),
                          );
                        },
                        type:post.type,
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                }).toList(),
              ),
            ),
    );
  }

  // Widget _buildFiles() {
  //   return Expanded(
  //     child: SingleChildScrollView(
  //       child: Column(
  //         children: fileList.map((file) {
  //           return _buildFileCard(
  //             filename: file['filename']!,
  //             datetime: file['datetime']!,
  //           );
  //         }).toList(),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildFileCard({required String filename, required String datetime}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                filename,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                datetime,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Colors.white10,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.download,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
 
  Widget _buildDoubts(){
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // PostCard(
            //   name: 'Maitri',
            //   dateTime: 'Mar 25, 15:31',
            //   buttonText: 'Solve',
            //   profilePic: '',
            //   title: 'Why is the worst-case time complexity of Quicksort O(n²) but its average-case O(n log n)?`',
            //   onPressed: () {},
            // ),
            // const SizedBox(height: 16),
          ],
        ),
      ),
    ); 
  }
}


