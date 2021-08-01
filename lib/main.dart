import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '波妞播放器',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: '波妞播放器'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

const List audioList = [
  '一闪一闪亮晶晶.mp3',
  '多吉多利每一天.mp3',
  '字母歌.m4a',
  '小兔子乖乖.mp3',
  '小白兔乖乖.mp3',
  '小毛驴.m4a',
  '捉泥鳅.m4a',
  '甩葱歌.mp3',
  '霸王龙.mp3',
  '田鼠小弟_这是谁的蛋.m4a',
  '田鼠小弟和地底下的新邻居.m4a',
  '田鼠小弟和大山的礼物.m4a',
  '田鼠小弟和天空的种子.m4a',
  '田鼠小弟和风呼呼.m4a',
  '田鼠小弟种了好多好多花.m4a',
  '01我想去看海.mp3',
  '02我想有颗星星.mp3',
  '03我想有个弟弟.mp3',
  '04我去找回太阳.mp3',
  '05我爱小黑猫.mp3',
  '06我能打败怪兽.mp3',
  '07我要找到朗朗.mp3',
  '08我不要被吃掉.mp3',
  '09我好喜欢她.mp3',
  '10我要救出贝里奥.mp3',
];

class _MyHomePageState extends State<MyHomePage> {
  final ap = AudioPlayer();
  late AudioCache ac;

  late String _current;

  bool _showPlay = true;

  @override
  void initState() {
    ac = AudioCache(fixedPlayer: ap, prefix: 'assets/audio/');
    _current = audioList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: audioList.length,
        itemBuilder: (ctx, index) {
          return buildItem(audioList[index]);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 64,
          color: Colors.orange.shade50,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Text(
                '${_current.split('.')[0]}',
                style: TextStyle(fontSize: 18),
              )),
              _showPlay
                  ? InkWell(
                      onTap: () {
                        ap.resume().catchError((e) {
                          ac.loop(audioList[0]);
                        });
                        setState(() {
                          _showPlay = false;
                        });
                      },
                      child: Icon(
                        Icons.play_circle_fill,
                        size: 48,
                      ))
                  : InkWell(
                      onTap: () {
                        ap.pause();
                        setState(() {
                          _showPlay = true;
                        });
                      },
                      child: Icon(
                        Icons.pause_circle_filled,
                        size: 48,
                      )),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem(String item) {
    return InkWell(
      onTap: () {
        ac.loop(item);
        setState(() {
          _showPlay = false;
          _current = item;
        });
      },
      child: Container(
        height: 52,
        width: double.infinity,
        color: _current == item ? Colors.orange.shade200 : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerLeft,
        child: Text(
          '${item.split('.')[0]}',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
