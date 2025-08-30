import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  bool _isLoading = false;
  String? _currentUser;
  String? _accessToken;

  bool get isLoading => _isLoading;
  String? get currentUser => _currentUser;
  String? get accessToken => _accessToken;

  // 구글 로그인 (시뮬레이션)
  Future<bool> signInWithGoogle() async {
    _setLoading(true);
    
    try {
      // 시뮬레이션: 2초 대기 후 성공
      await Future.delayed(const Duration(seconds: 2));
      
      _accessToken = 'google_simulation_token';
      _currentUser = 'user@gmail.com';
      _setLoading(false);
      return true;
    } catch (e) {
      debugPrint('Google 로그인 에러: $e');
      _setLoading(false);
      return false;
    }
  }

  // 카카오 로그인 (시뮬레이션)
  Future<bool> signInWithKakao() async {
    _setLoading(true);
    
    try {
      // 시뮬레이션: 2초 대기 후 성공
      await Future.delayed(const Duration(seconds: 2));
      
      _accessToken = 'kakao_simulation_token';
      _currentUser = 'user@kakao.com';
      _setLoading(false);
      return true;
    } catch (e) {
      debugPrint('카카오 로그인 에러: $e');
      _setLoading(false);
      return false;
    }
  }

  // 네이버 로그인 (시뮬레이션)
  Future<bool> signInWithNaver() async {
    _setLoading(true);
    
    try {
      // 시뮬레이션: 2초 대기 후 성공
      await Future.delayed(const Duration(seconds: 2));
      
      _accessToken = 'naver_simulation_token';
      _currentUser = 'user@naver.com';
      _setLoading(false);
      return true;
    } catch (e) {
      debugPrint('네이버 로그인 에러: $e');
      _setLoading(false);
      return false;
    }
  }

  // 네이버 사용자 정보 가져오기
  Future<Map<String, dynamic>> _getNaverUserInfo(String accessToken) async {
    final response = await http.get(
      Uri.parse('https://openapi.naver.com/v1/nid/me'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['response'];
    } else {
      throw Exception('Failed to load user info');
    }
  }

  // 로그아웃 (시뮬레이션)
  Future<void> signOut() async {
    _setLoading(true);
    
    try {
      // 시뮬레이션: 1초 대기
      await Future.delayed(const Duration(seconds: 1));
      
      _currentUser = null;
      _accessToken = null;
    } catch (e) {
      debugPrint('로그아웃 에러: $e');
    } finally {
      _setLoading(false);
    }
  }

  // 로딩 상태 설정
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // 로그인 상태 확인
  bool get isLoggedIn => _currentUser != null;
} 