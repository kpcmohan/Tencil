//
//  ProfileView.swift
//  TencilUI
//
//  Created by Chandra Mohan on 18/07/21.
//

import SwiftUI
import CryptoSwift
import Foundation
import AVKit
import URLImage
import Alamofire
import Photos
struct ProfileView: View {
    @AppStorage("uid") var email : String?
    @AppStorage("fname") var name : String?
    @AppStorage("userAPIKey") var userAPIKey : String?
    @AppStorage("profileImage") var profileImageData : Data?
    @State var imageData : Data?
    @State var image : UIImage?
    @State var fileContent = ""
    @State var showDocumentPicker = false
    @State var player = AVPlayer()
    @State var isUploadingVideo : Bool?
    @State var startLoading : Bool?
    @State var isShowingPopUp = false
    @State var isUploadSuccess = false
    @State var profileImage:UIImage = UIImage()
    @State var profileUploadRequest = false
    @Environment(\.openURL) var openURL
    var body: some View {
        ZStack {
            VStack{
                ZStack{
                    HStack{
                        ScrollView {
                            VStack(alignment : .center){
                                Image(uiImage: profileImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .clipShape(Circle())
                                    .shadow(radius: 10)
                                    .overlay(Circle().stroke(Color.white, lineWidth: 1))
                                    .padding()
                                
                                    .onAppear {
                                        ProfileViewModel().getProfilePicture { Status in
                                            self.profileImage = UIImage(data: profileImageData ?? Data()) ?? UIImage()
                                            
                                        }
                                    }
                                
                                Button {
                                   
                                    checkPermission()
                                    //                                    openURL(URL(string: String.gravatarURL)!)
                                } label: {
                                    Text("Change profile picture")
                                        .foregroundColor(.blue)
                                        .padding([.horizontal])
                                        .font(.system(size: 15,weight: .light))
                                    
                                }
                                
                                Text(email ?? "-")
                                    .foregroundColor(.buttonBGC)
                                    .padding([.horizontal])
                                    .padding([.top],20)
                                HStack(alignment: .center, spacing: nil, content: {
                                    Image.checkMark
                                        .resizable()
                                        .renderingMode(.original)
                                        .frame(width: 12, height: 12, alignment: .center)
                                        .scaledToFit()
                                    Text("Verified account")
                                        .font(.system(size: 12,weight: .light))
                                        .foregroundColor(.buttonBGC)
                                    
                                })
                                //                                HStack{
                                //                                    Button(action: {
                                //                                        Common().dismissKeyboard()
                                //                                    }, label: {
                                //                                        Text("Update Details")
                                //                                            .font(.subheadline)
                                //                                            .foregroundColor(.white)
                                //                                            .frame(width: 180, height: 30)
                                //                                            .background(Color.buttonBGC)
                                //                                            .cornerRadius(5)
                                //                                            .padding()
                                //
                                //                                    })
                                //                                }
                                Divider()
                                Text("Video CV")
                                    .font(.subheadline)
                                    .foregroundColor(Color.buttonBGC)
                                Divider()
                                HStack(alignment: .center){
                                    if isUploadSuccess {
                                        VStack{
                                            VideoPlayer(player: player)
                                                .onAppear() {
                                                    let  videoUrl =  "https://tencil-infra.co.uk/api/v1/tools/streamer.php?request=get&key=\(userAPIKey ?? "")"
                                                    player = AVPlayer(url: URL(string: videoUrl)!)
                                                    player.play()
                                                }
                                        }
                                        .frame(width: 100, height: 130, alignment: .center)
                                        .cornerRadius(8)
                                        .padding(5)
                                    }
                                }
                                Button(action: {
                                    Common().dismissKeyboard()
                                    profileUploadRequest = false
                                    showDocumentPicker = true
                                }, label: {
                                    Text("Upload New Video")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .frame(width: 180, height: 30)
                                        .background(Color.red)
                                        .cornerRadius(5)
                                        .padding()
                                    
                                })
                            }
                            .foregroundColor(.white)
                        }
                        
                    }
                }
                Spacer()
            }
            
            .sheet(isPresented: self.$showDocumentPicker, onDismiss: checkUpload) {
                ImagePicker(image: profileUploadRequest, selectedImage: $image, sourceType: .photoLibrary, selectedVideoData: $imageData, isUploading: $isUploadingVideo)
            }
            //.navigationTitle(Text(name?.uppercased() ?? "-"))
            // .navigationBarTitleDisplayMode(.inline)
            if isUploadingVideo ?? false{
                LoaderView()
            }
        }
        
        .popup(isPresented: $isShowingPopUp, type: .floater(verticalPadding: 20), position: .top, animation: .easeIn, autohideIn: 3, dragToDismiss: true, closeOnTap: true, closeOnTapOutside: false) {
            isShowingPopUp = false
        } view: {
            ZStack{
                Color.primary
                HStack{
                    Image.checkMark
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .center)
                        .foregroundColor(.white)
                    if profileUploadRequest{
                        Text(isUploadSuccess ? String.imageUploadSuccess : String.imageUploadFailed)
                            .foregroundColor(.white)
                    }
                    else{
                        Text(isUploadSuccess ? String.uploadSuccess : String.uploadFailed)
                            .foregroundColor(.white)
                    }
                    
                }
            }
            .frame(height: 80, alignment: .center)
            .cornerRadius(10)
            .padding()
            
        }
        
    }
    func checkUpload(){
        if profileUploadRequest{
            if (image != nil){
                deleteProfilePic { status in
                    uploadProfilePic(videoData: image!) { result in
                        // ProfileViewModel().getProfilePicture { data in
                        
                        //  }
                    }
                }
            }
        }
        else{
            if isUploadingVideo ?? false{
                uploadVideo(videoData: imageData ?? Data())
            }
        }
    }
    func deleteProfilePic(completion : @escaping (Bool)->()){
        
        let url = "https://tencil-infra.co.uk/api/v1/tools/pfp.php?request=delete&key=\(userAPIKey ?? "")"
        AF.request(url, method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                debugPrint(response)
                completion(true)
            }
    }
    func uploadProfilePic(videoData : UIImage, completion:@escaping (Bool)->()){
        
        
        let newImageSize = image!.jpegData(compressionQuality: 0.1)
        profileImage = videoData
        let parameters = newImageSize?.base64EncodedString()
        let postData = parameters?.data(using: .utf8)
        let headers = [
            "Content-Type": "image/jpeg",
            "Content-MD5" : "7de5af6f7ab5f71ddfac9a0ad08e2a02"
        ]
        
        // presignedUrl is a String
        
        AF.upload(newImageSize!, to: "https://tencil-infra.co.uk/api/v1/tools/pfp.php?request=upload&key=\(userAPIKey!)", method: .put, headers: HTTPHeaders.init(headers))
            .responseData {
                response in
                print(response)
                isUploadingVideo = false
                isUploadSuccess = true
                isShowingPopUp = true
                
                completion(false)
                
                guard let httpResponse = response.response else {
                    print("Something went wrong uploading")
                    return
                }
            }
    }
    func uploadVideo(videoData : Data){
        let url = "https://tencil-infra.co.uk/api/v1/tools/streamer.php?key=\(userAPIKey ?? "")&request=upload"
        
        let semaphore = DispatchSemaphore (value: 0)
        
        let parameters = videoData.base64EncodedString()
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.addValue(videoData.md5().toHexString() , forHTTPHeaderField: "Content-MD5")
        request.addValue("video/mp4", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "PUT"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                isUploadingVideo = false
                isUploadSuccess = false
                isShowingPopUp = true
                semaphore.signal()
                return
            }
            print(String(data: data, encoding: .utf8)!)
            print(response)
            isUploadingVideo = false
            isUploadSuccess = true
            isShowingPopUp = true
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
    }
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        
        return nil
    }
    func checkPermission(){
       // let photos = PHPhotoLibrary.authorizationStatus()
        //if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                switch status {
                   case .notDetermined:
                       print("The user hasn't determined this app's access.")
                   case .restricted:
                       print("The system restricted this app's access.")
                   case .denied:
                       print("The user explicitly denied this app's access.")
                   case .authorized:
                    profileUploadRequest = true
                    showDocumentPicker = true
                   case .limited:
                       print("The user authorized this app for limited Photos access.")
                   @unknown default:
                       fatalError()
                   }
//                if status == .authorized{
                    
//                } else {
//                    print("error:", status)
//                }
            })
      //  }
       // else{
         //   print("Raksha illa maaan:", PHPhotoLibrary.authorizationStatus())
        //}
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
