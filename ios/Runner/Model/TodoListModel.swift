//
//  TodoListModel.swift
//  Runner
//
//  Created by Paulo Antonelli on 04/09/23.
//

import Foundation

struct TodoListModel {
    static var todoList: Array<String> = []
    
    static func addTodo(todo: String) -> Void {
        self.todoList.append(todo)
    }
    
    static func deleteTodo(todo: String) -> Void {
        self.todoList.removeAll { item in
            if item != todo {
                return false
            }
            return true
        }
    }
}
