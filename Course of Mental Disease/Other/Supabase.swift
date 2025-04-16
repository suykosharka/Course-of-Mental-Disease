//
//  Supabase.swift
//  CourseOfMentalDisease
//
//  Created by Илья Паршин on 17.02.2025.
//

import Foundation
import Supabase

let supabase = SupabaseClient(
  supabaseURL: URL(string: "https://kxuegypepunzosqtehti.supabase.co")!,
  supabaseKey: "REMOVED"
)
let auth = supabase.auth
