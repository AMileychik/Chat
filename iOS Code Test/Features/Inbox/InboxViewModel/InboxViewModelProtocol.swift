//
//  InboxViewModelProtocol.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

@MainActor
protocol ViewModelInputProtocol: AnyObject {
    func load()
    func sendEvent(_ action: ViewModelEvent)
    func onAppear() 
}

@MainActor
protocol ViewModelOutputProtocol: AnyObject {
    func numberOfSections() -> Int
    func section(at index: Int) -> Conversation?
}

@MainActor
protocol ViewModelBindableProtocol: AnyObject {
    var onStateChanged: ((ViewModelState) -> Void)? { get set }
    var onEffect: ((ViewModelEffect) -> Void)? { get set }
}

typealias InboxViewModelProtocol =
    ViewModelInputProtocol &
    ViewModelOutputProtocol &
    ViewModelBindableProtocol
