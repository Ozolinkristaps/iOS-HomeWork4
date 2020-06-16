//
//  HomeViewController.swift
//  iOS-HomeWork4
//
//  Created by User on 07/06/2020.
//  Copyright © 2020 Kristaps Ozoliņš. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userCompanyLabel: UILabel!
    @IBOutlet weak var userBioLabel: UILabel!
    @IBOutlet weak var searchUserText: UITextField!
    
    var defaultUsername = "ioslekcijas"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        fetchRepoData()
        // Do any additional setup after loading the view.
    }
    

    func fetchData() {
        let url = URL(string: "https://api.github.com/users/\(defaultUsername)")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("applications/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                if let gitHubUser = try? decoder.decode(GitHubUser.self, from: data) {
                    DispatchQueue.main.async {
                        self.updateUserInterface(with: gitHubUser)
                    }
                }
                else {
                    print(error?.localizedDescription ?? "")
                }
            }
            else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func fetchRepoData() {
        let url = URL(string: "https://api.github.com/repos/\(defaultUsername)/faili/contents/")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("applications/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                if let gitHubData = try? decoder.decode([GitHubData].self, from: data) {
                    DispatchQueue.main.async {
                        self.downloadRepoContents(with: gitHubData)
                    }
                }
                else {
                    print(error?.localizedDescription ?? "")
                }
            }
            else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func downloadRepoContents(with gitHubData: [GitHubData]){
    
            let files = gitHubData.count
    
            for file in 0...files - 1 {
                // Create destination URL
                let documentsUrl:URL =  (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL?)!
                let destinationFileUrl = documentsUrl.appendingPathComponent(gitHubData[file].name ?? "")
    
                //Create URL to the source file you want to download
                let fileURL = URL(string: gitHubData[file].downloadURL ?? "")
    
                let sessionConfig = URLSessionConfiguration.default
                let session = URLSession(configuration: sessionConfig)
    
                let request = URLRequest(url:fileURL!)
    
                let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
                   if let tempLocalUrl = tempLocalUrl, error == nil {
                       // Success
                       if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                           print("Successfully downloaded. Status code: \(statusCode)")
                       }
    
                       do {
                           try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                       } catch (let writeError) {
                           print("Error creating a file \(destinationFileUrl) : \(writeError)")
                       }
    
                   } else {
                    print("Error took place while downloading a file. Error description: %@", error?.localizedDescription ?? "Error happened while downloading file");
                   }
                }
                task.resume()
        }
    }
    
    
    

    @IBAction func searchUser(_ sender: Any) {
        defaultUsername = self.searchUserText.text!
        fetchData()
    }
    
    func updateUserInterface(with user: GitHubUser) {
        self.usernameLabel.text =  user.name
        self.userCompanyLabel.text = user.company
        self.userBioLabel.text = user.bio
        self.userImageView.downloaded(from: user.avatarURL ?? "")
    }
    /*			
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FileManager {
    class func documentsDir() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
}
