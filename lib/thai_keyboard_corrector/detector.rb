# frozen_string_literal: true

module ThaiKeyboardCorrector
  # This module detects the layout of a given string.
  module Detector
    THAI_RANGE = (0x0E00..0x0E7F).freeze
    THRESHOLD  = 0.7
    VOWELS     = 'aeiouy'
    FULL_HIT   = 1.0 - Float::EPSILON

    module_function

    # Returns :thai_in_en, :en_in_th, :thai, :en, :mixed, :unknown
    def detect_layout(str)
      clean = str.strip
      clean_no_ws = clean.gsub(/\s+/, '') # strip ALL whitespace

      return :unknown if clean_no_ws.empty?

      thai_cnt, latin_cnt = char_stats(clean) # char_stats already ignores ws

      # Majority-vote rule ----------------------------------------------
      return :en_in_th   if thai_cnt  > latin_cnt   # mostly Thai glyphs
      return :thai_in_en if latin_cnt > thai_cnt    # mostly Latin letters

      # If counts are equal (or zero) we can’t be sure
      thai_cnt.zero? && latin_cnt.zero? ? :unknown : :mixed
    end

    # helpers ----------------------------------------------------------------
    def char_stats(str)
      clean = str.gsub(/\s+/, '')
      thai  = clean.each_char.count { |c| THAI_RANGE.include?(c.ord) }
      latin = clean.each_char.count { |c| c.match?(/[A-Za-z]/) }
      [thai, latin]
    end
    private_class_method :char_stats
  end
end
