//  Hud.swift
//  ISMP
//
//  Created by Sebastian Strus on 2018-04-12.
//  Copyright © 2018 OpenSolution. All rights reserved.
//

import Foundation
import UIKit

class Hud: NSObject {
    
    static func showOrUpdate(withText text: String?) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.showOrUpdateHUD(withText: text)
    }
    
    static func showOrUpdate(withText text: String?, andTime time: TimeInterval?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.showOrUpdateHUD(withText: text)
        if time != nil && time != 0 {
            appDelegate?.perform(#selector(appDelegate?.dismissHUD), with: nil, afterDelay: time!)
        }
    }
    
    static func showSuccess(withText text: String?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.showSuccess(withText: text)
        appDelegate?.perform(#selector(appDelegate?.dismissHUD), with: nil, afterDelay: 1.0)
    }
    
    static func showError(withText text: String?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.showError(withText: text)
        appDelegate?.perform(#selector(appDelegate?.dismissHUD), with: nil, afterDelay: 1.0)
    }
    
    static func dismiss() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.dismissHUD()
    }
    
    static func isHudVisible() -> Bool {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return (appDelegate?.isHudVisible) ?? false
    }
    
    
}
