import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';



void main() async {

  await Supabase.initialize(
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9oa2NjdnV1bnp2aXpuZndvdmpoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTg5NTA0NjgsImV4cCI6MjA3NDUyNjQ2OH0.eFGp_e25tSvFf-6bAK-cIp83JscfyvOTsZ9EzcGwYHg",
    url: "https://ohkccvuunzviznfwovjh.supabase.co",
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BloodiFind',
      theme: ThemeData(
        primaryColor: Color(0xFFEF4444),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFFEF4444),
          primary: Color(0xFFEF4444),
          secondary: Colors.blue,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login successful!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to main app
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainApp(userId: 'user123')),
      );
    }
  }

  void _navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: 40),

              // Hospital Logo and Welcome Text
              _buildHeader(),

              SizedBox(height: 48),

              // Login Form
              _buildLoginForm(),

              SizedBox(height: 32),

              // Login Button
              _buildLoginButton(),

              SizedBox(height: 24),

              // Divider
              _buildDivider(),

              SizedBox(height: 10),

              // Sign Up Link
              _buildSignUpLink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Hospital Logo with Asset Image
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
              'assets/LDH (2).jpg',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                // Fallback in case image fails to load
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.medical_services,
                      size: 40,
                      color: Colors.blue.shade700,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'LDH',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),

        SizedBox(height: 32),

        Text(
          'BloodiFind',
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),

        SizedBox(height: 8),

        Text(
          'Sign in to your account',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),

          SizedBox(height: 20),

          TextFormField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey.shade600,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),

          SizedBox(height: 16),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // Navigate to forgot password screen
              },
              child: Text(
                'Forgot Password?',
                style: GoogleFonts.poppins(
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _login,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: _isLoading
            ? SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : Text(
          'Sign In',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey.shade300,
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Or',
            style: GoogleFonts.poppins(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey.shade300,
            thickness: 1,
          ),
        ),
      ],
    );
  }


  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: Colors.grey.shade600,

          ),
        ),
        SizedBox(width: 2),
        TextButton(
          onPressed: _navigateToSignUp,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          child: Text(
            'Sign Up',
            style: GoogleFonts.poppins(
              color: Colors.blue.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  bool _agreeToTerms = false;


  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _signUp() async {
    if (_formKey.currentState!.validate() && _agreeToTerms) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Account created successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate back to login after success
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pop(context);
      });
    } else if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please agree to the terms and conditions'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: 20),

              // Back Button and Header
              _buildHeader(),

              SizedBox(height: 24),

              // Sign Up Form
              _buildSignUpForm(),

              SizedBox(height: 20),

              // Terms and Conditions
              _buildTermsCheckbox(),

              SizedBox(height: 24),

              // Sign Up Button
              _buildSignUpButton(),

              SizedBox(height: 24),

              // Login Link
              _buildLoginLink(),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Back Button
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                onPressed: () => Navigator.pop(context),
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),

        SizedBox(height: 20),

        // Hospital Logo Container
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
              'assets/LDH (2).jpg',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                // Fallback in case image fails to load
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.medical_services,
                      size: 40,
                      color: Colors.blue.shade700,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'LDH',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),

        SizedBox(height: 20),

        Text(
          'BloodiFind',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),

        SizedBox(height: 8),

        Text(
          'Join Laguna Doctors Hospital',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [


          SizedBox(height: 16),

          // Full Name Field
          TextFormField(
            controller: _firstNameController,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: 'First Name',
              prefixIcon: Icon(Icons.person_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your first name';
              }
              if (value.length < 2) {
                return 'Name must be at least 2 characters';
              }
              return null;
            },
          ),

          SizedBox(height: 16),

          TextFormField(
            controller: _lastNameController,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: 'Last Name',
              prefixIcon: Icon(Icons.person_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your last name';
              }
              if (value.length < 2) {
                return 'Name must be at least 2 characters';
              }
              return null;
            },
          ),

          SizedBox(height: 16),

          // Email Field
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),

          SizedBox(height: 16),

          // Phone Field
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              prefixIcon: Icon(Icons.phone_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              if (value.length < 10) {
                return 'Please enter a valid phone number';
              }
              return null;
            },
          ),

          SizedBox(height: 16),

          // Address Field
          TextFormField(
            controller: _addressController,
            keyboardType: TextInputType.streetAddress,
            decoration: InputDecoration(
              labelText: 'Address',
              prefixIcon: Icon(Icons.home_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your address';
              }
              return null;
            },
          ),

          SizedBox(height: 16),

          // Password Field
          TextFormField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey.shade600,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)').hasMatch(value)) {
                return 'Password must contain letters and numbers';
              }
              return null;
            },
          ),

          SizedBox(height: 16),

          // Confirm Password Field
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: !_isConfirmPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              prefixIcon: Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey.shade600,
                ),
                onPressed: () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: _agreeToTerms,
          onChanged: (value) {
            setState(() {
              _agreeToTerms = value!;
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          activeColor: Colors.blue.shade700,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Wrap(
              children: [
                Text(
                  'I agree to the ',
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Show terms and conditions
                  },
                  child: Text(
                    'Terms & Conditions',
                    style: GoogleFonts.poppins(
                      color: Colors.blue.shade700,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  ' and ',
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Show privacy policy
                  },
                  child: Text(
                    'Privacy Policy',
                    style: GoogleFonts.poppins(
                      color: Colors.blue.shade700,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _signUp,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: _isLoading
            ? SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : Text(
          'Create Account',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: GoogleFonts.poppins(
            color: Colors.grey.shade600,
          ),
        ),
        SizedBox(width: 4),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          child: Text(
            'Sign In',
            style: GoogleFonts.poppins(
              color: Colors.blue.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class MainApp extends StatefulWidget {
  final String userId;

  const MainApp({super.key, required this.userId});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    AddDonorScreen(),
    SearchScreen(),
    MapScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFFEF4444),
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
        unselectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            activeIcon: Icon(Icons.add_circle),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            activeIcon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Home Screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedBloodType = 'All';
  List<Donor> _donors = [];
  List<Donor> _filteredDonors = [];

  final List<String> bloodTypes = [
    'All', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'
  ];

  @override
  void initState() {
    super.initState();
    _loadDonors();
  }

  Future<void> _loadDonors() async {
    // Mock data - in real app, fetch from Supabase
    setState(() {
      _donors = [
        Donor(
          id: '1',
          fullName: 'Juan Dela Cruz',
          bloodType: 'A+',
          email: 'juan@example.com',
          phone: '+639123456789',
          city: 'Santa Cruz',
          barangay: 'Poblacion',
          isAvailable: true,
          userId: 'user1',
        ),
        Donor(
          id: '2',
          fullName: 'Maria Santos',
          bloodType: 'O+',
          email: 'maria@example.com',
          phone: '+639987654321',
          city: 'Calamba',
          barangay: 'Real',
          isAvailable: true,
          userId: 'user1',
        ),
        Donor(
          id: '3',
          fullName: 'Pedro Reyes',
          bloodType: 'B-',
          email: 'pedro@example.com',
          phone: '+639456789123',
          city: 'Santa Cruz',
          barangay: 'Bubukal',
          isAvailable: false,
          userId: 'user1',
        ),
        Donor(
          id: '4',
          fullName: 'Ana Lopez',
          bloodType: 'AB+',
          email: 'ana@example.com',
          phone: '+639789123456',
          city: 'Calamba',
          barangay: 'Mabato',
          isAvailable: true,
          userId: 'user1',
        ),
      ];
      _filteredDonors = _donors;
    });
  }

  void _filterDonors() {
    List<Donor> filtered = _donors;

    // Filter by blood type
    if (_selectedBloodType != 'All') {
      filtered = filtered.where((donor) => donor.bloodType == _selectedBloodType).toList();
    }

    // Filter by search text
    if (_searchController.text.isNotEmpty) {
      filtered = filtered.where((donor) =>
      donor.fullName.toLowerCase().contains(_searchController.text.toLowerCase()) ||
          donor.bloodType.contains(_searchController.text)
      ).toList();
    }

    setState(() {
      _filteredDonors = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'BloodiFind',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Color(0xFFEF4444),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Message
            Text(
              'Find Blood Donors',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Emergency blood donations made simple',
              style: GoogleFonts.poppins(
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 24),

            // Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by name or blood type...',
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFFEF4444)),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              onChanged: (value) => _filterDonors(),
            ),
            SizedBox(height: 16),

            // Blood Type Filter
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: bloodTypes.length,
                itemBuilder: (context, index) {
                  final type = bloodTypes[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      label: Text(type),
                      selected: _selectedBloodType == type,
                      onSelected: (selected) {
                        setState(() {
                          _selectedBloodType = selected ? type : 'All';
                        });
                        _filterDonors();
                      },
                      selectedColor: Color(0xFFEF4444),
                      checkmarkColor: Color(0xFFEF4444),
                      labelStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: _selectedBloodType == type ? Color(0xFFEF4444) : Colors.grey.shade700,
                      ),
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: _selectedBloodType == type ? Color(0xFFEF4444) : Colors.grey.shade300,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 24),

            // Results count
            Text(
              '${_filteredDonors.length} donor${_filteredDonors.length != 1 ? 's' : ''} found',
              style: GoogleFonts.poppins(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16),

            // Donor List
            Expanded(
              child: _filteredDonors.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.people_outline, size: 64, color: Colors.grey.shade400),
                    SizedBox(height: 16),
                    Text(
                      'No donors found',
                      style: GoogleFonts.poppins(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Try adjusting your search or filters',
                      style: GoogleFonts.poppins(
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                itemCount: _filteredDonors.length,
                itemBuilder: (context, index) {
                  final donor = _filteredDonors[index];
                  return DonorCard(donor: donor);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Donor Card Widget
class DonorCard extends StatelessWidget {
  final Donor donor;

  const DonorCard({super.key, required this.donor});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Blood Type Badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xFFEF4444),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Color(0xFFEF4444)),
                  ),
                  child: Text(
                    donor.bloodType,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFEF4444),
                      fontSize: 14,
                    ),
                  ),
                ),
                Spacer(),
                // Availability Status
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: donor.isAvailable ? Colors.green.shade50 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 8,
                        color: donor.isAvailable ? Colors.green : Colors.grey,
                      ),
                      SizedBox(width: 4),
                      Text(
                        donor.isAvailable ? 'Available' : 'Unavailable',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: donor.isAvailable ? Colors.green : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            // Donor Name
            Text(
              donor.fullName,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
            ),
            SizedBox(height: 8),
            // Location
            Row(
              children: [
                Icon(Icons.location_on_outlined, size: 16, color: Colors.grey.shade600),
                SizedBox(width: 4),
                Text(
                  '${donor.barangay}, ${donor.city}',
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            // Contact Preview
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _launchCall(donor.phone),
                    icon: Icon(Icons.phone, size: 16),
                    label: Text('Call'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue,
                      side: BorderSide(color: Colors.blue),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _launchEmail(donor.email),
                    icon: Icon(Icons.email, size: 16),
                    label: Text('Email'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.green,
                      side: BorderSide(color: Colors.green),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DonorProfileScreen(donor: donor),
                      ),
                    );
                  },
                  icon: Icon(Icons.visibility_outlined, color: Colors.grey.shade600),
                  tooltip: 'View Profile',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _launchCall(String phone) async {
    final url = 'tel:$phone';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  void _launchEmail(String email) async {
    final url = 'mailto:$email';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}

// Add Donor Form
class AddDonorScreen extends StatefulWidget {
  const AddDonorScreen({super.key});

  @override
  State<AddDonorScreen> createState() => _AddDonorScreenState();
}

class _AddDonorScreenState extends State<AddDonorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _barangayController = TextEditingController();

  String _selectedBloodType = 'A+';
  bool _isAvailable = true;

  final List<String> bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Save donor to database
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Donor added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Donor',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Full Name
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter first name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter last name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Blood Type Dropdown
              DropdownButtonFormField<String>(
                initialValue: _selectedBloodType,
                decoration: InputDecoration(
                  labelText: 'Blood Type',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.bloodtype),
                ),
                items: bloodTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedBloodType = value!;
                  });
                },
              ),
              SizedBox(height: 16),

              // Email
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Phone
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // City
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_city),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter city';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Barangay
              TextFormField(
                controller: _barangayController,
                decoration: InputDecoration(
                  labelText: 'Barangay',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.home_work),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter barangay';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Availability Toggle
              SwitchListTile(
                title: Text(
                  'Available for Donation',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
                value: _isAvailable,
                onChanged: (value) {
                  setState(() {
                    _isAvailable = value;
                  });
                },
                secondary: Icon(_isAvailable ? Icons.check_circle : Icons.cancel,
                    color: _isAvailable ? Colors.green : Colors.grey),
              ),
              SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEF4444),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Add Donor',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Donor Profile View
class DonorProfileScreen extends StatelessWidget {
  final Donor donor;

  const DonorProfileScreen({super.key, required this.donor});

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Donor'),
          content: Text('Are you sure you want to delete ${donor.fullName}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Donor deleted successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
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
        title: Text('Donor Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit screen
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _showDeleteDialog(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Blood Type Badge
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: Color(0xFFEF4444),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Color(0xFFEF4444)),
                ),
                child: Text(
                  donor.bloodType,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFEF4444),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),

            // Donor Info
            _buildInfoRow('Full Name', donor.fullName, Icons.person),
            _buildInfoRow('Email', donor.email, Icons.email),
            _buildInfoRow('Phone', donor.phone, Icons.phone),
            _buildInfoRow('Location', '${donor.barangay}, ${donor.city}', Icons.location_on),

            SizedBox(height: 24),

            // Availability Status
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: donor.isAvailable ? Colors.green.shade50 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: donor.isAvailable ? Colors.green.shade200 : Colors.grey.shade300,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    donor.isAvailable ? Icons.check_circle : Icons.cancel,
                    color: donor.isAvailable ? Colors.green : Colors.grey,
                  ),
                  SizedBox(width: 12),
                  Text(
                    donor.isAvailable ? 'Available for donation' : 'Currently unavailable',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: donor.isAvailable ? Colors.green : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            Spacer(),

            // Contact Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _launchCall(donor.phone),
                    icon: Icon(Icons.phone),
                    label: Text('Call'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _launchEmail(donor.email),
                    icon: Icon(Icons.email),
                    label: Text('Email'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade600),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _launchCall(String phone) async {
    final url = 'tel:$phone';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  void _launchEmail(String email) async {
    final url = 'mailto:$email';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}

// Map View
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donor Map'),
      ),
      body: Column(
        children: [
          // Map Header
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey.shade50,
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Showing approximate locations by barangay/city for privacy protection',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map_outlined, size: 64, color: Colors.grey.shade400),
                  SizedBox(height: 16),
                  Text(
                    'Map View',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Showing donor clusters by location',
                    style: GoogleFonts.poppins(
                      color: Colors.grey.shade500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  // Mock cluster indicators
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildClusterIndicator('Santa Cruz', 2),
                      _buildClusterIndicator('Calamba', 2),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClusterIndicator(String location, int count) {
    return Chip(
      avatar: CircleAvatar(
        backgroundColor: Color(0xFFEF4444),
        child: Text(
          count.toString(),
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
      label: Text(location),
      backgroundColor: Colors.grey.shade100,
    );
  }
}

// Search Screen
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Donors'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search, size: 64, color: Colors.grey.shade400),
              SizedBox(height: 16),
              Text(
                'Advanced Search',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Use the search and filters on the Home screen to find specific donors',
                style: GoogleFonts.poppins(
                  color: Colors.grey.shade500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Profile Screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User Info
            CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFFEF4444),
              child: Icon(
                Icons.person,
                size: 40,
                color: Color(0xFFEF4444),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'User Name',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'user@example.com',
              style: GoogleFonts.poppins(
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 32),

            // Settings List
            _buildSettingsItem('Account Settings', Icons.settings),
            _buildSettingsItem('Privacy Policy', Icons.privacy_tip),
            _buildSettingsItem('Help & Support', Icons.help_outline),
            _buildSettingsItem('About BloodiFind', Icons.info_outline),

            Spacer(),

            // Sign Out Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Sign out logic
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEF4444),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Sign Out',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey.shade600),
      title: Text(
        title,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
      onTap: () {
        // Handle settings item tap
      },
    );
  }
}

// Donor Model
class Donor {
  final String id;
  final String fullName;
  final String bloodType;
  final String email;
  final String phone;
  final String city;
  final String barangay;
  final bool isAvailable;
  final String userId;

  Donor({
    required this.id,
    required this.fullName,
    required this.bloodType,
    required this.email,
    required this.phone,
    required this.city,
    required this.barangay,
    required this.isAvailable,
    required this.userId,
  });
}