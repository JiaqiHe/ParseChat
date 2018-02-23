//
//  ChatViewController.swift
//  parseChat
//
//  Created by Jiaqi He on 2/21/18.
//  Copyright © 2018 Jiaqi He. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBAction func OnSend(_ sender: Any) {
        sendMessage()
    }
    
    func sendMessage() {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = textField.text ?? ""
        chatMessage.saveInBackground { (success, error) in
            if success {
                self.textField.text = ""
                print("The message was saved!")
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTableView.dataSource = self
        messageTableView.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
