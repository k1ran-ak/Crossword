//
//  CUSTOMAPIPARAMS.swift
//  Scratchdemo
//
//  Created by Mac on 02/06/22.
//

import Foundation


struct API1Response: Codable {
    var gt: String
    var challenge: String
    var success: Int
    var new_captcha: Bool?
}

struct API2Response: Codable {
    var status: String
}
