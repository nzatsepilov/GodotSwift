//
//  main.swift
//  

import Foundation
import Godot
import CGodot.API

final class Godot {

    // Core API
    private let coreAPI: UnsafePointer<godot_gdnative_core_api_struct>
    private let coreAPI_1_1: UnsafePointer<godot_gdnative_core_1_1_api_struct>
    private let coreAPI_1_2: UnsafePointer<godot_gdnative_core_1_2_api_struct>

    // Nativescript API
    private let nativescriptAPI: UnsafePointer<godot_gdnative_ext_nativescript_api_struct>
    private let nativescriptAPI_1_1: UnsafePointer<godot_gdnative_ext_nativescript_1_1_api_struct>

    // Pluginscript API
    private let pluginscriptAPI: UnsafePointer<godot_gdnative_ext_pluginscript_api_struct>

    // Android API
    private let androidAPI: UnsafePointer<godot_gdnative_ext_android_api_struct>

    // AR/VR API
    private let arvrAPI: UnsafePointer<godot_gdnative_ext_arvr_api_struct>

    // Videodecoder API
    private let videodecoderAPI: UnsafePointer<godot_gdnative_ext_videodecoder_api_struct>

    // Net API
    private let netAPI: UnsafePointer<godot_gdnative_ext_net_api_struct>
    private let netAPI_3_2: UnsafePointer<godot_gdnative_ext_net_3_2_api_struct>

    // Native library
    private let nativeLibrary: UnsafeMutableRawPointer

    init(optionsPtr: UnsafeMutablePointer<godot_gdnative_init_options>) {
        // TODO
        // let options = optionsPtr.pointee
        // coreAPI = options.api_struct
        // nativeLibrary = options.gd_native_library
    }

    // private static func coreAPI(from options: UnsafeMutablePointer<godot_gdnative_init_options>) -> CoreAPI {
    //     guard let coreAPI = options.pointee.api_struct else {
    //         fatalError("Core API not found")
    //     }
    //     var coreAPI_1_1: UnsafePointer<godot_gdnative_core_1_1_api_struct>?
    //     var coreAPI_1_2: UnsafePointer<godot_gdnative_core_1_2_api_struct>?

    //     var ptr = coreAPI.pointee.next
    //     while let version = ptr?.pointee.version {
    //         switch (version.major, version.minor) {
    //         case (1, 1):
    //             coreAPI_1_1 = ptr!.binded(to: godot_gdnative_core_1_1_api_struct.self)
    //         case (1, 2):
    //             coreAPI_1_2 = ptr!.binded(to: godot_gdnative_core_1_2_api_struct.self)
    //         default:
    //             break
    //         }

    //         ptr = ptr?.pointee.next
    //     }
    // }
}

//@_silgen_name("godot_gdnative_init")
//func gdnativeInit(_ options: UnsafeMutablePointer<godot_gdnative_init_options>!) {
//
//}
//
//@_silgen_name("godot_gdnative_terminate")
//func gdnativeTerminate(_ options: UnsafeMutablePointer<godot_gdnative_terminate_options>!) {
//    print(#function)
//}
//
//@_silgen_name("godot_nativescript_init")
//func nativescriptInit(_ handle: OpaquePointer!) {
//    print(#function)
//}

extension UnsafePointer {

    func binded<T>(to type: T.Type) -> UnsafePointer<T> {
        UnsafeRawPointer(self).bindMemory(to: T.self, capacity: 1)
    }
}