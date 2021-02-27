import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import 'package:russian_words/russian_words.dart';

final colorsRandomizer = RandomColor();
final texts = generateWordPairs().take(100).toList();

List<Widget> generateRandomList({int count = 10}) {
  final result = <Widget>[];
  final wordPairs = generateWordPairs().take(count).toList();
  for(int i = 0; i < count; i++) {
    final color = colorsRandomizer.randomColor();
    result.add(
      Container(
        padding: EdgeInsets.all(8),
        color: color,
        child: Center(
          child: Text(
            wordPairs[i].asPascalCase,
            style: TextStyle(
              fontSize: 18,
              color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white
            ),
          ),
        ),
      ),
    );
  }
  return result;
} 

class SliversPage extends StatefulWidget {
  @override
  _SliversPageState createState() => _SliversPageState();
}

class _SliversPageState extends State<SliversPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Планета земля'),
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network('https://upload.wikimedia.org/wikipedia/commons/0/0d/Africa_and_Europe_from_a_Million_Miles_Away.png'),
            ),
            backgroundColor: Colors.black,
            // pinned: true - оставляет AppBar, а не скрывает его
            pinned: true,
            // floating: true - как только появляется AppBar при обратном
            // скролле, то пока AppBar полностью не появится List не будет
            // cкролится
            floating: false,
            // snap: true - при обратном скролле AppBar будет всегда открываться
            // полностью
            snap: false,
            // stretch: true - при протягивании вниз создается анимация увеличе
            // ния AppBar'а
            stretch: false,
          ),
          // SilverPersistenHeader - это абстрактный класс, поэтому необходимо 
          // имплеминтировать его в классе Header Delegate
          SliverPersistentHeader(
            delegate: HeaderDelegate(
              title: 'Header 1', 
              color: Colors.brown
            ),
            pinned: false,
            floating: false,
          ),
          SliverPersistentHeader(
            delegate: HeaderDelegate(
              title: 'Header 2', 
              color: Colors.brown[800],
              maxExtentValue: 100
            ),
            pinned: false,
          ),
          // List, который расширяется на всю оставшиюся область
          SliverFixedExtentList(
            itemExtent: 50,
            delegate: SliverChildListDelegate(
              generateRandomList(count: 20),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: 30,
              height: 60,
              color: Colors.black,
              child: Center(
                child: Text(
                  'SliverToBoxAdapter',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
            ),
          ),
          // SilverFillRemaining занимает всю доступную область ViewPort'a
          SliverFillRemaining(
             child: Container(
              width: 30,
              height: 60,
              color: Colors.white,
              child: Center(
                child: Text(
                  'SliverFillRemaining',
                  style: TextStyle(
                    color: Colors.black
                  ),
                ),
              ),
            ),
          ),
          SliverGrid(
            // Лучше использовать SliverChildBuilderDelegate, он будет отрисовы
            // вать не все ячейки сразу, сколько у нас отображается на ViewPort,
            // столько он и будет отрисовывать (будут строятся на лету)
            delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
            final color = colorsRandomizer.randomColor();
            return Container(
                padding: EdgeInsets.all(8),
                color: color,
                child: Center(
                  child: Text(
                    texts[index].asPascalCase,
                    style: TextStyle(
                      fontSize: 18,
                      color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white
                    ),
                  ),
                ),
              );
            },
            childCount: 100,
            ),
            // Можно использовать и заготовку сделанную раннее, но лучше исполь
            // зовать SliverChildBuilderDelegate
            // SliverChildListDelegate(
            //   generateRandomList(count: 20)
            // ),
            //
            // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //   // количество ячеек на строку
            //   crossAxisCount: 3,
            //   // высота между ячейками
            //   mainAxisSpacing: 8,
            //   // ширина между ячейками
            //   crossAxisSpacing: 8
            // ),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              // максимальный размер нашей ячейки (item'а), исходя из этого раз
              // мера он сам высчитает необходимое количество столбцов
              maxCrossAxisExtent: 200,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  final Color color;
  final String title;
  final double minExtentValue;
  final double maxExtentValue;

  HeaderDelegate({
    this.color = Colors.black, 
    this.title = '', 
    this.minExtentValue = 50,
    this.maxExtentValue = 150 
  });

  // Наш build method
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white
          ),
        ),
      ),
    );
  }
  // maxExtent - максимальный размер до которого он может развернуться
  @override
  double get maxExtent => maxExtentValue;

  // minExtent - минимальный размер до которого он может развернуться
  @override
  double get minExtent => minExtentValue;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}