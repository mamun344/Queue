//
//  main.swift
//  DSA Queue
//
//  Created by Mamun on 17/2/24.
//

import Foundation


func block(_ title: String, execution: ()->()){
    print("\n --- \(title) ---")
    execution()
}


protocol Queue {
    associatedtype Element
        
    mutating func enqueue(_ element: Element)
    
    mutating func dequeue()->Element?
    
    var isEmpty: Bool { get }
    
    var peek: Element? { get }
}


struct QueueArray<T>: Queue {
   private var array: [T] = []
    
    init(){ }
        
    var isEmpty: Bool {
        array.isEmpty
    }
    
    var peek: T? {
        array.first
    }
    
    mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    @discardableResult
    mutating func dequeue()->T? {
        isEmpty ? nil : array.removeFirst()
    }
}

extension QueueArray: CustomStringConvertible {
    var description: String {
        "Queue : " + array.map { "\($0)" }.joined(separator: " -> ")
    }
}


struct QueueStack<T>: Queue {
   private var leftStack: [T] = [] //actually an array
    private var rightStack: [T] = []//actually an array

    init(){ }
        
    var isEmpty: Bool {
        leftStack.isEmpty && rightStack.isEmpty
    }
    
    var peek: T? { 
        leftStack.isEmpty ? rightStack.first : leftStack.last
    }
    
    mutating func enqueue(_ element: T) {
        rightStack.append(element)
    }
    
    @discardableResult
    mutating func dequeue()->T? {
        if leftStack.isEmpty {
            leftStack = rightStack.reversed()
            rightStack.removeAll()
        }
        
        return leftStack.popLast()
    }
}

extension QueueStack: CustomStringConvertible {
    var description: String {
        "Queue : " + (leftStack.reversed() + rightStack).map { "\($0)" }.joined(separator: " -> ")
    }
}

block("With Array") {
    var queue = QueueArray<Int>()
    queue.enqueue(5)
    queue.enqueue(7)
    queue.enqueue(9)
    queue.enqueue(11)

    queue.dequeue()
//    queue.dequeue()

    print(queue.description)
    print(queue.peek)
}


block("With Stack") {
    var queue = QueueStack<Int>()
    queue.enqueue(5)
    queue.enqueue(7)
    queue.enqueue(9)
    queue.enqueue(11)

    queue.dequeue()
//    queue.dequeue()

    print(queue.description)
    print(queue.peek)
    
}



