import 'package:flutter/material.dart';

/// App color palette designed for high dynamic range and vibrant mobile UI
class AppColors {
  AppColors._();

  // Primary Brand Colors (Kinetic Indigo/Electric Violet)
  static const Color primary = Color(0xFF6366F1); // Indigo
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF4F46E5);
  static const Color primaryContainer = Color(0xFFE0E7FF);

  // Secondary Accent Colors (Cyber Teal)
  static const Color secondary = Color(0xFF06B6D4); // Cyan
  static const Color secondaryLight = Color(0xFF22D3EE);
  static const Color secondaryDark = Color(0xFF0891B2);

  // Status & Utility Colors
  static const Color success = Color(0xFF10B981); // Emerald
  static const Color online = success; // Online status badge
  static const Color warning = Color(0xFFF59E0B); // Amber
  static const Color error = Color(0xFFEF4444); // Red
  static const Color info = Color(0xFF3B82F6); // Blue

  // Light Theme Surfaces
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF1F5F9);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF64748B);
  static const Color lightBorder = Color(0xFFE2E8F0);

  // Dark Theme Surfaces
  static const Color darkBackground = Color(0xFF0B0F19);
  static const Color darkSurface = Color(0xFF131B2E);
  static const Color darkSurfaceVariant = Color(0xFF1E293B);
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkBorder = Color(0xFF334155);

  // Chat Bubble Specific Colors
  static const Color myMessageLight = Color(0xFF6366F1);
  static const Color myMessageDark = Color(0xFF4F46E5);
  static const Color otherMessageLight = Color(0xFFF1F5F9);
  static const Color otherMessageDark = Color(0xFF1E293B);
}
