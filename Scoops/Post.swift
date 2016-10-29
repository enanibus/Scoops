//
//  Post.swift
//  Scoops
//
//  Created by Jacobo Enriquez Gabeiras on 24/10/16.
//  Copyright © 2016 enanibus. All rights reserved.
//

import Foundation

typealias PostRecord = Dictionary<String, AnyObject>

struct Post {
    
    let titulo: String
    let texto: String
    var foto: String?
    var latitud: Double?
    var longitud: Double?
    let autor: String
    var publicado: Bool
    var valoracion: Double = 0
    var numOfVals: Double = 0
    var paraPublicar: Bool
    var container: String?
    
}
