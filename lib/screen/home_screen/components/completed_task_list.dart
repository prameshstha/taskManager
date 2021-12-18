import 'package:flutter/material.dart';
import 'package:to_do_app/components/all_methods_functions.dart';
import 'package:to_do_app/models/database_helper.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/screen/home_screen/components/background.dart';
import 'package:to_do_app/screen/home_screen/components/slidable_action_for_list.dart';

class CompletedTask extends StatelessWidget {
  const CompletedTask({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseHelper _databaseHelper = DatabaseHelper();
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: _databaseHelper.getCompletedTasks(),
              builder: (context, AsyncSnapshot<List<Tasks>> snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    child: Text('...Loading'),
                  );
                }
                return snapshot.data!.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 300,
                          child: Text('No Tasks in the list'),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final item = snapshot.data![index];
                          final String indexOfPage = 'completed';
                          return Dismissible(
                            confirmDismiss: (direction) => askUser(
                              direction,
                              context,
                              snapshot.data![index].id,
                              _databaseHelper,
                              snapshot.data![index].done,
                              snapshot.data![index].taskName,
                              snapshot,
                              index,
                              indexOfPage,
                            ),
                            key: Key(item.id.toString()),

                            // Show a red background as the item is swiped away.
                            //background for done / undone
                            background: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        snapshot.data![index].done == 'yes'
                                            ? Icons.undo
                                            : Icons.done,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        snapshot.data![index].done == 'yes'
                                            ? 'Undo'
                                            : 'Done',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      color: snapshot.data![index].done == 'yes'
                                          ? Colors.purple.shade900
                                          : Colors.green.shade300,
                                      borderRadius:
                                          BorderRadius.circular(15.0))),
                            ),
                            //background for delete
                            secondaryBackground: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius:
                                          BorderRadius.circular(15.0))),
                            ),
                            child: ListViewWidgetForTasks(
                              id: snapshot.data![index].id!.toInt(),
                              taskName: snapshot.data![index].taskName,
                              dueDate: snapshot.data![index].dueDate,
                              time: snapshot.data![index].time,
                              priority: snapshot.data![index].priority,
                              alarm: snapshot.data![index].alarm,
                              done: snapshot.data![index].done,
                              selectedIndex: 1,
                            ),
                          );
                        });
              },
            ),
          ],
        ),
      ),
    );
  }
}
