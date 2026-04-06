//
//  ChatTableAdapter.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

// MARK: - Chat Table Adapter
final class ChatTableAdapter: NSObject, UITableViewDataSource {

    // MARK: - Properties
    let viewModel: ChatViewModel

    // MARK: - Init
    init(viewModel: ChatViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    // MARK: - Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = viewModel.messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ChatMessageCell",
            for: indexPath
        ) as! ChatMessageCell
        cell.configure(with: message)
        return cell
    }
}
