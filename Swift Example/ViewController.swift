//
//  ViewController.swift
//  Swift Example
//
//  Created by Jean-Pierre Gassin on 19/5/18.
//  Copyright © 2018 Jean-Pierre Gassin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    let screenSize = UIScreen.main.bounds;
    
    var xPos : CGFloat = 0
    var yPos : CGFloat = 50
    var dailyTasks: Array<Any> = [];
    
    @IBOutlet var taskTableView: UITableView!
    
    @IBAction func prepareTask(_ sender: UIButton) {
        let taskTextField = UITextField();
        
        taskTextField.frame = CGRect(
            x: xPos,
            y: yPos,
            width: screenSize.width,
            height: 30
        );
        
        taskTextField.addTarget(
            self,
            action: #selector(addTask),
            for: UIControlEvents.editingDidEnd
        );
        
        taskTextField.placeholder = "Add a task...";
        taskTextField.backgroundColor = UIColor.white;
        taskTextField.borderStyle = .none;
        taskTextField.layer.masksToBounds = false;
        taskTextField.layer.shadowColor = UIColor.gray.cgColor;
        taskTextField.layer.shadowOffset = CGSize(width: 0.0, height: 1.0);
        taskTextField.layer.shadowOpacity = 1.0;
        taskTextField.layer.shadowRadius = 0.0;
        taskTextField.textColor = UIColor.black;
        taskTextField.returnKeyType = .done;
        taskTextField.becomeFirstResponder();
        taskTextField.delegate = self;
        
        self.view.addSubview(taskTextField);
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        textField.removeFromSuperview();
        
        return true
    }
    
    @IBAction func addTask(_ sender: UITextField) {
        let taskName = sender.text;
        
        if !(taskName?.isEmpty)! {
            self.dailyTasks.append(taskName as Any);
            
            taskTableView.reloadData();
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyTasks.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        );
        
        cell.textLabel?.text = dailyTasks[indexPath.item] as? String;
        
        return cell;
    }
    
    @IBAction func changeBackground(_ sender: UIButton) {
        var newBackgroundColor = UIColor.black;
        var newTextColor = UIColor.white;
        var newButtonText = "Light Mode";
        
        if (view.backgroundColor === UIColor.black) {
            newBackgroundColor = UIColor.white;
            newTextColor = UIColor.black;
            newButtonText = "Dark Mode";
        }
        
        for view in self.view.subviews as [UIView] {
            if let label = view as? UILabel {
                label.textColor = newTextColor;
            }
            
            if let tableView = view as? UITableView {
                tableView.backgroundColor = newBackgroundColor;
            }
            
            if let cell = view as? UITableViewCell {
                cell.backgroundColor = newBackgroundColor;
            }
        }
        
        view.backgroundColor = newBackgroundColor;
        
        sender.setTitle(newButtonText, for: .normal);
        sender.sizeToFit();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        taskTableView.delegate = self;
        taskTableView.dataSource = self;
        taskTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

