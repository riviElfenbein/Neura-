//
//  ViewController.swift
//  NauraSample
//
//  Created by Rivi Elfenboim on 10/05/2017.
//  Copyright © 2017 Rivi Elfenboim. All rights reserved.
//

import UIKit
import NeuraSDK
import MBProgressHUD


class ViewController: UIViewController {
    
    var subscriptions = [String: NSubscription]()
    let neuraSdk = NeuraSDK.shared

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var SeeAppPerBtn: NeuraBtn!
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        if !neuraSdk.isAuthenticated() {
            login()
            
        } else {
            logout()
            
        }

    }
    
    func login(){
        MBProgressHUD.showAdded(to: view, animated: true)
        let authRequest = NeuraAuthenticationRequest(controller: self)
        neuraSdk.authenticate(with: authRequest) { result in
            if result.success {
                self.loginStateAmimate()
                self.subscribe()
            } else {
                DispatchQueue.main.async(execute: { () -> Void in
                    MBProgressHUD.hide(for: self.view, animated: true)
                })
            }
        }
        
    }
    
    func logout() {
        MBProgressHUD.showAdded(to: view, animated: true)
        neuraSdk.logout() { result in
            self.logoutStateAnimate()
        }
    }
    
    func loginStateAmimate(){
        DispatchQueue.main.async(execute: { () -> Void in
            MBProgressHUD.hide(for: self.view, animated: true)
            })
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                self.loginBtn.setTitle("Logout Neura", for: .normal)
                self.SeeAppPerBtn.alpha = 1.0
                
            }) { (finished) in
               
        }
    }
    
    func logoutStateAnimate(){
        DispatchQueue.main.async(execute: { () -> Void in
            MBProgressHUD.hide(for: self.view, animated: true)
        })
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.loginBtn.setTitle("Login Neura", for: .normal)
             self.SeeAppPerBtn.alpha = 0.0
            
        }) { (finished) in
            
        }
        
    }
    
    
    func subscribe(){
        let requestedSubscriptionsArray = ["userArrivedAtGroceryStore", "userArrivedToWork", "userLeftWork", "userArrivedAtPharmacy"]
        neuraSdk.getSubscriptionsList() { result in
            guard result.success else { return }
            
            for subscription in result.subscriptions {
                self.subscriptions[subscription.eventName] = subscription
            }
            
            for item in requestedSubscriptionsArray {
                self.subscribeToEvent(item)
            }
        }
        
    }
    
    
    func subscribeToEvent(_ eventName: String) {
        if self.subscriptions[eventName] == nil {
            let nSubscription = NSubscription.init(eventNamed: eventName)
            neuraSdk.add(nSubscription)  { result in
                if result.error != nil {
                    let alertController = UIAlertController(title: "Error", message: result.errorString, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
           
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if NeuraSDK.shared.isAuthenticated() {
            logoutStateAnimate()
            subscribe()
        } else {
            print("user is not login")
        }
        
    }

   
}

