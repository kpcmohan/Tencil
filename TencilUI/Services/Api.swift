//
//  Api.swift
//  TencilUI
//
//  Created by Manu Puthoor on 25/06/21.
//

import Foundation

class Api{
    
    func login(email : String, password : String, completion : @escaping (LoginModel) -> Void){
        guard let url = URL(string: "https://tencil-infra.co.uk/api/v1/login.php?method=json")else {return}
        
        let body : [String : String] = ["uid" : email, "pwd" : password]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request){ (data,response,error) in
            guard let dataObj = data else{completion(LoginModel(uid: "", fname: "", passwordMatches: false, userAPIKey: "", userActive: false)); return}
            guard let jsonData = try? JSONDecoder().decode(LoginModel.self, from: dataObj) else{completion(LoginModel(uid: "", fname: "", passwordMatches: false, userAPIKey: "", userActive: false)); return}
            completion(jsonData)
        }.resume()
        
        
    }
    func getMonth()->String {
        return ""
        let month = Calendar.current.dateComponents([.month], from: Date())
        if month.month ?? 0 > 11{
           return "\(month)"
       }
        return ""
    }
    func getBusiness(completion : @escaping (BusinessModel) -> Void) {
        
        guard let url = URL(string: "https://tencil-infra.co.uk/api/v1/tools/businesses.php?method=get&ft=true\(getMonth())")else {return}
        URLSession.shared.dataTask(with: url){ (data,response,error) in
            guard let dataObj = data else{return}
            guard let jsonData = try? JSONDecoder().decode(BusinessModel.self, from: dataObj)else {return}
            completion(jsonData)
        }.resume()
    }
    
    func getCategories(completion : @escaping (CategoriesModel) -> Void) {
        guard let url = URL(string: "https://tencil-infra.co.uk/api/v1/tools/cats.php?c=ALL")else {return}
        print(url)
        URLSession.shared.dataTask(with: url){ (data,response,error) in
            guard let dataObj = data else{return}
            guard let jsonData = try? JSONDecoder().decode(CategoriesModel.self, from: dataObj)else {return}
            completion(jsonData)
        }.resume()
    }
    
    func register(email : String, password : String,fullName : String, completion : @escaping (Int) -> Void){
        guard let url = URL(string: "https://tencil-infra.co.uk/api/v1/registration.php?method=json")else {return}
        
        let body : [String : String] = ["uid" : email, "pwd" : password,"fname" : fullName]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("a6lNFeTgMKth2xYKnlIC0o8cO8lubqcE", forHTTPHeaderField: "X-API-KEY")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request){ (data,response,error) in
            if let response = response as? HTTPURLResponse {
                        print("Content-Type: \(response.allHeaderFields["Content-Type"] ?? "")")
                        print("statusCode: \(response.statusCode)")
                completion(response.statusCode)
                    } else {
                        completion(404)
                    }
        }.resume()
        
    }
    
    func activate(email : String,code : String, completion : @escaping (Int) -> Void){
        guard let url = URL(string: "https://tencil-infra.co.uk/api/v1/tools/activate.php?method=json")else {return}
        
        let body : [String : String] = ["uid" : email, "code" : code]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request){ (data,response,error) in
            if let response = response as? HTTPURLResponse {
                        print("Content-Type: \(response.allHeaderFields["Content-Type"] ?? "")")
                        print("statusCode: \(response.statusCode)")
                completion(response.statusCode)
                    } else {
                        completion(404)
                    }
        }.resume()
        
    }
    
    func sendEmail(email : String, completion : @escaping (Int) -> Void){
        guard let url = URL(string: "https://tencil-infra.co.uk/api/v1/tools/pwreset.php?func=ir")else {return}
        
        let body : [String : String] = ["uid" : email]
        print(body)
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("a6lNFeTgMKth2xYKnlIC0o8cO8lubqcE", forHTTPHeaderField: "X-API-KEY")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request){ (data,response,error) in
            if let response = response as? HTTPURLResponse {
                        print("Content-Type: \(response.allHeaderFields["Content-Type"] ?? "")")
                        print("statusCode: \(response.statusCode)")
                completion(response.statusCode)
                    } else {
                        completion(404)
                    }
        }.resume()
        
    }

    func resetPassword(email : String,pwd : String, code : String, completion : @escaping (Int) -> Void){
        guard let url = URL(string: "https://tencil-infra.co.uk/api/v1/tools/pwreset.php?func=res")else {return}
        
        let body : [String : String] = ["uid" : email,"pwd" : pwd, "code" : code]
        print(body)
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("a6lNFeTgMKth2xYKnlIC0o8cO8lubqcE", forHTTPHeaderField: "X-API-KEY")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request){ (data,response,error) in
            if let response = response as? HTTPURLResponse {
                        print("Content-Type: \(response.allHeaderFields["Content-Type"] ?? "")")
                        print("statusCode: \(response.statusCode)")
                completion(response.statusCode)
                    } else {
                        completion(404)
                    }
        }.resume()
        
    }
    //
}
