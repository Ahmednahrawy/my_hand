import 'package:flutter/material.dart';
import 'package:my_hand/config/theme/colors.dart';
import 'package:my_hand/features/orderscreen/ui/widgets/customer_list_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerNameAutoComplete extends StatefulWidget {
  final Function(String?) onCustomerSelected;
  const CustomerNameAutoComplete({super.key, required this.onCustomerSelected});
  @override
  _CustomerNameAutoCompleteState createState() =>
      _CustomerNameAutoCompleteState();
}

class _CustomerNameAutoCompleteState extends State<CustomerNameAutoComplete> {
  List<String> _customers = CustomerNameConstants.customerNames;
  final TextEditingController _controller = TextEditingController();
  late SharedPreferences _prefs;
  String? _selectedCustomerName;

  @override
  void initState() {
    super.initState();
    _loadSuggestions();
  }

  // Load suggestions from SharedPreferences
  Future<void> _loadSuggestions() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      setState(() {
        _customers = _prefs.getStringList('suggestions') ?? _customers;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading suggestions: $e ###'),
        ),
      );
    }
    print('load done #########################');
  }

  // Save suggestions to SharedPreferences
  Future<void> _saveSuggestions() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      await _prefs.setStringList('suggestions', _customers);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving suggestions: $e'),
        ),
      );
    }
    print('save done ##############################');
  }

  // Add new suggestion if it doesn't exist
  void _addSuggestion(String suggestion) {
    try {
      if (!_customers.contains(suggestion)) {
        setState(() {
          _customers.add(suggestion);
          _saveSuggestions();
        });
      }
      print('add done ###################################################');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding suggestions: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        // Return the list of customers that match the typed value
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        }
        return _customers.where((String customer) {
          return customer
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        _selectedCustomerName = selection;
        _controller.text = selection;
        widget.onCustomerSelected(_selectedCustomerName);
        _saveSuggestions();
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        focusNode.addListener(() {
          if (!focusNode.hasFocus) {
            // Field loses focus, submit the value
            if (controller.text.isNotEmpty &&
                !_customers.contains(controller.text)) {
              _addSuggestion(controller.text);
            }
            setState(() {
              _selectedCustomerName = controller.text;
              widget.onCustomerSelected(_selectedCustomerName);
            });
          }
        });
        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: TextInputType.name,
          onFieldSubmitted: (String value) {
            try {
              if (value.isNotEmpty && !_customers.contains(value)) {
                _addSuggestion(value);
              }
              setState(() {
                _selectedCustomerName = value;
                widget.onCustomerSelected(_selectedCustomerName);
              });
              print('Field submitted #############################');
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error submitting suggestions: $e'),
                ),
              );
            }
          },
          onChanged: (String value) {
            setState(() {
              // Update the selected customer name whenever the text changes
              _selectedCustomerName = value;
            });
          },
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: ColorsManager.mainBlue,
                  width: 1.3,
                ),
                borderRadius: BorderRadius.circular(15)),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: ColorsManager.lightBlue, width: 1.3),
              borderRadius: BorderRadius.circular(15),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 166, 19, 5),
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            labelText: 'إسم العميل',
            suffixIcon: IconButton(
              onPressed: () {
                controller
                    .clear(); // Clear the input when the clear icon is pressed
                setState(() {
                  _selectedCustomerName = '';
                  widget
                      .onCustomerSelected(null); // Reset the customer selection
                });
              },
              icon: _selectedCustomerName == ''
                  ? SizedBox.shrink()
                  : Icon(Icons.clear),
            ),
            fillColor: ColorsManager.moreLightGray,
          ),
          obscureText: false,
          validator: (value) {
            if (value == null || value.isEmpty || value.length < 4) {
              return 'اكتب على الأقل 4 حروف';
            }
            return null;
          },
        );
      },
      optionsViewBuilder: (context, Function(String) onSelected, customers) {
        return Material(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              final option = customers.elementAt(index);
              return Dismissible(
                key: Key(option),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: ColorsManager.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  // Handle what happens when an item is dismissed
                  setState(() {
                    _customers.remove(option); // Remove the item from the list
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$option has been dismissed')),
                  );
                },
                child: ListTile(
                  title: Text(option),
                  onTap: () {
                    onSelected(option);
                  },
                ),
              );
            },
            itemCount: customers.length,
          ),
        );
      },
    );
  }
}
