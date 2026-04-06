//
//  ChatViewModelProtocol.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

@MainActor
protocol ChatViewModelInputProtocol: AnyObject {
    func sendMessage(text: String)
    func loadConversation() async
}

@MainActor
protocol ChatViewModelOutputProtocol: AnyObject {
    var messages: [Message] { get }
}

@MainActor
protocol ChatViewModelBindableProtocol: AnyObject {
    var onUpdate: (() -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
}

typealias ChatViewModelProtocol =
    ChatViewModelInputProtocol &
    ChatViewModelOutputProtocol &
    ChatViewModelBindableProtocol

