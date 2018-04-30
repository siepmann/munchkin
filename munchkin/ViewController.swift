//
//  ViewController.swift
//  munchkin
//
//  Created by Guilherme Siepmann on 30/04/2018.
//  Copyright © 2018 Guilherme Siepmann. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier = "addUserCell"
    
    var userList: [UserModel] = Service.shared.listUsers()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addUser))
        
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .onDrag
        tableView.register(UINib(nibName: "PlayerInsertionTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        tableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }

    @objc func addUser() {
        userList.append(UserModel())
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath(row: userList.count - 1, section: 0)], with: .automatic)
        self.tableView.endUpdates()
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        (cell as! PlayerInsertionTableViewCell).setup(userList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Service.shared.deleteUser(userList[indexPath.row])
            self.userList.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
