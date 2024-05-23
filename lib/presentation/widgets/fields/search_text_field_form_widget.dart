import 'package:flutter/material.dart';
import 'package:my_car_expenses/presentation/themes/theme_provider.dart';

class _StringHolder {
  late String value;
}

class SearchTextFieldForm extends StatefulWidget {
  SearchTextFieldForm({
    super.key,
    required this.titleText,
    required this.searchItems,
    this.validator,
    this.keyboardType,
    this.labelText,
    this.hintText,
    this.suffixText,
    this.text,
    this.onChanged,
    this.readOnly
  });

  final String titleText;
  final List<String> searchItems;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final String? labelText;
  final String? hintText;
  final String? suffixText;
  final String? text;
  final void Function(String?)? onChanged;
  final bool? readOnly;

  final _intHolder = _StringHolder();
  String get value => _intHolder.value;

  @override
  State<StatefulWidget> createState() => SearchTextFieldFormState();
}

class SearchTextFieldFormState extends State<SearchTextFieldForm> {
  final focusNode = FocusNode();
  final layerLink = LayerLink();

  late List<String> currentSearchItems;
  late TextEditingController controller;
  late String selected;

  OverlayEntry? entry;
  bool? readOnly;

  @override
  void initState() {
    super.initState();

    currentSearchItems = widget.searchItems;
    controller = TextEditingController();
    selected = 's';

    readOnly = widget.readOnly;

    controller.addListener(() {
      if (widget.onChanged != null) {
        widget.onChanged!(controller.text);
      }
      widget._intHolder.value = controller.text;
      setState(() {
        selected = controller.text;
      });
    });
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        showOverlay();
      } else {
        hideOverlay();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  void showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    entry = OverlayEntry(
        builder: (context) =>
            Positioned(
                width: size.width,
                child: CompositedTransformFollower(
                    link: layerLink,
                    showWhenUnlinked: false,
                    offset: Offset(0, size.height + 8),
                    child: buildOverlay()
                )
            )
    );

    overlay.insert(entry!);
  }

  void hideOverlay() {
    entry?.remove();
    entry = null;
  }

  Widget buildOverlay() =>
      Material(
          elevation: 8,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: ThemeProvider.of().accentColor,
                width: ThemeProvider.of().borderWidth
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
              height: currentSearchItems.length <= 6 ? (40.0 + 32.0 * currentSearchItems.length + (currentSearchItems.length - 1) * 8) : (40.0 + 32.0 * 6 + 5 * 8),
              child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: currentSearchItems.length,
                  separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8),
                  itemBuilder: (BuildContext context, int index) {
                    final item = currentSearchItems[index];
                    return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () =>
                        {
                          controller.text = item,
                          hideOverlay(),
                          focusNode.unfocus(),
                        },
                        child: buildSearchItem(context, item)
                    );
                  }
              )
          )
      );

  Widget buildSearchItem(BuildContext context, String title) {
    debugPrint("$selected - $title");
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                title,
                style: TextStyle(
                  color: ThemeProvider.of().primaryT10Color,
                  fontFamily: ThemeProvider.of().fontFamily,
                  fontSize: 18,
                )
            ),
            selected.toLowerCase() == title.toLowerCase()
                ? Icon(Icons.check_circle_outline, color: ThemeProvider.of().accentColor)
                : Container()
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          height: ThemeProvider.of().borderWidth,
          decoration: BoxDecoration(
            color: ThemeProvider.of().primaryT80Color,
            borderRadius: BorderRadius.all(Radius.circular(ThemeProvider.of().borderRadius)),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) =>
      CompositedTransformTarget(
          link: layerLink,
          child: Column(
              children: [
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 4, bottom: 8),
                    child: Text(
                      widget.titleText,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: ThemeProvider.of().primaryT10Color,
                          fontFamily: ThemeProvider.of().fontFamily,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),
                    )
                ),
                TextFormField(
                  focusNode: focusNode,
                  controller: controller,
                  readOnly: readOnly ?? false,
                  style: TextStyle(
                      color: ThemeProvider.of().primaryT10Color,
                      fontFamily: ThemeProvider.of().fontFamily,
                      fontSize: 18
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ThemeProvider.of().accentColor,
                            width: ThemeProvider.of().borderWidth
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ThemeProvider.of().borderRadius)
                        )
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ThemeProvider.of().primaryT10Color,
                          width: ThemeProvider.of().borderWidth
                      ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(ThemeProvider.of().borderRadius)
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ThemeProvider.of().errorColor,
                          width: ThemeProvider.of().borderWidth
                      ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(ThemeProvider.of().borderRadius)
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ThemeProvider.of().errorColor,
                          width: ThemeProvider.of().borderWidth
                      ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(ThemeProvider.of().borderRadius)
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    /*suffixIcon: IconButton(
                padding: const EdgeInsets.only(right: 10),
                icon: const Icon(Icons.error, size: 30),
                color: ThemeProvider.of().errorColor,
                onPressed: () {
                  print('Search');
                },
              ),*/
                    labelText: widget.labelText,
                    hintText: widget.hintText,
                    suffixText: widget.suffixText,
                    errorStyle: _getErrorTextStyle(),
                    labelStyle: _getHelpTextStyle(),
                    hintStyle: _getHelpTextStyle(),
                    suffixStyle: _getHelpTextStyle(),
                  ),
                  keyboardType: widget.keyboardType,
                  validator: (value) {
                    var isExist = widget.searchItems.any((element) {
                      if (value != null) {
                        return element.toLowerCase() == value.toLowerCase();
                      }
                      return false;
                    });
                    if (!isExist) return "Выбирите значение из выпадающего списка";
                    return widget.validator != null ? widget.validator!(value) : null;
                  },
                  onChanged: (value) {
                    setState(() {
                      currentSearchItems = widget.searchItems.where((element) =>
                          element.toLowerCase().contains(value.toLowerCase())
                      ).toList();
                    });
                    hideOverlay();
                    showOverlay();
                  },
                )
              ]
          )
      );

  TextStyle _getHelpTextStyle() =>
      TextStyle(
          color: ThemeProvider.of().primaryT50Color,
          fontFamily: ThemeProvider.of().fontFamily,
          fontSize: 18
      );

  TextStyle _getErrorTextStyle() =>
      TextStyle(
          color: ThemeProvider.of().errorColor,
          fontFamily: ThemeProvider.of().fontFamily,
          fontSize: 16
      );
}