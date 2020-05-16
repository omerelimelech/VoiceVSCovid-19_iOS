//
//  PersonalDetailsPresenter.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 12/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation


class PersonalDetailsPresenter : BasePresenter {
    
    
    weak var delegate: PersonalDetailsDelegate?
    
    weak var userInfo: UserInfo?
    
    let model = PersonalDetailsModel()
    
    let group = DispatchGroup()
    
    let queue = SimultaneousOperationsQueue(numberOfSimultaneousActions: 1, dispatchQueueLabel: "AnyString")

    init(delegate: PersonalDetailsDelegate?, userInfo: UserInfo){
        self.delegate = delegate
        self.userInfo = userInfo
        super.init()
        queue.whenCompleteAll = { [weak self] in
            self?.delegate?.personalDetailsDoneSuccessfully()
        }
    }
    
    func registerUser(){
        guard let phone = userInfo?.phoneNumber else {/*delegate did fail */ return}
        let hashedPhone = MD5(string: phone)
        
        queue.run { (completeColusre) in
            self.model.registerUser(withPhoneNumber: hashedPhone.base64EncodedString()) { (result) in
                self.handleResult(result: result, type: UserModel.self) { (user) in
                    UserModel.shared = user ?? UserModel()
                    completeColusre()
                }
            }
        }
        guard let userValues = userInfo?.getAsParams() else { return }
        queue.run { completeClosure in
            self.model.sendUserInfo(params: userValues) { (result) in
                self.handleResult(result: result, type: UserInfo.self) { (userInfo) in
                    UserInfo.shared = userInfo ?? UserInfo()
                    completeClosure()
                }
            }
        }
        
        
        
        
    }
    
    
    
    
}



import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

func MD5(string: String) -> Data {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData
    }


import Foundation

class SimultaneousOperationsQueue {
    typealias CompleteClosure = ()->()

    private let dispatchQueue: DispatchQueue
    private lazy var tasksCompletionQueue = DispatchQueue.main
    private let semaphore: DispatchSemaphore
    var whenCompleteAll: (()->())?
    private lazy var numberOfPendingActionsSemaphore = DispatchSemaphore(value: 1)
    private lazy var _numberOfPendingActions = 0

    var numberOfPendingTasks: Int {
        get {
            numberOfPendingActionsSemaphore.wait()
            defer { numberOfPendingActionsSemaphore.signal() }
            return _numberOfPendingActions
        }
        set(value) {
            numberOfPendingActionsSemaphore.wait()
            defer { numberOfPendingActionsSemaphore.signal() }
            _numberOfPendingActions = value
        }
    }

    init(numberOfSimultaneousActions: Int, dispatchQueueLabel: String) {
        dispatchQueue = DispatchQueue(label: dispatchQueueLabel)
        semaphore = DispatchSemaphore(value: numberOfSimultaneousActions)
    }

    func run(closure: ((@escaping CompleteClosure) -> Void)?) {
        numberOfPendingTasks += 1
        dispatchQueue.async { [weak self] in
            guard   let self = self,
                    let closure = closure else { return }
            self.semaphore.wait()
            closure {
                defer { self.semaphore.signal() }
                self.numberOfPendingTasks -= 1
                if self.numberOfPendingTasks == 0, let closure = self.whenCompleteAll {
                    self.tasksCompletionQueue.async { closure() }
                }
            }
        }
    }

    func run(closure: (() -> Void)?) {
        numberOfPendingTasks += 1
        dispatchQueue.async { [weak self] in
            guard   let self = self,
                    let closure = closure else { return }
            self.semaphore.wait(); defer { self.semaphore.signal() }
            closure()
            self.numberOfPendingTasks -= 1
            if self.numberOfPendingTasks == 0, let closure = self.whenCompleteAll {
                self.tasksCompletionQueue.async { closure() }
            }
        }
    }
}
