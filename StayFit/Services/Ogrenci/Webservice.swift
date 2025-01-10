//
//  Webservices.swift
//  StayFit
//
//  Created by İmat Gökaslan on 13.10.2024.
//

import Foundation
import Alamofire

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

struct LoginRequestBody: Codable {
    let email: String
    let password: String
}

struct LoginResponse: Codable {
    let tokenDto: TokenDto
    let message: String?
    let success: Bool?
}

struct TokenDto: Codable {
    var token: String
    var expires: String
}

class Webservice {
    func login(email: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        guard let url = URL(string: "\(APIConfig.baseURL)/api/Auth/TrainerLogin") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = LoginRequestBody(email: email, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            completion(.failure(.custom(errorMessage: "Failed to encode request body")))
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data received or there was an error")))
                return
            }
            
            do {
                let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                
                // Doğrudan token'a eriş
                let token = loginResponse.tokenDto.token
                completion(.success(token))
                
            } catch {
                completion(.failure(.invalidCredentials))
            }
        }.resume()
    }
}


class Webservice2 {
    func login(email: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        guard let url = URL(string: "\(APIConfig.baseURL)/api/Auth/MemberLogin") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = LoginRequestBody(email: email, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            completion(.failure(.custom(errorMessage: "Failed to encode request body")))
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data received or there was an error")))
                return
            }
            
            do {
                let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                
                // Doğrudan token'a eriş
                let token = loginResponse.tokenDto.token
                completion(.success(token))
                
            } catch {
                completion(.failure(.invalidCredentials))
            }
        }.resume()
    }
}
