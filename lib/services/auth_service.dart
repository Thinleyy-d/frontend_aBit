// lib/services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:job_portal_ui/utils/shared_preferences_helper.dart'; // Import your helper

class AuthService {
  
  // For production, this will be your deployed server URL.
  static const String _baseUrl = 'http://127.0.0.1:8000/api'; // <<< Verify this IP address matches your backend server's IP

  Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Accept': 'application/json'},
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Ensure 'token' key exists in the response. Adjust if your API uses 'access_token' or similar.
        if (data.containsKey('token') && data['token'] is String) {
          String token = data['token'];
          await SharedPreferencesHelper.saveToken(token);
          print("Login successful. Token: $token");
          return token;
        } else {
          print("Login failed: 'token' not found in response body or not a string.");
          print("Response body: ${response.body}");
          return null;
        }
      } else {
        print("Login failed: Status Code ${response.statusCode} - ${response.body}");
        // You might want to parse response.body here for specific error messages from your backend
        return null;
      }
    } catch (e) {
      print("Login error: $e");
      // This catches network errors, host lookup failures, etc.
      return null;
    }
  }

  Future<Map<String, dynamic>?> getProfile() async {
    String? token = await SharedPreferencesHelper.getToken();
    if (token == null) {
      print("No token found. User not authenticated.");
      return null;
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/user'), // Example: your profile endpoint
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print("Profile fetched successfully. Response: ${response.body}");
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        // Unauthorized - token might be expired or invalid
        print("Error fetching profile: Unauthorized (401). Token might be invalid or expired. Logging out locally.");
        await logout(sendToApi: false); // Log out locally without sending API request again
        return null;
      } else {
        print("Error fetching profile: Status Code ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("Get profile error: $e");
      return null;
    }
  }

  // Modified logout function with an optional parameter to control API call
  Future<bool> logout({bool sendToApi = true}) async {
    String? token = await SharedPreferencesHelper.getToken();
    bool apiLogoutSuccess = true; // Assume success if no token or no API call needed

    if (token == null) {
      print("No token found locally. Already logged out or never logged in.");
      return true; // Consider it successful as user is not authenticated locally
    }

    if (sendToApi) {
      try {
        final response = await http.post(
          Uri.parse('$_baseUrl/logout'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          print("Logged out successfully from API.");
          apiLogoutSuccess = true;
        } else {
          print("API Logout failed (Status Code ${response.statusCode}): ${response.body}");
          apiLogoutSuccess = false;
        }
      } catch (e) {
        print("API Logout error: $e");
        apiLogoutSuccess = false; // Network error, consider API logout failed
      }
    } else {
      print("Skipping API logout request.");
    }

    // Always remove the token locally, regardless of API logout success/failure
    await SharedPreferencesHelper.removeToken();
    print("Local token removed.");

    return apiLogoutSuccess; // Return status of API logout (if attempted)
  }
}