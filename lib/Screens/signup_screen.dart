import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_flutter/Helper/social_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;
  String? _errorMessage;

  // Focus nodes for better accessibility
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  // Name validation
  String? _validateName(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    if (value.length < 2) {
      return '$fieldName must be at least 2 characters long';
    }

    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return '$fieldName should only contain letters';
    }

    return null;
  }

  // Email validation
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  // Password validation
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
      return 'Password must contain uppercase, lowercase and number';
    }

    return null;
  }

  // Confirm password validation
  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  // Handle signup
  Future<void> _handleSignup() async {
    // Clear any previous error messages
    setState(() {
      _errorMessage = null;
    });

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_agreeToTerms) {
      setState(() {
        _errorMessage = 'Please agree to the Terms and Conditions';
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // For demo purposes - simulate successful registration
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created successfully! Please sign in.'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
        
        // Navigate back to login screen
        Navigator.pop(context);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred. Please try again later.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Handle social signup
  Future<void> _handleSocialSignup(String provider) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Simulate social signup
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$provider signup successful!'),
            backgroundColor: Colors.green,
          ),
        );
        
        // Navigate back to login screen
        Navigator.pop(context);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to signup with $provider. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: HexColor('#3461FD')),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            children: [
              // Header
              _buildHeader(),

              const SizedBox(height: 24),

              // Error message display
              if (_errorMessage != null) _buildErrorMessage(),

              // Social buttons
              _buildSocialButtons(),

              const SizedBox(height: 20),

              // Divider
              _buildDivider(),

              const SizedBox(height: 24),

              // Name fields
              _buildNameFields(),

              const SizedBox(height: 20),

              // Email field
              _buildEmailField(),

              const SizedBox(height: 20),

              // Password field
              _buildPasswordField(),

              const SizedBox(height: 20),

              // Confirm password field
              _buildConfirmPasswordField(),

              const SizedBox(height: 20),

              // Terms and conditions checkbox
              _buildTermsCheckbox(),

              const SizedBox(height: 32),

              // Signup button
              _buildSignupButton(),

              const SizedBox(height: 24),

              // Sign in link
              _buildSignInLink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          'Create Account',
          style: GoogleFonts.poppins(
            fontSize: 32,
            color: const Color.fromRGBO(42, 78, 202, 1),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Sign up to get started with your new account',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: HexColor('#61677D'),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildErrorMessage() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade600, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _errorMessage!,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.red.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      children: [
        Expanded(
          child: SocialButton(
            onPressed: _isLoading ? null : () => _handleSocialSignup('Facebook'),
            icon: 'assets/images/facebook.png',
            label: 'Facebook',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SocialButton(
            onPressed: _isLoading ? null : () => _handleSocialSignup('Google'),
            icon: 'assets/images/google.png',
            label: 'Google',
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: HexColor('#E0E5E0'), thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Or continue with email',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: HexColor('#61677D'),
            ),
          ),
        ),
        Expanded(child: Divider(color: HexColor('#E0E5E0'), thickness: 1)),
      ],
    );
  }

  Widget _buildNameFields() {
    return Row(
      children: [
        // First Name
        Expanded(
          child: TextFormField(
            controller: _firstNameController,
            focusNode: _firstNameFocusNode,
            textInputAction: TextInputAction.next,
            enabled: !_isLoading,
            validator: (value) => _validateName(value, 'First name'),
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_lastNameFocusNode);
            },
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
            decoration: _buildInputDecoration(
              hintText: 'First name',
              labelText: 'First Name',
              prefixIcon: Icon(Icons.person_outline, color: HexColor('#61677D')),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Last Name
        Expanded(
          child: TextFormField(
            controller: _lastNameController,
            focusNode: _lastNameFocusNode,
            textInputAction: TextInputAction.next,
            enabled: !_isLoading,
            validator: (value) => _validateName(value, 'Last name'),
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_emailFocusNode);
            },
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
            decoration: _buildInputDecoration(
              hintText: 'Last name',
              labelText: 'Last Name',
              prefixIcon: Icon(Icons.person_outline, color: HexColor('#61677D')),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      enabled: !_isLoading,
      validator: _validateEmail,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
      decoration: _buildInputDecoration(
        hintText: 'Enter your email',
        labelText: 'Email',
        prefixIcon: Icon(Icons.email_outlined, color: HexColor('#61677D')),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      obscureText: _obscurePassword,
      textInputAction: TextInputAction.next,
      enabled: !_isLoading,
      validator: _validatePassword,
      onFieldSubmitted: (_) {
        FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
      },
      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
      decoration: _buildInputDecoration(
        hintText: 'Enter your password',
        labelText: 'Password',
        prefixIcon: Icon(Icons.lock_outline, color: HexColor('#61677D')),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: HexColor('#61677D'),
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
          tooltip: _obscurePassword ? 'Show password' : 'Hide password',
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswordController,
      focusNode: _confirmPasswordFocusNode,
      obscureText: _obscureConfirmPassword,
      textInputAction: TextInputAction.done,
      enabled: !_isLoading,
      validator: _validateConfirmPassword,
      onFieldSubmitted: (_) => _handleSignup(),
      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
      decoration: _buildInputDecoration(
        hintText: 'Confirm your password',
        labelText: 'Confirm Password',
        prefixIcon: Icon(Icons.lock_outline, color: HexColor('#61677D')),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureConfirmPassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: HexColor('#61677D'),
          ),
          onPressed: () {
            setState(() {
              _obscureConfirmPassword = !_obscureConfirmPassword;
            });
          },
          tooltip: _obscureConfirmPassword ? 'Show password' : 'Hide password',
        ),
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: _agreeToTerms,
          onChanged: _isLoading
              ? null
              : (bool? value) {
                  setState(() {
                    _agreeToTerms = value ?? false;
                  });
                },
          activeColor: HexColor('#3461FD'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: _isLoading
                ? null
                : () {
                    setState(() {
                      _agreeToTerms = !_agreeToTerms;
                    });
                  },
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: RichText(
                text: TextSpan(
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: HexColor('#61677D'),
                  ),
                  children: [
                    const TextSpan(text: 'I agree to the '),
                    TextSpan(
                      text: 'Terms and Conditions',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: HexColor('#3461FD'),
                      ),
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: HexColor('#3461FD'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignupButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleSignup,
        style: ElevatedButton.styleFrom(
          backgroundColor: HexColor('#3461FD'),
          disabledBackgroundColor: HexColor('#3461FD').withOpacity(0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: _isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                "Create Account",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Widget _buildSignInLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: HexColor('#61677D'),
          ),
        ),
        TextButton(
          onPressed: _isLoading
              ? null
              : () {
                  Navigator.pop(context);
                },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Sign In',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: HexColor('#3461FD'),
            ),
          ),
        ),
      ],
    );
  }

  // Helper method to build consistent input decoration
  InputDecoration _buildInputDecoration({
    required String hintText,
    required String labelText,
    required Widget prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: HexColor('#F5F9FE'),
      hintText: hintText,
      labelText: labelText,
      labelStyle: GoogleFonts.poppins(
        fontSize: 16,
        color: HexColor('#61677D'),
      ),
      hintStyle: GoogleFonts.poppins(
        fontSize: 14,
        color: HexColor('#61677D').withOpacity(0.6),
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: HexColor('#E0E5E0')),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: HexColor('#3461FD'), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
    );
  }
}