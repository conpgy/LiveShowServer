//
//  Pipes.swift
//  LiveShowServer
//
//  Created by penggenyong on 2016/12/22.
//
//


precedencegroup LeftFunctionalApply {
    associativity: left
    higherThan: AssignmentPrecedence
    lowerThan: TernaryPrecedence
}

infix operator |> : LeftFunctionalApply

@discardableResult
func |> <A, B> (x:A, f: (A) throws -> B) rethrows -> B {
    return try f(x)
}
