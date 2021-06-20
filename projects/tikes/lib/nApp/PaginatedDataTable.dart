import 'package:flutter/material.dart';
import 'package:tikes/web/hello_web.dart';

class dataSource extends DataTableSource {
  List<Span> spans = [];
  List<DataRow> rows;

  dataSource({this.spans}) {
    this.rows = this
        .spans
        .map((m) => DataRow(
              cells: <DataCell>[
                DataCell(Text(m.time)),
                DataCell(Text(m.status)),
                DataCell(Text(m.action)),
                DataCell(Text(m.user)),
                DataCell(Text(m.duration.toString())),
                DataCell(IconButton(
                  icon: Icon(Icons.timeline),
                  onPressed: () {},
                )),
              ],
            ))
        .toList();
  }

  @override
  DataRow getRow(int index) {
    print("SSSSSS${index}");
    if (index < this.rows.length) {
      return this.rows[index];
    }
    return null;
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount {
    print("AAAAAAA2");
    return this.spans.length;
  }

  @override
  int get selectedRowCount => 0;
}

class NAppPaginatedDataTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Startup Name Generator',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Row(
              children: <Widget>[
                FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.home, color: Colors.white),
                    label: Text(
                      '主页',
                      style: TextStyle(color: Colors.white),
                    )),
                FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.timeline, color: Colors.white),
                    label: Text(
                      '链路',
                      style: TextStyle(color: Colors.white),
                    )),
                FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.color_lens,
                      color: Colors.white,
                    ),
                    label: Text(
                      '主题',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
          body: Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Scrollbar(
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: FutureBuilder<List<Span>>(
                              future: fetchActions(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<Span>> snapshot) {
                                dataSource source;
                                if (snapshot.hasData) {
                                  source = dataSource(spans: snapshot.data);
                                  return PaginatedDataTable(
                                    header: Text("aaaaa"),
                                    columns: <DataColumn>[
                                      DataColumn(label: Text('时间')),
                                      DataColumn(label: Text('状态')),
                                      DataColumn(label: Text('接口')),
                                      DataColumn(label: Text('用户')),
                                      DataColumn(label: Text('延时')),
                                      DataColumn(label: Text('操作')),
                                    ],
                                    rowsPerPage: 10,
                                    source: source,
                                  );
                                } else {
                                  return Text('加载中...');
                                }
                              })),
                    ),
                  )
                ],
              )),
        ));
  }

  Widget buildCard() {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.album),
              title: Text('The Enchanted Nightingale'),
              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('BUY TICKETS'),
                  onPressed: () {
                    /* ... */
                  },
                ),
                FlatButton(
                  child: const Text('LISTEN'),
                  onPressed: () {
                    /* ... */
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<Span>> fetchActions() async {
  final jOut = await Hello.fetchJson("http://localhost:4040/action");
  print('=====');
  //print(jOut["hits"] as List);
  final hits = jOut["hits"] as List;
  var c = hits.map((m) {
    final span = Span();
    span.status = m["status"] as String;
    span.user = m["user"] as String;
    span.time = m["time"] as String;
    span.action = m["action"] as String;
    span.user = m["user"] as String;
    span.duration = m["duration"] as int;
    return span;
  }).toList();
  return c;
}

class Span {
  String time;
  String status;
  String user;
  String action;
  int duration;
}