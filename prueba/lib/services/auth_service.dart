import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyBv0VRytJO3JtnOyZC4Q2k4tb5pKfSWABo';
 
  String localId='';
  String idToken='';
  String pass='false';

 

  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken':true
    };
    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});
    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
  
    

    return decodedResp['localId'];

  }
  Future<String?> deleteUser(id) async {
    final Map<String, dynamic> userData = {
      'idToken': id,
      
    };
    final url =
        Uri.https(_baseUrl, '/v1/accounts:delete', {'key': _firebaseToken});
    final resp = await http.post(url, body: json.encode(userData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
  
    print(decodedResp);

    return  null;
    
  }
  


  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken':true
    };
    final url =
        Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});
    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    

    if(decodedResp.containsKey('idToken')){
      
      idToken= decodedResp['idToken'];
      return decodedResp['localId'];
    }else{
      
      return null;
    }

  }

  Future logout()async{
    localId='';
    
   
    return ;
  }

  

  

  Future<String> readToken()async{
    
    
    return localId;

  }
}
