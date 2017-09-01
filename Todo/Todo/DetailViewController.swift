//
//  DetailViewController.swift
//  Todo
//
//  Created by yutaoma on 2017/9/1.
//  Copyright © 2017年 yutaoma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var childButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var shoppingCartButton: UIButton!
    @IBOutlet weak var travelButton: UIButton!
    @IBOutlet weak var todoItem: UITextField!
    @IBOutlet weak var todoDate: UIDatePicker!
    
    var todo: Todomodel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if todo == nil {
            navigationItem.title = "new todo"
        }else {
            navigationItem.title = "edit todo"
            if todo?.image == "child-selected" {
                childButton.isSelected = true
            }else if todo?.image == "phone-selected" {
                phoneButton.isSelected = true
            }else if todo?.image == "shopping-cart-selected" {
                shoppingCartButton.isSelected = true
            }else if todo?.image == "travel-selected" {
                travelButton.isSelected = true
            }
            
            todoItem.text = todo?.title
            todoDate.setDate((todo?.date)!, animated: false)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //隐藏键盘
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        todoItem.resignFirstResponder()
    }
    @IBAction func closeKeyBoard(_ sender: Any) {
        todoItem.resignFirstResponder()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func resetButton() {
        childButton.isSelected = false   // bool 值，表示是否为选中状态
        phoneButton.isSelected = false
        shoppingCartButton.isSelected = false
        travelButton.isSelected = false
    }
    
    @IBAction func childTapped(_ sender: Any) {
        resetButton()
        childButton.isSelected = true
    }
    @IBAction func phoneTapped(_ sender: Any) {
        resetButton()
        phoneButton.isSelected = true
    }
    @IBAction func shoppingCartTapped(_ sender: Any) {
        resetButton()
        shoppingCartButton.isSelected = true
    }
    @IBAction func travelTapped(_ sender: Any) {
        resetButton()
        travelButton.isSelected = true
    }

    @IBAction func okTapped(_ sender: Any) {
        
        var image = ""
        
        if childButton.isSelected {
            image = "child-selected"
        }else if phoneButton.isSelected {
            image = "phone-selected"
        }else if shoppingCartButton.isSelected {
            image = "shopping-cart-selected"
        }else if travelButton.isSelected{
            image = "travel-selected"
        }
        
        if navigationItem.title == "new todo" {
            let uuid = NSUUID().uuidString
            var todo = Todomodel(id: uuid, image: image, title: todoItem.text!, date: todoDate.date)
            todos.append(todo)
        }else {
            todo?.image = image
            todo?.title = todoItem.text!
            todo?.date = todoDate.date
        }
        
        
    }
    
    
}
