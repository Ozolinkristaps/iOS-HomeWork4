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
