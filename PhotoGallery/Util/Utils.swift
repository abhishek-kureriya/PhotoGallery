//
//  Utils.swift
//  sixt
//
//  Created by Abhishek on 20/12/2017.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import Foundation

class Utils {
    
    /* return image url for single car
     * @params car model string type, car color string type
     * return URl string
     */
    func retrunImageUrl(model:String,color:String) -> String {
     return  imageViewLink+model+"/"+color+"/2x/car.png"
    }
    
}
