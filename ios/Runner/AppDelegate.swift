import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        let flutterViewController = window?.rootViewController as! FlutterViewController
        
        let flutterChannel = FlutterMethodChannel(name: channelName, binaryMessenger: flutterViewController.binaryMessenger)
        
        self.listenSetTodo(flutterMethodChannel: flutterChannel)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func listenSetTodo(flutterMethodChannel: FlutterMethodChannel) -> Void {
        flutterMethodChannel.setMethodCallHandler { (call, result) in            
            if call.method == methodSetName {
                TodoListModel.addTodo(todo: call.arguments as! String)
                self.getTodoList(flutterMethodChannel: flutterMethodChannel)
            }
            if call.method == methodDeleteName {
                TodoListModel.deleteTodo(todo: call.arguments as! String)
                self.getTodoList(flutterMethodChannel: flutterMethodChannel)
            }
            if call.method == methodGetName {
                self.getTodoList(flutterMethodChannel: flutterMethodChannel)
            }
        }
    }
    
    func getTodoList(flutterMethodChannel: FlutterMethodChannel) {
        flutterMethodChannel.invokeMethod(methodGetName, arguments: TodoListModel.todoList as Array<String>)
    }
}
