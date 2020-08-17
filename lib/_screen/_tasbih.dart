import 'package:flutter/material.dart';
import 'package:Islam786/_model/Tasbih.dart';
import 'package:Islam786/_screen/_tasbihCounter.dart';
import 'package:Islam786/_utils/_tasbihDatabase.dart';
import 'package:Islam786/_utils/_tasbihHelper.dart';

class Tasbih extends StatefulWidget {
  @override
  _TasbihState createState() => _TasbihState();
}

class _TasbihState extends State<Tasbih> {

  List<TasbihData> _future;
  TextEditingController _tName = TextEditingController();
  TextEditingController _tCount = TextEditingController();

  @override
  void initState() {
    fetchTasbih();
  }

  fetchTasbih() async {
    var d_future = await ActionServiceTasbih.getAllTasbih();
    setState(() {
      _future = d_future;
    });
    _tName.clear();
    _tCount.clear();
  }

  addTasbih(name,count) async {
    await ActionServiceTasbih.AddTasbih(name, count);
    fetchTasbih();
  }

  _editTasbih(id) async {
    var edit = await ActionServiceTasbih.getTasbih(id);
    setState(() {
      _tName.text = edit.name;
      _tCount.text = edit.count.toString();
    });
    addTasbihAlertForm(context,true,id);
  }

  _updateTasbih(id,name,count) async {
    await ActionServiceTasbih.updateTasbih(id,name, count);
    fetchTasbih();
  }

  _removeTasbih(id) async {
    Navigator.pop(context);
    await ActionServiceTasbih.deleteTasbih(id);
    fetchTasbih();
  }

  //-- Confirm dialogue
  showConfirmDialog(BuildContext context,id) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel", style: TextStyle(color: Theme.of(context).primaryColor)),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Delete", style: TextStyle(color: Theme.of(context).primaryColor),),
      onPressed:  () {
        _removeTasbih(id);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text("Would you like to continue delete tasbih record?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Digital Tasbih"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.create),
        backgroundColor: Theme.of(context).primaryColor,
        tooltip: "Add New Tasbih",
        onPressed: () => addTasbihAlertForm(context),
      ),
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Image.asset('assets/icons/tasbih.jpg',fit: BoxFit.fill,height: MediaQuery.of(context).size.height,),
          Container(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(),
          ),
          Container(
            child: (_future == null) ? CircularProgressIndicator()
            : (_future.length == 0) ? Center(
              child: Text(
                "No Tasbih Added!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold
                ),
              ),
            ) : ListView.builder(
              itemCount: _future.length,
              itemBuilder: (context,i){
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TasbihCounter(id: _future[i].id,),
                        )
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Theme.of(context).primaryColor,width: 1),
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(child: Text(_future[i].name,overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18.0),)),
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.edit,color: Theme.of(context).primaryColor),
                              color: Colors.transparent,
                              onPressed: () => _editTasbih(_future[i].id),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete_outline,color: Theme.of(context).primaryColor,),
                              color: Colors.transparent,
                              onPressed: () => showConfirmDialog(context,_future[i].id),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          ),
        ]
      ),
    );
  }

  addTasbihAlertForm(BuildContext context,[edit = false,id = 0]){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: (edit) ? Text("Edit Tasbih") : Text("Add Tasbih"),
          content: Container(
            height: 140.0,
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _tName,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "E.g. Kalima tayyiba",
                    labelText: "Content"
                  )
                ),
                SizedBox(height: 15.0,),
                TextField(
                  controller: _tCount,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "E.g. 33",
                      labelText: "Count"
                  )
                ),
              ],
            ),
          ),
          actions: <Widget>[
            (!edit)
                ?
            MaterialButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                if(_tName.value.text.isNotEmpty && _tCount.value.text.isNotEmpty) {
                  addTasbih(_tName.value.text, _tCount.value.text);
                  Navigator.of(context).pop();
                }
              },
              child: Text("Add"),
            )
              :
            MaterialButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                if(_tName.value.text.isNotEmpty && _tCount.value.text.isNotEmpty) {
                  _updateTasbih(id,_tName.value.text, _tCount.value.text);
                  Navigator.of(context).pop();
                }
              },
              child: Text("Edit"),
            )
          ],
        );
      }
    );
  }

}
