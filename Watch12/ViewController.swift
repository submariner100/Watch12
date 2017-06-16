//
//  ViewController.swift
//  Watch12
//
//  Created by Macbook on 16/06/2017.
//  Copyright © 2017 Chappy-App. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {

     @IBOutlet var receivedData: UITextView!
     
     
     override func viewDidLoad() {
          super.viewDidLoad()
          
          let message = UIBarButtonItem(title: "Message", style: .plain, target: self, action: #selector(sendMessageTapped))
          let appInfor = UIBarButtonItem(title: "Context", style: .plain, target: self, action: #selector(sendAppContextTapped))
          let complication = UIBarButtonItem(title: "Complication", style: .plain, target: self, action: #selector(sendComplicationTapped))
          let file = UIBarButtonItem(title: "File", style: .plain, target: self, action: #selector(sendFileTapped))
          
          navigationItem.leftBarButtonItems = [message, appInfor, complication, file]
          
          if WCSession.isSupported() {
               
               let session = WCSession.default()
               session.delegate = self
               session.activate()
          }
          
          
     }

     override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
          // Dispose of any resources that can be recreated.
     }

     func sendMessageTapped() {
     
          let session = WCSession.default()
          
          
          
          
          
          
//          if session.activationState == .activated {
//               
//               let data = ["text": "User info from the iphone"]
//               
//               session.transferUserInfo(data)
//               
//          }

          if session.isReachable {
               
               let data = ["text": "A message from the phone"]
               
               session.sendMessage(data, replyHandler:{ response in
               
                    self.receivedData.text = "Received response \(response)"
               })
          }
     }
     
     func sendAppContextTapped() {
     
          let session = WCSession.default()
          
          if session.activationState == .activated {
               
               let data = ["text": "Hello from  the iPhone"]
               
               do {
                    try session.updateApplicationContext(data)
                    
               } catch {
                    
                    print("Alert! Updating app context failed")
                    
               }
          }
          
          
     }
     
     func sendComplicationTapped() {
          
          
          
          
          
     }
     
     func sendFileTapped() {
          
          let session = WCSession.default()
          
          if session.activationState == .activated {
               
               //create a URL from where the file is/will be saved
               let fm = FileManager.default
               let sourceURL = getDocumentsDirectory().appendingPathComponent("saved_file")
               
               if !fm.fileExists(atPath: sourceURL.path) {
               
                    //the file dos'nt exist - create it now
                    try? "Hello from a phone file!".write(to: sourceURL, atomically: true, encoding: String.Encoding.utf8)
               
          }
          
               //the file exists now; send it across the session
               
               session.transferFile(sourceURL, metadata: nil)
          
          }
    
     }
     
     func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
     
          DispatchQueue.main.async {
               
               if activationState == .activated {
                    
                    if session.isWatchAppInstalled {
                         
                         self.receivedData.text = "Watch application is installed!"
                    }
               }
          }
     }

     func sessionDidBecomeInactive(_ session: WCSession) {
          
          
     }
     
     func sessionDidDeactivate(_ session: WCSession) {
          
          WCSession.default().activate()
     }
     
     func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
          
          DispatchQueue.main.async {
               
               if let text = userInfo["text"] as? String {
                    self.receivedData.text = text
               }
          }
     }
}

