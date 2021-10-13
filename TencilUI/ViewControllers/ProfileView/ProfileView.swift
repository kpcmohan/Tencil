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
struct ProfileView: View {
    @AppStorage("uid") var email : String?
    @AppStorage("fname") var name : String?
    @AppStorage("userAPIKey") var userAPIKey : String?
    @State var imageData : Data?
    @State var fileContent = ""
    @State var showDocumentPicker = false
    @State var player = AVPlayer()
    @State var isUploadingVideo : Bool?
    @State var startLoading : Bool?
    @State var isShowingPopUp = false
    @State var isUploadSuccess = false
    
    var videoUrl: String = "https://tencil-infra.co.uk/api/v1/tools/streamer.php?request=get&key=0f14153cafb4dd717f4fd316463ddbce"
    var body: some View {
        ZStack {
            VStack{
                ZStack{
                    Color.profileBG
                        .ignoresSafeArea()
                    HStack{
                        ScrollView {
                            VStack(alignment : .center){
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .imageScale(.large)
                                    .foregroundColor(.blue)
                                    .shadow(radius: 10)
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .padding()
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
                                HStack{
                                    Button(action: {
                                        Common().dismissKeyboard()
                                    }, label: {
                                        Text("Update Details")
                                            .font(.subheadline)
                                            .foregroundColor(.white)
                                            .frame(width: 180, height: 30)
                                            .background(Color.buttonBGC)
                                            .cornerRadius(5)
                                            .padding()
                                        
                                    })
                                    
                                    Button(action: {}, label: {
                                        Image(systemName: "chevron.down")
                                            .renderingMode(.template)
                                        
                                            .frame(width: 40, height: 30, alignment: .center)
                                    })
                                        .background(Color.gray)
                                        .cornerRadius(5)
                                }
                                Divider()
                                
                                Button(action: {
                                    Common().dismissKeyboard()
                                }, label: {
                                    Text("Video CV")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .frame(width: 180, height: 30)
                                        .background(Color.buttonBGC)
                                        .cornerRadius(5)
                                        .padding()
                                    
                                })
                                
                                //  ScrollView(.horizontal, showsIndicators: true, content: {
                                HStack(alignment: .center){
                                    if isUploadSuccess {
                                        VStack{
                                            VideoPlayer(player: player)
                                                .onAppear() {
                                                    player = AVPlayer(url: URL(string: videoUrl)!)
                                                    player.play()
                                                }
                                        }
                                        .frame(width: 100, height: 130, alignment: .center)
                                        .cornerRadius(8)
                                    .padding(5)
                                    }
                                }
                                // })
                                
                                
                                Button(action: {
                                    Common().dismissKeyboard()
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
                        ImagePicker(sourceType: .photoLibrary, selectedVideoData: $imageData, isUploading: $isUploadingVideo)
                    }
            .navigationTitle(Text(name?.uppercased() ?? "-"))
        .navigationBarTitleDisplayMode(.inline)
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
                    Image.warning
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .center)
                        .foregroundColor(.white)
                    Text(isUploadSuccess ? String.uploadSuccess : String.uploadFailed)
                        .foregroundColor(.white)
                }
            }
            .frame(height: 80, alignment: .center)
            .cornerRadius(10)
            .padding()
            
        }
        
    }
    func checkUpload(){
        if isUploadingVideo ?? false{
            uploadVideo(videoData: imageData ?? Data())
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
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
