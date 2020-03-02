import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';

class AddEditScreen extends StatefulWidget {
  static const String routName = '/AddEditScreen';

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _product =
      Product(id: "", price: 0.0, title: '', description: '', imageUrl: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () {
              saveData();
            },
          )
        ],
      ),
      body: Form(
        key: _form,
        child: ListView(
          padding: EdgeInsets.all(15),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              validator: (value) {
                if (value.isEmpty) return 'Please provide a value';
                return null;
              },
              onSaved: (newValue) {
                _product = Product(
                    title: newValue,
                    id: null,
                    description: _product.description,
                    price: _product.price,
                    imageUrl: _product.imageUrl);
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Price'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
              validator: (value) {
                if (value.isEmpty) return 'Please provide a value';
                return null;
              },
              onSaved: (newValue) {
                _product = Product(
                    title: _product.title,
                    id: null,
                    description: _product.description,
                    price: double.parse(newValue),
                    imageUrl: _product.imageUrl);
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              focusNode: _descriptionFocusNode,
              validator: (value) {
                if (value.isEmpty) return 'Please provide a value';
                return null;
              },
              onSaved: (newValue) {
                _product = Product(
                    title: _product.title,
                    id: null,
                    description: newValue,
                    price: _product.price,
                    imageUrl: _product.imageUrl);
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10, right: 10),
                  height: 100,
                  width: 100,
                  child: _imageUrlController.text.isEmpty
                      ? Text(
                          'Enter Image URL',
                          style: TextStyle(fontSize: 12),
                        )
                      : FittedBox(
                          child: Image.network(
                          _imageUrlController.text,
                          fit: BoxFit.cover,
                        )),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(width: 1, color: Colors.grey)),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Image URL'),
                    keyboardType: TextInputType.url,
                    controller: _imageUrlController,
                    onEditingComplete: () {
                      setState(() {});
                    },
                    validator: (value) {
                      if (value.isEmpty) return 'Please provide a value';
                      return null;
                    },
                    onSaved: (newValue) {
                      _product = Product(
                          title: _product.title,
                          id: null,
                          description: _product.description,
                          price: _product.price,
                          imageUrl: newValue);
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void saveData() {
    if (_form.currentState.validate()) _form.currentState.save();
  }
}
