//
//  Endpoint.swift
//  LucaryShop
//
//  Created by User on 07.06.25.
//
import Foundation
enum AuthEndpoint {
    case login(Login.LoginRequest)
    case register(Register.RegisterRequest)
    case otpVerify(OTPVerification.OTPVerifyRequest)
    case sendEmail(SendEmail.SendEmailRequest)
    case resetPassword(ResetPassword.ResetPasswordRequest)
    case me

    var path: String {
        switch self {
        case .login: return "/auth/login"
        case .register: return "/auth/register"
        case .otpVerify: return "/auth/verify-otp"
        case .sendEmail: return "/auth/send-otp"
        case .resetPassword: return "/auth/change-password"
        case .me: return "/api/auth/me"
        }
    }

    var method: String {
        switch self {
        case .me:
            return "GET"
        default:
            return "POST"
        }
    }

    var headers: [String: String] {
        ["Content-Type": "application/json"]
    }

    var body: Data? {
        switch self {
        case .login(let request):
            return try? JSONEncoder().encode(request)
        case .register(let request):
            return try? JSONEncoder().encode(request)
        case .otpVerify(let request):
            return try? JSONEncoder().encode(request)
        case .sendEmail(let request):
            return try? JSONEncoder().encode(request)
        case .resetPassword(let request):
            return try? JSONEncoder().encode(request)
        case .me:
            return nil
        }
    }
    var requiresAuth: Bool {
        switch self {
        case .me, .resetPassword:
            return true
        default:
            return false
        }
    }

    var request: APIRequest {
        var allHeaders = headers

        if requiresAuth,
           let token = KeychainManager.shared.getToken() {
            allHeaders["Authorization"] = "Bearer \(token)"
        }

        return APIRequest(
            url: URL(string: "https://e-commerce-app-150649679863.europe-west1.run.app\(path)")!,
            method: method,
            headers: allHeaders,
            body: body
        )
    }

}
