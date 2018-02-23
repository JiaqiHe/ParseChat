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
    
    var messages : [PFObject] = []
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBAction func OnSend(_ sender: Any) {
        sendMessage()
    }
    
    func sendMessage() {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = textField.text ?? ""
        chatMessage["user"] = PFUser.current()
        chatMessage.saveInBackground { (success, error) in
            if success {
                self.textField.text = ""
                print("The message was saved!")
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    @objc func retrieveData() {
        let query = PFQuery(className: "Message")
        query.includeKey("user")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { (objects, error)  in
            if error == nil {
                if let objects = objects {
                    self.messages = objects
                }
            } else {
                print(error?.localizedDescription ?? "Error")
            }
        }
        self.messageTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTableView.dataSource = self
        messageTableView.delegate = self

        // Do any additional setup after loading the view.
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.retrieveData), userInfo: nil, repeats: true)
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 50
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messageTableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let message = messages[indexPath.row] as PFObject
        cell.chatMessageField.text = message["text"] as! String
        if let user = message["user"] as? PFUser {
            cell.usernameField.text = user.username
        } else {
            cell.usernameField.text = "Anonymous"
        }
        return cell
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
