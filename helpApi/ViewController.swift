//
//  ViewController.swift
//  helpApi
//
//  Created by Admin on 29.01.2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

struct Param: Codable {
    let token: String
}

struct NotesParam: Codable {
    var data: Session?
}

struct Session: Codable {
    var session: String
}

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        get()
    }
    
    func get() {
        guard let url = URL(string: "https://bnet.i-partner.ru/testAPI/") else { return }
        
        let parametrs = "a=new_session".data(using: String.Encoding.ascii, allowLossyConversion: false) // false - не разрешаем конвертацию с потерями данных
        // тут короче мы кодируем наш параметр в Data чтобы потом засунуть его в httpBody запроса
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type") // это наш тип
        request.setValue("35YAo0C-gb-IhzDgei", forHTTPHeaderField: "token") // токен обязателен тоже
        request.httpBody = parametrs
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            print(data!)
            
            
            guard let data = data else { return }
            do {
                let d = try JSONDecoder().decode(NotesParam.self, from: data)
                print(d)
            } catch {
                print("мы в catch")
            }
        }.resume()
    }
    
    
    


}

