import 'package:flutter/material.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchTextWidget extends StatefulWidget {
  final Widget staticWidget;
  final Function(String searchText) onSearch;
  const SearchTextWidget({Key? key, required this.staticWidget, required this.onSearch}) : super(key: key);

  @override
  _SearchTextWidgetState createState() => _SearchTextWidgetState();
}

class _SearchTextWidgetState extends State<SearchTextWidget> {
  TextEditingController _controller = TextEditingController();

  bool _isSearch = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          if (!_isSearch)
            Expanded(
              flex: 9,
              child: widget.staticWidget,
            ),
          if (_isSearch)
            Expanded(
              flex: 9,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(borderSide: BorderSide(color: COLOR_PRIMARY)),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: COLOR_PRIMARY)),
                  hintText: "Search ...".tr(),
                  hintStyle: TextStyle(color: COLOR_PRIMARY),
                  suffixIcon: InkWell(
                    onTap: () {
                      widget.onSearch(_controller.text);
                    },
                    child: Icon(
                      Icons.search,
                      color: COLOR_PRIMARY,
                    ),
                  ),
                ),
              ),
            ),
          if (!_isSearch)
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isSearch = true;
                  });
                },
                child: Icon(
                  Icons.search,
                  color: COLOR_PRIMARY,
                ),
              ),
            ),
          if (_isSearch)
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isSearch = false;
                  });
                },
                child: Icon(
                  Icons.close,
                  color: COLOR_PRIMARY,
                ),
              ),
            ),
        ],
      ),
    );
    /*return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (!_isSearch) widget.staticWidget,
          if (_isSearch)
            Positioned(
              //left: 0,
              right: 10,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () {
                      widget.onSearch(_controller.text);
                    },
                    child: Icon(
                      Icons.search,
                      color: COLOR_PRIMARY,
                    ),
                  ),
                ),
              ),
            ),
          if (!_isSearch)
            Positioned(
              right: 8,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isSearch = true;
                  });
                },
                child: Icon(
                  Icons.search,
                  color: COLOR_PRIMARY,
                ),
              ),
            ),
          if (_isSearch)
            Positioned(
              right: 8,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isSearch = false;
                  });
                },
                child: Icon(
                  Icons.close,
                  color: COLOR_PRIMARY,
                ),
              ),
            ),
        ],
      ),
    );*/
  }
}
