# frozen_string_literal: true

require 'thai_keyboard_corrector/version'
require 'thai_keyboard_corrector/mapping'
require 'thai_keyboard_corrector/detector'

# Main entry point
module ThaiKeyboardCorrector
  module_function

  # Corrects a string if it appears to be typed on the wrong layout.
  # @param str [String] input string
  # @return [String] corrected or original string
  def correct(str)
    case detect_layout(str)
    when :thai_in_en  # mostly Latin → convert EN→TH
      Mapping.map_eng_to_thai(str)
    when :en_in_th    # mostly Thai  → convert TH→EN
      Mapping.map_thai_to_eng(str)
    else              # :thai, :en, :mixed, :unknown
      str
    end
  end

  # Detects keyboard layout scenario for the given string.
  # @param str [String]
  # @return [Symbol] one of :thai_in_en, :en_in_th, :thai, :en, :mixed, :unknown
  def detect_layout(str)
    Detector.detect_layout(str)
  end
end
