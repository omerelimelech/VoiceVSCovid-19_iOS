//
//  SMA.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 28/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation

public class LinkedListNode<T> {
  var value: T
  var next: LinkedListNode?
  weak var previous: LinkedListNode?

  public init(value: T) {
    self.value = value
  }
}


public class SMA {
    
    
    
    private var values = LinkedList<Double>()
    
    private var length = 0
    private var sum: Double = 0
    private var average: Double = 0
    
    init(length: Int) {
        if length <= 0 {return}
        self.length = length
    }
    
    public func currentAverage() -> Double {
        return average
    }
    
    public func compute(value: Double) -> Double {
        if values.count == length && length > 0 {
            sum -= Double(values.first!)
            values.remove(at: 0)
        }
        sum += value
        values.append(value)
        average = sum / Double(values.count)
        return average
    }
    
    
    
}
