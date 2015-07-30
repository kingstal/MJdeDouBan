//
//  RAMHideTab.swift
//  MJdeDouBan
//
//  Created by WangMinjun on 15/7/28.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

import UIKit

extension RAMAnimatedTabBarController:UINavigationControllerDelegate{
    
    func hideTabBar(flag:Bool) {
        let atc = self
        let icons = atc.iconsView
        
        atc.tabBar.alpha = 0
        if (flag == true ) {
            
            for icon in icons {
                icon.icon.superview?.hidden = true
            }
            
        } else {
            let par = atc.tabBar.superview
            for icon in icons {
                if let sup = icon.icon.superview{
                    sup.hidden = false
                }
            }
        }
    }
}