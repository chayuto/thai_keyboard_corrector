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
      return :unknown if clean.empty?

      thai_cnt, latin_cnt = char_stats(clean)
      return :unknown if thai_cnt.zero? && latin_cnt.zero?

      # ---------- pure-Latin ----------
      if thai_cnt.zero?
        # ▼ Treat 1-3-letter words as Thai-in-EN (they’re almost never real English)
        return :thai_in_en if clean.length <= 3 &&
                              hit_ratio(clean, Mapping::ENG_TO_THAI) >= FULL_HIT

        return :thai_in_en if clean.match?(/[^A-Za-z]/) &&
                              hit_ratio(clean, Mapping::ENG_TO_THAI) >= THRESHOLD

        return :en
      end

      # ---------- pure-Thai ----------
      if latin_cnt.zero?
        return :thai if clean.length < 4 # ignore tiny words like “ดี”

        eng = Mapping.map_thai_to_eng(clean)
        vowelish = eng.count(VOWELS).positive?
        if eng.match?(/\A[a-z]+\z/i) && vowelish &&
           hit_ratio(clean, Mapping::THAI_TO_ENG) >= THRESHOLD
          return :en_in_th
        end

        return :thai
      end

      # ---------- mixed ----------
      return :mixed if thai_cnt.positive? && latin_cnt.positive?
      return :thai_in_en if hit_ratio(clean, Mapping::ENG_TO_THAI) >= THRESHOLD
      return :en_in_th   if hit_ratio(clean, Mapping::THAI_TO_ENG) >= THRESHOLD

      :mixed
    end

    # helpers ----------------------------------------------------------------
    def char_stats(str)
      thai  = str.each_char.count { |c| THAI_RANGE.include?(c.ord) }
      latin = str.each_char.count { |c| c =~ /[A-Za-z]/ }
      [thai, latin]
    end
    private_class_method :char_stats

    def hit_ratio(str, table)
      hits = str.each_char.count { |c| table.key?(c) }
      hits.to_f / str.length
    end
    private_class_method :hit_ratio
  end
end
