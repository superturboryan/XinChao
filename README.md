# XinChào 🇻🇳👋

> “Xin chào” is a Vietnamese greeting that means “hello” in English. It's a polite way to say hello, and is often used when greeting the elderly or someone you admire.

**XinChào** is a minimal Swift Package enabling communication between iOS + macOS. It provides _simplified_
`SwiftUI`-friendly wrappers around NWListener + NWBrowser from Apple's [Network framework](https://developer.apple.com/documentation/network).
  
### TLDR 

Send messages between iOS + macOS devices running on the same Wifi. AKA [**`Bonjour`**](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/NetServices/Introduction.html#//apple_ref/doc/uid/10000119i) 🇫🇷🤝  

## Requirements

Add the following values to your targets' `info.plist`:

```
<key>NSBonjourServices</key>
<array>
    <string>YOUR BONJOUR SERVICE NAME HERE</string>
</array>
```

```
<key>NSLocalNetworkUsageDescription</key>
<string>The app needs to access devices on your local network to send messages.</string>
```

## Dependencies

📚 [Network](https://developer.apple.com/documentation/network)  

## Contributing

Contributions and feedback are welcome! 🧑‍💻👩‍💻  

Here are a few guidelines:

- You can [open an Issue](https://github.com/superturboryan/XinChao/issues/new) or raise a PR 🤝
- Commit messages should contain emojis ❤️ and be [signed](https://docs.github.com/en/authentication/managing-commit-signature-verification/signing-commits) 🔏
- `main` should be [linear](https://stackoverflow.com/questions/20348629/what-are-the-advantages-of-keeping-linear-history-in-git) 🎋 

