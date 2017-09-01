//
//  TodoModel.swift
//  Todo
//
//  Created by yutaoma on 2017/8/31.
//  Copyright © 2017年 yutaoma. All rights reserved.

//  Model:存放数据，数据交换等功能

import UIKit

class Todomodel: NSObject {
    var id: String
    var image: String
    var title: String
    var date: Date
    
    init(id: String, image: String, title: String, date: Date){
        self.id = id
        self.image = image
        self.title = title
        self.date = date
    }
    
}
