//
//  EventBus.swift
//
//
//  Created by Omer Elimelech on 6/9/16.
//  Copyright (c) 2016 Omer Elimelech. All rights reserved..
//

import Foundation

final class EventSubscription {
    
    fileprivate weak var listener : AnyObject?
    fileprivate let identifier : Int
    fileprivate var unsubscribeBlock : ((_ identifier : Int) -> ())?
    
    init(listener:AnyObject, identifier:Int, unsubscribeBlock: @escaping (_ identifier : Int)->()) {
        self.listener = listener
        self.identifier = identifier
        self.unsubscribeBlock = unsubscribeBlock
    }
    
    func unsubscribe() {
        self.unsubscribeBlock?(identifier)
        self.unsubscribeBlock = nil
        self.listener = nil
    }
}

final class EventBus {
    
    fileprivate var eventListeners : Dictionary<Int, AnyObject>
    
    init() {
        eventListeners = Dictionary<Int, AnyObject>()
    }
    
    
    func addEventListener(_ eventListener:AnyObject) -> EventSubscription{
        let identifier = self.generateSubscriberId()
        self.eventListeners[identifier] = eventListener
        
        let subscription = EventSubscription(listener: eventListener, identifier: identifier) { [weak self] (identifier : Int) in
            self?.eventListeners.removeValue(forKey: identifier)
        }
        
        return subscription
    }
    
    func notifyListeners<T>(_ notificationBlock : (_ listener : T) -> ()) {
        for listener in self.eventListeners.values {
            notificationBlock(listener as! T)
        }
    }


    fileprivate var idCounter = 0
    fileprivate func generateSubscriberId() -> Int {
        let identifier = self.idCounter
        self.idCounter += 1
        
        if self.idCounter >= Int.max - 1 {
           self.idCounter = 0
        }
        
        return identifier
    }
    
}
