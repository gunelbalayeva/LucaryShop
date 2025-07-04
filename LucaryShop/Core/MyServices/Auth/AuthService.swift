//
//  AuthService.swift
//  LucaryShop
//
//  Created by User on 13.06.25.
//

import Foundation
final class AuthService {
    private let networkService: NetworkService

    init(networkService: NetworkService = URLSessionNetworkService()) {
        self.networkService = networkService
    }

    func login(request: Login.LoginRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        networkService.request(AuthEndpoint.login(request).request) { (result: Result<Login.AuthResponse, Error>) in
            switch result {
            case .success(let response):
                KeychainManager.shared.save(token: response.jwt)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func register(request: Register.RegisterRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        networkService.request(AuthEndpoint.register(request).request) { (result: Result<Login.AuthResponse, Error>) in
            switch result {
            case .success(let response):
                KeychainManager.shared.save(token: response.jwt)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func sendEmail(request: SendEmail.SendEmailRequest, completion: @escaping (Result<SendEmail.VerificationIdResponse, Error>) -> Void) {
        networkService.request(AuthEndpoint.sendEmail(request).request, completion: completion)
    }

    func verifyOTP(request: OTPVerification.OTPVerifyRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        networkService.request(AuthEndpoint.otpVerify(request).request) { (result: Result<Login.AuthResponse, Error>) in
            switch result {
            case .success(let response):
                KeychainManager.shared.save(token: response.jwt)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }


    func resetPassword(request: ResetPassword.ResetPasswordRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        networkService.request(AuthEndpoint.resetPassword(request).request) { (result: Result<EmptyResponse, Error>) in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func me(completion: @escaping (Result<MeResponse, Error>) -> Void) {
        networkService.request(AuthEndpoint.me.request, completion: completion)
    }
   
    func logout() {
        KeychainManager.shared.deleteToken()
    }
    
    func isLoggedIn() -> Bool {
        return KeychainManager.shared.getToken() != nil
    }
}
