//
//  ProfileViewModel.swift
//  TencilUI
//
//  Created by Chandra Mohan on 22/10/21.
//

import Foundation
import SwiftUI
import Alamofire
class ProfileViewModel {
    @AppStorage("uid") var email : String?
    @AppStorage("userAPIKey") var userAPIKey : String?
    @AppStorage("profileImage") var profileImageData : Data?
    
    func profileImageUrl() -> URL{
        let userID = email

        let hashedUserID = userID?.md5()
        let gravatarURLString = "http://www.gravatar.com/avatar/\(hashedUserID ?? "")?d=identicon"
        let gravatarURL = URL(string: gravatarURLString)
        return gravatarURL!
    }
    func getProfilePicture(completion: @escaping(Bool) -> ()){
        var semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: "https://tencil-infra.co.uk/api/v1/tools/pfp.php?key=\(userAPIKey ?? "")&request=get")!,timeoutInterval: Double.infinity)
print(request)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard data != nil else {
                completion(false)
            semaphore.signal()
            return
          }
          //print(String(data: data, encoding: .utf8))
            let image = UIImage(data: data!)
            let jpegData = image?.jpegData(compressionQuality: 0.1)
            self.profileImageData = jpegData
          semaphore.signal()
            completion(true)
        }

        task.resume()
        semaphore.wait()
    }
}
