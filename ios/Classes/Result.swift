//
//  Result.swift
//  native_oauth2
//
//  Created by Dylan Pfab on 2023/03/15.
//

import Foundation

enum Result<T, E : Error> {
    case ok(T)
    case err(E)
}
