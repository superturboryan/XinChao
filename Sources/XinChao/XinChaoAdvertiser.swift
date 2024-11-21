//
//  XinChaoAdvertiser.swift
//  XinChao
//
//  Created by Ryan on 2024-11-21.
//

import Network
import SwiftUI

@MainActor
public class XinChaoAdvertiser: ObservableObject {
    
    private var listener: NWListener?
    private var connection: NWConnection?
    
    @Published public var messages: [String] = []
    
    @Published public var isAdvertising = false
    @Published public var isConnected = false
    
    public init() {}

    public func startAdvertising() {
        do {
            isAdvertising = true
            listener = try NWListener(using: .tcp, on: /*port*/ 12345)
            listener?.service = NWListener.Service(name: "MyAppService", type: "_ssh._tcp")
            listener?.stateUpdateHandler = { state in
                print("Listener state changed: \(state)")
            }
            listener?.newConnectionHandler = { [weak self] connection in
                print("New connection established")
                
                connection.start(queue: .global())
                
                Task { @MainActor in
                    self?.isAdvertising = false
                    self?.isConnected = true
                    self?.connection = connection
                    self?.receiveMessages(on: connection)
                }
            }
            listener?.start(queue: .global())
            print("Service advertised as '_ssh._tcp'")
        } catch {
            print("Failed to start listener: \(error)")
        }
    }
    
    public func stopAdvertising() {
        listener?.cancel()
        listener = nil
    }

    private func receiveMessages(on connection: NWConnection) {
        
        connection.receive(
            minimumIncompleteLength: 1,
            maximumLength: 1024
        ) { [weak self] data, contentContext, isComplete, error in
            Task { @MainActor [weak self] in
                if
                    let data = data,
                    let message = String(data: data, encoding: .utf8)
                {
                    print("Received message: \(message)")
                    DispatchQueue.main.async {
                        self?.messages.append(message)
                    }
                }
                
                if isComplete {
                    print("Connection closed by client.")
                    self?.isConnected = false
                } else {
                    // Keep listening for more messages
                    self?.receiveMessages(on: connection)
                }
            }
        }
    }
}

