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
        
        if (flag == true ) {
            
            for icon in icons {
                icon.icon.superview?.hidden = true
            }
            atc.tabBar.hidden = true
            
        } else {
            atc.tabBar.hidden = false
            for icon in icons {
                if let sup = icon.icon.superview{
                    sup.hidden = false
                    sup.superview?.bringSubviewToFront(sup)
                }
            }
        }
    }
    
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool){
        hideTabBar(viewController.hidesBottomBarWhenPushed)
    }
}