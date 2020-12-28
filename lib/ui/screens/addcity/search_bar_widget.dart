import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweaterweather/utils/debouncer.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String) callback;

  SearchBarWidget(this.callback);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  Debouncer _debouncer = Debouncer(milliseconds: 500);

  final _controller = TextEditingController();

  @override
  void dispose() {
    _debouncer.dispose();
    _debouncer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      final text = _controller.text;
      _debouncer.run(() => widget.callback(text));
    });
    return TextField(
      controller: _controller,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      autofocus: true,
      maxLines: 1,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        prefixIcon: Icon(
          Icons.search,
          color: const Color(0xFF7F808C),
        ),
        suffixIcon: ValueListenableBuilder(
          valueListenable: _controller,
          builder: (context, value, child) => Visibility(
            visible: (value as TextEditingValue).text.length > 0,
            child: IconButton(
                icon: Icon(
                  Icons.clear,
                  color: const Color(0xFF7F808C),
                ),
                onPressed: () {
                  _controller.clear();
                }),
          ),
        ),
        hintText: 'Search for location',
        hintStyle: GoogleFonts.inter(
            textStyle: TextStyle(
                color: const Color(0xFF7F808C),
                fontSize: 14,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal)),
        filled: true,
        fillColor: const Color(0xFFF5F6F7),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: const Color(0xFFF5F6F7)),
          borderRadius: BorderRadius.circular(9.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: const Color(0xFFF5F6F7)),
          borderRadius: BorderRadius.circular(9.0),
        ),
      ),
      style: GoogleFonts.inter(
          textStyle: TextStyle(
              color: const Color(0xFF3D3F4E),
              fontSize: 14,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.normal)),
    );
  }
}
