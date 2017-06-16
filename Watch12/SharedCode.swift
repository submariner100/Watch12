//
//  SharedCode.swift
//  Watch12
//
//  Created by Macbook on 16/06/2017.
//  Copyright © 2017 Chappy-App. All rights reserved.
//

import Foundation

func getDocumentsDirectory() -> URL {
     
     let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
     return paths[0]
  }
