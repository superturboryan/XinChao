//
//  XinChaoBrowser.swift
//  XinChao
//
//  Created by Ryan on 2024-11-21.
//

import Network
import SwiftUI

@MainActor
public class XinChaoBrowser: ObservableObject {
    
    private var browser: NWBrowser?
    private var connection: NWConnection?
    
    public init() {}

    public func startBrowsing() {
        let bonjourServiceName = "_ssh._tcp"
        browser = NWBrowser(for: .bonjour(type: bonjourServiceName, domain: nil), using: .tcp)
        browser?.stateUpdateHandler = { state in
            print("Browser state changed: \(state)")
        }
        browser?.browseResultsChangedHandler = { results, _  in
            for result in results {
                if case let .service(name, _, _, _) = result.endpoint {
                    print("Found service: \(name)")
                    if name == "MyAppService" {
                        Task { @MainActor in
                            self.connect(to: result)
                        }
                        break
                    }
                }
            }
        }

        browser?.start(queue: .main)
    }

    private func connect(to result: NWBrowser.Result) {
        connection = NWConnection(to: result.endpoint, using: .tcp)
        connection?.stateUpdateHandler = { state in
            print("Connection state changed: \(state)")
        }
        connection?.start(queue: .global())
        sendMessage("Hello from iOS!")
    }

    public func sendMessage(_ message: String) {
        guard let connection = connection else { return }
        let data = message.data(using: .utf8) ?? Data()
        connection.send(content: data, completion: .contentProcessed({ error in
            if let error = error {
                print("Send failed: \(error)")
            } else {
                print("Message sent")
            }
        }))
    }
}
