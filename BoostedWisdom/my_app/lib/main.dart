import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BoostWis',
      theme: ThemeData(
        primarySwatch: Colors.blue, // You can customize the color theme here
      ),
      initialRoute: '/', // The initial route for your app
      routes: {
        '/': (context) => MyHomePage(), // Define your main page
        '/about': (context) => AboutPage(), // Define the AboutPage
      },
      //home: MyHomePage(),
    );
  }
}

//
//
//
//
//
//
//
//
//
//
// ---------------------------------------------------------------------------------- SIGN IN FORM
class SignInDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return AlertDialog(
      title: const Text('Sign In'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true, // For password input
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final email = emailController.text;
              final password = passwordController.text;

              // Check email and password and redirect accordingly
              if (email.contains('educator')) {
                Navigator.pop(context); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EducatorLandingPage()),
                );
              } else if (email.contains('student')) {
                Navigator.pop(context); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => StudentLandingPage()),
                );
              } else {
                // Handle invalid credentials or show an error message
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Error'),
                      content: const Text(
                          'Invalid email or password. Please try again.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the error dialog
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }
}

//
//
//
//
//
//
//
//
//
//
// ---------------------------------------------------------------------------------- SIGN UP FORM
class SignUpDialog extends StatefulWidget {
  @override
  _SignUpDialogState createState() => _SignUpDialogState();
}

class _SignUpDialogState extends State<SignUpDialog> {
  // Variable to track the selected option
  String _selectedRole = ''; // 'student' or 'educator'

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            // SignUp Form
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your name',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
              ),
            ),
            TextFormField(
              obscureText: true, // Hide password
              decoration: const InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
              ),
            ),
            const SizedBox(height: 16.0),
            // Radio Buttons for Role Selection
            ListTile(
              title: const Text('Student'),
              leading: Radio<String>(
                value: 'student',
                groupValue: _selectedRole,
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value ?? '';
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Educator'),
              leading: Radio<String>(
                value: 'educator',
                groupValue: _selectedRole,
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value ?? '';
                  });
                },
              ),
            ),
            const SizedBox(height: 16.0),
            // Sign Up with Social Media Buttons
            ElevatedButton.icon(
              onPressed: () {
                // Handle sign-up with Facebook logic here
              },
              icon: const Icon(Icons.facebook),
              label: const Text('Sign Up with Facebook'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Handle sign-up with Google logic here
              },
              icon: const Icon(Icons.circle),
              label: const Text('Sign Up with Google'),
            ),
            const SizedBox(height: 16.0),
            // OK Button
            ElevatedButton(
              onPressed: () {
                // Handle sign-up logic here
                // You can access the entered name, email, password,
                // and the selected role (_selectedRole) here.
                // For example, you can validate the form and sign the user up.
                // Then, you can close the dialog.
                Navigator.of(context).pop();
              },
              child: const Text('SignUp'),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------------- STUDENT LANDING PAGE
class StudentLandingPage extends StatelessWidget {
  // Map with pre-booked days
  Map<DateTime, List<dynamic>> events = {
    DateTime(2023, 9, 2): ['Event A'],
    DateTime(2023, 9, 5): ['Event B', 'Event C'],
    DateTime(2023, 9, 19): ['Event D'],
    DateTime(2023, 9, 25): ['Event E'],
    DateTime(2023, 9, 30): ['Event F'],
  };
  // Variables to store updated personal information
  String updatedName = '';
  int updatedAge = 0;
  String updatedDegree = '';

  // Controller for the text fields in the update form
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController degreeController = TextEditingController();

  // Function to show the update personal info dialog
  void _showUpdatePersonalInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Personal Info'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Name Field
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Student Name'),
              ),
              const SizedBox(height: 10),

              // Age Field
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Age'),
              ),
              const SizedBox(height: 10),

              // Degree Field
              TextField(
                controller: degreeController,
                decoration:
                    const InputDecoration(labelText: 'Attending Degree'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                // Get the updated values from the text controllers
                updatedName = nameController.text;
                updatedAge = int.tryParse(ageController.text) ?? 0;
                updatedDegree = degreeController.text;

                // Perform the update operation (you can handle this as needed)

                // Close the dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Landing Page'),
        actions: [
          // Sign Out Button
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
                (route) => false, // Remove all routes from the stack
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Student Landing Page!',
              style: TextStyle(fontSize: 20),
            ),
            // ---------------------------------------------------------------------------------- Student Information Card
            Card(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Image.asset('assets/student_image.jpeg'),
                  const Text('Student Name: John Doe'),
                  const Text('Age: 20'),
                  const Text('Attending Scholar Degree: Computer Science'),
                  const Text('Attending Subjects:'),

                  // ---------------------------------------------------------------------------- List of Subjects and Grades
                  Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center the cards
                    children: [
                      // Subject 1
                      Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Center(
                                child: Text(
                                  'Subject: ${subjects[0]['name']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight
                                          .bold), // Make the subject name bold
                                ),
                              ),
                              subtitle: Center(
                                child: Text(
                                    'Description: ${subjects[0]['description']}'), // Center the description
                              ),
                            ),
                            const Text('Educators:'),
                            for (var educator in subjects[0]['educators'])
                              ListTile(
                                title: Text('Name: ${educator['name']}'),
                                subtitle: Text(
                                  'Age: ${educator['age']} | Degree: ${educator['degree']}',
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Subject 2
                      Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Center(
                                child: Text(
                                  'Subject: ${subjects[1]['name']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight
                                          .bold), // Make the subject name bold
                                ),
                              ),
                              subtitle: Center(
                                child: Text(
                                    'Description: ${subjects[1]['description']}'), // Center the description
                              ),
                            ),
                            const Text('Educators:'),
                            for (var educator in subjects[1]['educators'])
                              ListTile(
                                title: Text('Name: ${educator['name']}'),
                                subtitle: Text(
                                  'Age: ${educator['age']} | Degree: ${educator['degree']}',
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Add more subjects and grades as needed

                  // -------------------------------------------------------------------- Button for updating personal info
                  // Button to Update Personal Info
                  ElevatedButton(
                    onPressed: () {
                      // Show the update personal info dialog
                      _showUpdatePersonalInfoDialog(context);
                    },
                    child: const Text('Update Personal Info'),
                  ),
                ],
              ),
            ),
            // Calendar ------------------------------------------------------------------- [SCHEDULE SUBJECTS CALENDAR]
            Card(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Title
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Schedule Appointments',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TableCalendar(
                    focusedDay: DateTime.now(),
                    firstDay: DateTime(DateTime.now().year - 1),
                    lastDay: DateTime(DateTime.now().year + 1),
                    calendarFormat: CalendarFormat.week,
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekendStyle: TextStyle(color: Colors.red),
                    ),
                    headerStyle: const HeaderStyle(
                      titleTextStyle: TextStyle(fontSize: 18),
                    ),
                    eventLoader: (day) {
                      // Initialize an empty list to store the events for this day
                      final eventsForDay =
                          <String>[]; // Change String to your event type

                      // Loop through your events map
                      events.forEach((eventDay, eventsList) {
                        // Check if the current day is in the events map
                        if (day.year == eventDay.year &&
                            day.month == eventDay.month &&
                            day.day == eventDay.day) {
                          eventsForDay.addAll(
                              eventsList.map((event) => event.toString()));
                        }
                      });

                      return eventsForDay;
                    },
                    calendarStyle: const CalendarStyle(
                      weekendTextStyle: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
            // -------------------------------------------------------------------------------------- Scrollable Subject Menu
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Available Subjects',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5, // Number of columns
                    crossAxisSpacing: 16.0, // Spacing between columns
                    mainAxisSpacing: 16.0, // Spacing between rows
                  ),
                  itemCount: subjects.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _showSubjectDetails(context, subjects[index]);
                      },
                      child: Card(
                        elevation: 2.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(subjects[index]['name']),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Boosted Wisdom © 2023',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              // Social Media Icons (You can add your own links)
              IconButton(
                icon: const Icon(Icons.facebook),
                onPressed: () {
                  // Handle Facebook link here
                },
              ),
              IconButton(
                icon: const Icon(Icons.camera),
                onPressed: () {
                  // Handle Instagram link here
                },
              ),
            ],
          ),
        ),
      ),
      // Library Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle library button click
        },
        child: const Icon(Icons.library_books),
      ),
    );
  }

  // Function to show subject details popup --------------------------------------------- [POP UP]
  void _showSubjectDetails(BuildContext context, Map<String, dynamic> subject) {
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(subject['name']),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Description: ${subject['description']}'),
                  const SizedBox(height: 16),
                  const Text('Educators:'),
                  for (var educator in subject['educators'])
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text('Name: ${educator['name']}'),
                          subtitle: Text(
                            'Age: ${educator['age']} | Degree: ${educator['degree']}',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final datePicked = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101),
                            );

                            if (datePicked != null) {
                              setState(() {
                                selectedDate = datePicked;
                              });

                              final timePicked = await showTimePicker(
                                context: context,
                                initialTime: selectedTime,
                              );

                              if (timePicked != null) {
                                setState(() {
                                  selectedTime = timePicked;
                                });

                                // Handle the selected date and time here
                                print('Selected Date: $selectedDate');
                                print('Selected Time: $selectedTime');

                                // Navigate to the BillingPage
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BillingPage(),
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text('Book a Session'),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

//
//
//
//
//
//
//
//
//
//
// ------------------------------------------------------------------------------------------ BILLING PAGE
class BillingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Billing Page'),
        actions: [
          // Exit Button
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              // Navigate back to StudentLandingPage when Exit is pressed
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Billing Details',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20), // Add some spacing

            // Billing Form
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  // Billing Information (Name, Address, Email, etc.)
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Name'),
                    // Add more billing-related form fields (e.g., Address, Email) here.
                  ),

                  const SizedBox(height: 20),

                  // Payment Information (Credit Card, etc.)
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Credit Card Number'),
                    // Add more payment-related form fields (e.g., Expiration Date, CVV) here.
                  ),

                  const SizedBox(height: 20),

                  // Coupon Code
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Coupon Code'),
                    // ... (Existing coupon code form field)
                  ),

                  const SizedBox(height: 20),

                  // Terms and Conditions
                  const Text(
                    'Terms and Conditions:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // Add generic terms and conditions text here.
                  const Text(
                    'By submitting this form, you agree to our terms and conditions.',
                  ),

                  const SizedBox(height: 20),

                  // Payment Method Selection
                  const Text(
                    'Select an Alternative Payment Method:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle MbWay payment method selection.
                        },
                        child: const Text('MbWay'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Handle Apple Pay payment method selection.
                        },
                        child: const Text('Apple Pay'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Handle PayPal payment method selection.
                        },
                        child: const Text('PayPal'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Submit Button
                  ElevatedButton(
                    onPressed: () {
                      // Show the payment confirmation dialog and navigate back to StudentLandingPage
                      _showPaymentConfirmationDialog(context);
                    },
                    child: const Text('Submit Payment'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Boosted Wisdom © 2023',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              // Social Media Icons (You can add your own links)
              IconButton(
                icon: const Icon(Icons.facebook),
                onPressed: () {
                  // Handle Facebook link here
                },
              ),
              IconButton(
                icon: const Icon(Icons.camera),
                onPressed: () {
                  // Handle Instagram link here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to show the payment confirmation dialog
  void _showPaymentConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment Confirmation'),
          content: const Text(
            "Thanks for learning with us, your receipt is being sent by email.",
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // Close the confirmation dialog
                Navigator.of(context).pop();

                // Navigate back to StudentLandingPage
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

//
//
//
//
//
//
//
//
//
//
// ---------------------------------------------------------------------------------- EDUCATOR LANDING PAGE
class EducatorLandingPage extends StatefulWidget {
  @override
  _EducatorLandingPageState createState() => _EducatorLandingPageState();
}

class _EducatorLandingPageState extends State<EducatorLandingPage> {
  // Map with pre-booked days
  Map<DateTime, List<dynamic>> events = {
    DateTime(2023, 9, 2): ['Event A'],
    DateTime(2023, 9, 5): ['Event B', 'Event C'],
    DateTime(2023, 9, 19): ['Event D'],
    DateTime(2023, 9, 25): ['Event E'],
    DateTime(2023, 9, 30): ['Event F'],
  };
  // Variables to store updated personal information
  String updatedName = '';
  int updatedAge = 0;
  String updatedDegree = '';

  // Controller for the text fields in the update form
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController graduationController = TextEditingController();

  // Function to show the update personal info dialog
  void _showUpdatePersonalInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Personal Info'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Name Field
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Educator Name'),
              ),
              const SizedBox(height: 10),

              // Age Field
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Age'),
              ),
              const SizedBox(height: 10),

              // Degree Field
              TextField(
                controller: degreeController,
                decoration: const InputDecoration(labelText: 'Academic Degree'),
              ),
              const SizedBox(height: 10),

              // Age Field
              TextField(
                controller: graduationController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: 'Year of Graduation'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                // Get the updated values from the text controllers
                updatedName = nameController.text;
                updatedAge = int.tryParse(ageController.text) ?? 0;
                updatedDegree = degreeController.text;

                // Perform the update operation (you can handle this as needed)

                // Close the dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String selectedSubject = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Educator Landing Page'),
        actions: [
          // Sign Out Button
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
                (route) => false, // Remove all routes from the stack
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // --------------------------------------------------------------------------------- Educator Info Card
            Card(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Replace with educator photo
                  Image.asset('assets/educator_image.jpeg'),
                  const Text('Educator Name: John Smith'),
                  const Text('Age: 30'),
                  const Text('Degree: Ph.D. in Computer Science'),
                  const Text('Teaching Subjects:'),

                  // ----------------------------------------------------------- Button to Update Personal Info
                  // Button to Update Personal Info
                  ElevatedButton(
                    onPressed: () {
                      // Show the update personal info dialog
                      _showUpdatePersonalInfoDialog(context);
                    },
                    child: const Text('Update Personal Info'),
                  ),

                  // ----------------------------------------------------------- Display the subjects
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Center(
                                child: Text(
                                  'Subject: Mathematics',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              subtitle: Center(
                                child: Text(
                                    'Description: Study of numbers, quantities and shapes'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ----------------------------------------------------------------- Schedule Appointments
            Card(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Title
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Schedule Appointments',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TableCalendar(
                    focusedDay: DateTime.now(),
                    firstDay: DateTime(DateTime.now().year - 1),
                    lastDay: DateTime(DateTime.now().year + 1),
                    calendarFormat: CalendarFormat.week,
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekendStyle: TextStyle(color: Colors.red),
                    ),
                    headerStyle: const HeaderStyle(
                      titleTextStyle: TextStyle(fontSize: 18),
                    ),
                    eventLoader: (day) {
                      // Initialize an empty list to store the events for this day
                      final eventsForDay =
                          <String>[]; // Change String to your event type

                      // Loop through your events map
                      events.forEach((eventDay, eventsList) {
                        // Check if the current day is in the events map
                        if (day.year == eventDay.year &&
                            day.month == eventDay.month &&
                            day.day == eventDay.day) {
                          eventsForDay.addAll(
                              eventsList.map((event) => event.toString()));
                        }
                      });

                      return eventsForDay;
                    },
                    calendarStyle: const CalendarStyle(
                      weekendTextStyle: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),

            // ----------------------------------------------------------------- Available Subjects
            const Text(
              'Available Subjects to lecture',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, // Number of columns
                crossAxisSpacing: 16.0, // Spacing between columns
                mainAxisSpacing: 16.0, // Spacing between rows
              ),
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _showSubjectDetails(context, subjects[index]['name']);
                  },
                  child: Card(
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(subjects[index]['name']),
                      ),
                    ),
                  ),
                );
              },
            ),

            // Button to Apply for Teaching a New Subject
            ElevatedButton(
              onPressed: () {
                // Show the popup dialog when the button is pressed
                _showApplyForTeachingSubjectDialog(context);
              },
              child: const Text('Apply for Teaching a New Subject'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Boosted Wisdom © 2023',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              // Social Media Icons (You can add your own links)
              IconButton(
                icon: const Icon(Icons.facebook),
                onPressed: () {
                  // Handle Facebook link here
                },
              ),
              IconButton(
                icon: const Icon(Icons.camera),
                onPressed: () {
                  // Handle Instagram link here
                },
              ),
            ],
          ),
        ),
      ),
      // Library Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle library button click
        },
        child: const Icon(Icons.library_books),
      ),
    );
  }

  // --------------------------------------------------------------------------- POP UP to APPLY NEW SUBJECT
  void _showApplyForTeachingSubjectDialog(BuildContext context) {
    String subjectName = '';
    String subjectDescription = '';
    DateTime? selectedDate;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Apply for Teaching a New Subject'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Subject Name
                TextField(
                  onChanged: (value) {
                    subjectName = value;
                  },
                  decoration: const InputDecoration(labelText: 'Subject Name'),
                ),

                // Subject Description
                TextField(
                  onChanged: (value) {
                    subjectDescription = value;
                  },
                  decoration:
                      const InputDecoration(labelText: 'Subject Description'),
                ),

                // Date Picker for Years of Experience
                ElevatedButton(
                  onPressed: () async {
                    final selected = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 50),
                      lastDate: DateTime.now(),
                    );
                    if (selected != null && selected != selectedDate) {
                      setState(() {
                        selectedDate = selected;
                      });
                    }
                  },
                  child: Text(selectedDate == null
                      ? 'Select Years of Experience'
                      : 'Years of Experience: ${DateTime.now().year - selectedDate!.year}'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Handle the form submission
                // You can access the form values here
                print('Subject Name: $subjectName');
                print('Subject Description: $subjectDescription');
                if (selectedDate != null) {
                  print(
                      'Years of Experience: ${DateTime.now().year - selectedDate!.year}');
                }

                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _showSubjectDetails(BuildContext context, String subjectName) {
    // You can show details of the selected subject in a new dialog or perform any action you want
    // For example:
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Subject Details: $subjectName'),
          content: const Text(
              'Applying to teach this subject requires a verification process to ensure your expertise. You\'ll need to provide certifications and demonstrate your knowledge. All the necessary information to complete the application will be sent to you via email. Thank you for your interest in teaching with BoostedWisdom.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Apply for this Subject'),
            ),
          ],
        );
      },
    );
  }
}

//
//
//
//
//
//
//
//
//
//
// ---------------------------------------------------------------------------------- ENUM TYPE FOR LOG IN
enum UserType { student, educator, unknown }

//
//
//
//
//
//
//
//
//
//
// -------------------------------------------------------------------------------------------- MY HOME PAGE
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool correctAnswerSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      // ----------------------------------------------------------------------- NAVBAR
      appBar: AppBar(
        title: const Text('BoostWis - Unlock Your Potential'),
        actions: [
          IconButton(
            // HOME BUTTON
            icon: const Icon(Icons.home),
            onPressed: () {
              // Handle navigation to Home
            },
          ),
          IconButton(
            // ABOUT BUTTON
            icon: const Icon(Icons.info),
            onPressed: () {
              Navigator.pushNamed(
                  context, '/about'); // Navigate to the AboutPage
            },
          ),
          IconButton(
            // SignIN BUTTON
            icon: const Icon(Icons.login),
            onPressed: () {
              // Show the SignIn dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SignInDialog();
                },
              );
            },
          ),
          IconButton(
            // SignUP BUTTON
            icon: const Icon(Icons.person_add),
            onPressed: () {
              // Show the SignUp dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SignUpDialog();
                },
              );
            },
          ),
        ],
      ),
      //
      // ----------------------------------------------------------------------- BODY
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/boostwis_logo.jpeg'),
            const Padding(
              padding: EdgeInsets.all(1.0),
              child: Text(
                'Where Learning Meets Excellence!',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue, // Choose a vibrant color
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 150.0,
                  vertical: 100), // Add horizontal padding here
              child: const Text(
                'Welcome to BoostWis, the ultimate platform for academic excellence. '
                'We connect passionate learners like you with expert educators to '
                'take your education to the next level. Here, you can discover '
                'knowledge, enhance your skills, and unlock your full potential.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center, // Center the text horizontally
              ),
            ),
            // Add more paragraphs as needed

            // ----------------------------------------------------------------- FEATURED SUBJECTS CAROUSEL
            // Title
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Featured Subjects',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Card Carousel with Subjects
            CarouselSlider(
              items: subjects.map((subject) {
                return GestureDetector(
                  onTap: () {
                    _showSubjectPopup(context, subject);
                  },
                  child: Card(
                    elevation: 10, // Add elevation for a shadow effect
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(
                          10.0), // Adjust padding as needed
                      child: Center(
                        child: Text(
                          subject['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20, // Adjust the font size
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 250.0, // Adjust the height as needed
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 5.0, // Adjust the aspect ratio
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 600),
                viewportFraction: 0.2, // Display 5 cards in the carousel
              ),
            ),
            // ----------------------------------------------------------------- TEXT ABOUT EDUCATORS
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 150.0,
                  vertical: 100), // Add horizontal padding here
              child: const Text(
                "At BoostWis, we take great pride in the selection of our educators. We believe that a strong educational foundation begins with exceptional teachers who are not only knowledgeable but also passionate about their subjects. Our rigorous educator selection process ensures that we have the best educators for our students.\n\nWe understand that choosing the right educators takes time and careful consideration. That's why we put a significant effort into evaluating each educator's qualifications, teaching experience, and dedication to excellence. We want to provide our students with nothing but the best learning experience.\n\nRest assured that when you engage with an educator on BoostWis, you are learning from a professional who has been carefully vetted and chosen to guide you on your educational journey. We believe in the power of knowledge and the impact that a great educator can have on your academic success.\n\nChoose BoostWis as your learning platform. We are committed to your educational growth and will continue to bring you the finest educators who share our passion for learning.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            // ----------------------------------------------------------------- QUIZ CAROUSEL
            // Title
            const Padding(
              padding: EdgeInsets.only(top: 70.0),
              child: Text(
                'Test your Knowledge',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Card Crousel with QUIZ
            CarouselSlider(
              options: CarouselOptions(
                height: 400.0, // Adjust the height as needed
                autoPlay: false, // Set to true for automatic carousel scrolling
                enlargeCenterPage: true,
                aspectRatio: 16 / 9, // Adjust the aspect ratio as needed
                enableInfiniteScroll:
                    false, // Set to true for infinite scrolling
              ),
              items: quizQuestions.map((question) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        elevation: 5.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              question['question'],
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Column(
                              children:
                                  question['options'].map<Widget>((option) {
                                return RadioListTile(
                                  title: Text(option),
                                  value: option,
                                  groupValue: question['selectedAnswer'],
                                  onChanged: (value) {
                                    setState(() {
                                      // Handle selecting an answer here
                                      question['selectedAnswer'] = value;

                                      // Check if the selected answer is correct
                                      if (value == question['correctAnswer']) {
                                        correctAnswerSelected = true;
                                        // Show a congratulations popup
                                        _showCongratulationsDialog(context);
                                      } else {
                                        // Wrong Answer
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Center(
                                                // Center the title
                                                child: Text(
                                                  'Wrong Answer',
                                                  style: TextStyle(
                                                    color: Colors
                                                        .red, // Make the text red
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24.0,
                                                  ),
                                                ),
                                              ),
                                              content: const Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                      "Sorry, that's not the correct answer."),
                                                  SizedBox(height: 16.0),
                                                  Text(
                                                      'Check out BoostWis for more learning opportunities!'),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
      //
      //------------------------------------------------------------------------ FOOTER
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Boosted Wisdom',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '© ${DateTime.now().year}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.facebook),
                  color: Colors.white,
                  onPressed: () {
                    // Handle navigation to Facebook
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.camera),
                  color: Colors.white,
                  onPressed: () {
                    // Handle navigation to Instagram
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showCongratulationsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: const Text('You selected the correct answer.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // --------------------------------------------------------------------------- POPUP ShowSubject
  void _showSubjectPopup(BuildContext context, Map<String, dynamic> subject) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(subject['name']),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Description: ${subject['description']}'),
              const SizedBox(height: 10),
              const Text('Educators:'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (subject['educators'] as List<Map<String, dynamic>>)
                    .map((educator) {
                  return Text(
                    '- ${educator['name']} (${educator['degree']})',
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

//
//
//
//
//
//
//
//
//
//
// ---------------------------------------------------------------------------------- INFO/ABOUT LANDING PAGE
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'), // Set the title for your page
        actions: [
          IconButton(
            icon: const Icon(Icons.home), // Add a home icon button
            onPressed: () {
              Navigator.pop(context); // Navigate back to MyHomePage
            },
          ),
        ],
      ),
      body: const Center(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(16.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pedro Carneiro',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 35.0),
                    //Text('Pedro Carneiro'),
                    Text('NºMec:73775'),
                    Text(
                        'Attending Degree: Licenciatura em Engenharia de Computadores e Informática'),
                    Text('Attending Subject: Interação Humano-Computador'),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(16.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Inês Águia',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 35.0),
                    //Text('Inês Águia'),
                    Text('NºMec:73882'),
                    Text(
                        'Attending Degree: Licenciatura em Engenharia de Computadores e Informática'),
                    Text('Attending Subject: Interação Humano-Computador'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Boosted Wisdom © 2023',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
//
//
//
//
//
//
//
//
//
// ----------------------------------------------------------------------------------------- LIST OF SUBJECTS
List<Map<String, dynamic>> subjects = [
  {
    'name': 'Mathematics',
    'description': 'The study of numbers, quantities, and shapes.',
    'educators': [
      {'name': 'John Smith', 'age': 45, 'degree': 'Ph.D. in Mathematics'},
      {'name': 'Alice Johnson', 'age': 38, 'degree': 'M.Sc. in Mathematics'},
    ],
  },
  {
    'name': 'Computer Science',
    'description': 'The study of algorithms, programming, and computation.',
    'educators': [
      {'name': 'David Brown', 'age': 50, 'degree': 'Ph.D. in Computer Science'},
      {'name': 'Linda Davis', 'age': 42, 'degree': 'M.Sc. in Computer Science'},
    ],
  },
  {
    'name': 'Physics',
    'description':
        'The science of matter, energy, and the fundamental forces of the universe.',
    'educators': [
      {'name': 'Robert White', 'age': 55, 'degree': 'Ph.D. in Physics'},
      {'name': 'Sarah Green', 'age': 48, 'degree': 'M.Sc. in Physics'},
    ],
  },
  {
    'name': 'Biology',
    'description': 'The study of living organisms and their interactions.',
    'educators': [
      {'name': 'Michael Turner', 'age': 43, 'degree': 'Ph.D. in Biology'},
      {'name': 'Emily Parker', 'age': 37, 'degree': 'M.Sc. in Biology'},
    ],
  },
  {
    'name': 'History',
    'description': 'The study of past events and their impact on society.',
    'educators': [
      {'name': 'Daniel Adams', 'age': 58, 'degree': 'Ph.D. in History'},
      {'name': 'Laura Wilson', 'age': 51, 'degree': 'M.A. in History'},
    ],
  },
  {
    'name': 'Chemistry',
    'description':
        'The science of the composition, structure, and properties of matter.',
    'educators': [
      {'name': 'James Martin', 'age': 47, 'degree': 'Ph.D. in Chemistry'},
      {'name': 'Karen Hall', 'age': 40, 'degree': 'M.Sc. in Chemistry'},
    ],
  },
  {
    'name': 'Psychology',
    'description':
        'The study of the mind and behavior of individuals and groups.',
    'educators': [
      {'name': 'Steven Clark', 'age': 52, 'degree': 'Ph.D. in Psychology'},
      {'name': 'Megan Adams', 'age': 44, 'degree': 'M.A. in Psychology'},
    ],
  },
  {
    'name': 'Economics',
    'description':
        'The study of the production, distribution, and consumption of goods and services.',
    'educators': [
      {'name': 'Richard Turner', 'age': 49, 'degree': 'Ph.D. in Economics'},
      {'name': 'Susan Miller', 'age': 41, 'degree': 'M.Sc. in Economics'},
    ],
  },
  {
    'name': 'Political Science',
    'description': 'The study of government, politics, and political behavior.',
    'educators': [
      {
        'name': 'John Walker',
        'age': 47,
        'degree': 'Ph.D. in Political Science'
      },
      {'name': 'Maria Lopez', 'age': 39, 'degree': 'M.A. in Political Science'},
    ],
  },
  {
    'name': 'Art History',
    'description':
        'The study of art and its historical context and significance.',
    'educators': [
      {'name': 'Charles White', 'age': 54, 'degree': 'Ph.D. in Art History'},
      {'name': 'Ella Turner', 'age': 47, 'degree': 'M.A. in Art History'},
    ],
  },
  {
    'name': 'Sociology',
    'description':
        'The study of human society, social behavior, and institutions.',
    'educators': [
      {'name': 'William Harris', 'age': 48, 'degree': 'Ph.D. in Sociology'},
      {'name': 'Patricia Clark', 'age': 42, 'degree': 'M.A. in Sociology'},
    ],
  },
  {
    'name': 'Environmental Science',
    'description': 'The study of the environment and its impact on the planet.',
    'educators': [
      {
        'name': 'Thomas Brown',
        'age': 53,
        'degree': 'Ph.D. in Environmental Science'
      },
      {
        'name': 'Olivia Wilson',
        'age': 45,
        'degree': 'M.Sc. in Environmental Science'
      },
    ],
  },
  {
    'name': 'Philosophy',
    'description':
        'The study of fundamental questions about existence, knowledge, and ethics.',
    'educators': [
      {'name': 'George Turner', 'age': 50, 'degree': 'Ph.D. in Philosophy'},
      {'name': 'Sophia Davis', 'age': 43, 'degree': 'M.A. in Philosophy'},
    ],
  },
  {
    'name': 'Engineering',
    'description':
        'The application of scientific and mathematical principles to design and build systems and structures.',
    'educators': [
      {'name': 'Andrew Harris', 'age': 45, 'degree': 'Ph.D. in Engineering'},
      {'name': 'Nancy Miller', 'age': 38, 'degree': 'M.Sc. in Engineering'},
    ],
  },
  {
    'name': 'Literature',
    'description':
        'The study of written and spoken works of creativity and expression.',
    'educators': [
      {'name': 'Robert Adams', 'age': 55, 'degree': 'Ph.D. in Literature'},
      {'name': 'Grace White', 'age': 48, 'degree': 'M.A. in Literature'},
    ],
  },
  {
    'name': 'Geology',
    'description':
        'The science of the Earth, its structure, and the processes that shape it.',
    'educators': [
      {'name': 'Peter Turner', 'age': 49, 'degree': 'Ph.D. in Geology'},
      {'name': 'Linda Walker', 'age': 41, 'degree': 'M.Sc. in Geology'},
    ],
  },
  {
    'name': 'Music',
    'description': 'The study of sound, composition, and musical expression.',
    'educators': [
      {'name': 'Michael White', 'age': 51, 'degree': 'Ph.D. in Music'},
      {'name': 'Emma Davis', 'age': 43, 'degree': 'M.A. in Music'},
    ],
  },
  {
    'name': 'Chemical Engineering',
    'description':
        'The application of chemistry to industrial processes and design.',
    'educators': [
      {
        'name': 'Joseph Martin',
        'age': 47,
        'degree': 'Ph.D. in Chemical Engineering'
      },
      {
        'name': 'Sophie Turner',
        'age': 39,
        'degree': 'M.Sc. in Chemical Engineering'
      },
    ],
  },
  {
    'name': 'Foreign Languages',
    'description': 'The study of languages other than one\'s native language.',
    'educators': [
      {'name': 'William Turner', 'age': 52, 'degree': 'Ph.D. in Linguistics'},
      {'name': 'Eva Clark', 'age': 44, 'degree': 'M.A. in Linguistics'},
    ],
  },
];

// ----------------------------------------------------------------------------------------- LIST OF EDUCATORS
List<Map<String, dynamic>> generateEducatorsList(
    List<Map<String, dynamic>> subjects) {
  List<Map<String, dynamic>> educatorsList = [];

  // Iterate through the subjects and extract educator information
  for (var subject in subjects) {
    for (var educator in subject['educators']) {
      var educatorInfo = {
        'name': educator['name'],
        'age': educator['age'],
        'degree': educator['degree'],
        'subjects_lectured': [
          subject['name']
        ], // List of subjects lectured by this educator
      };
      educatorsList.add(educatorInfo);
    }
  }

  return educatorsList;
}

// ----------------------------------------------------------------------------------------- LIST OF QUESTIONS
List<Map<String, dynamic>> quizQuestions = [
  {
    'question': 'What is the capital of France?',
    'options': ['Paris', 'Berlin', 'Madrid', 'London'],
    'correctAnswer': 'Paris',
  },
  {
    'question': 'Which planet is known as the Red Planet?',
    'options': ['Mars', 'Venus', 'Jupiter', 'Saturn'],
    'correctAnswer': 'Mars',
  },
  {
    'question': 'What is the largest mammal in the world?',
    'options': ['Elephant', 'Giraffe', 'Blue Whale', 'Lion'],
    'correctAnswer': 'Blue Whale',
  },
  {
    'question': 'Who wrote the play "Romeo and Juliet"?',
    'options': [
      'Charles Dickens',
      'Jane Austen',
      'William Shakespeare',
      'F. Scott Fitzgerald'
    ],
    'correctAnswer': 'William Shakespeare',
  },
  {
    'question': 'What gas do plants absorb from the atmosphere?',
    'options': ['Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Hydrogen'],
    'correctAnswer': 'Carbon Dioxide',
  },
  {
    'question': 'What is the largest planet in our solar system?',
    'options': ['Earth', 'Venus', 'Jupiter', 'Saturn'],
    'correctAnswer': 'Jupiter',
  },
  {
    'question': 'Who painted the Mona Lisa?',
    'options': [
      'Leonardo da Vinci',
      'Pablo Picasso',
      'Vincent van Gogh',
      'Michelangelo'
    ],
    'correctAnswer': 'Leonardo da Vinci',
  },
  {
    'question': 'What is the chemical symbol for gold?',
    'options': ['Go', 'Ag', 'Au', 'Fe'],
    'correctAnswer': 'Au',
  },
  {
    'question': 'Which gas do plants release during photosynthesis?',
    'options': ['Carbon Dioxide', 'Oxygen', 'Methane', 'Hydrogen'],
    'correctAnswer': 'Oxygen',
  },
  {
    'question': 'What is the tallest mountain in the world?',
    'options': [
      'Mount Kilimanjaro',
      'Mount Everest',
      'Mount Fuji',
      'Mount Rushmore'
    ],
    'correctAnswer': 'Mount Everest',
  },
  {
    'question': 'Who wrote the novel "To Kill a Mockingbird"?',
    'options': ['J.K. Rowling', 'Mark Twain', 'Harper Lee', 'George Orwell'],
    'correctAnswer': 'Harper Lee',
  },
  {
    'question': 'Which gas makes up the majority of Earth\'s atmosphere?',
    'options': ['Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Hydrogen'],
    'correctAnswer': 'Nitrogen',
  },
  {
    'question':
        'Which planet is known as the "Morning Star" or "Evening Star"?',
    'options': ['Mars', 'Venus', 'Jupiter', 'Saturn'],
    'correctAnswer': 'Venus',
  },
  {
    'question': 'Who was the first person to step on the moon?',
    'options': ['Neil Armstrong', 'Buzz Aldrin', 'Yuri Gagarin', 'John Glenn'],
    'correctAnswer': 'Neil Armstrong',
  },
  {
    'question': 'What is the smallest planet in our solar system?',
    'options': ['Mercury', 'Venus', 'Earth', 'Mars'],
    'correctAnswer': 'Mercury',
  },
  {
    'question': 'Which element has the chemical symbol "H"?',
    'options': ['Helium', 'Hydrogen', 'Hassium', 'Hafnium'],
    'correctAnswer': 'Hydrogen',
  },
  {
    'question': 'Who is the author of "The Great Gatsby"?',
    'options': [
      'F. Scott Fitzgerald',
      'Ernest Hemingway',
      'Mark Twain',
      'Charles Dickens'
    ],
    'correctAnswer': 'F. Scott Fitzgerald',
  },
  {
    'question': 'What is the largest ocean in the world?',
    'options': [
      'Indian Ocean',
      'Atlantic Ocean',
      'Arctic Ocean',
      'Pacific Ocean'
    ],
    'correctAnswer': 'Pacific Ocean',
  },
  {
    'question': 'What is the freezing point of water in Fahrenheit?',
    'options': ['-32°F', '0°F', '32°F', '100°F'],
    'correctAnswer': '32°F',
  },
];
