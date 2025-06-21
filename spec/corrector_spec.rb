# frozen_string_literal: true

require 'spec_helper'
require 'thai_keyboard_corrector'

TH_IN_EN = {
  'l;ylfu' => 'สวัสดี',
  'wmp' => 'ไทย',
  'iyd' => 'รัก',
  'fu' => 'ดี',
  'z,' => 'ผม',
  'z, iyd ' => 'ผม รัก '
}.freeze

EN_IN_TH = {
  'ฟหกด' => 'asdf',
  '้ำสสน' => 'hello',
  'ะำหะ' => 'test',
  'พีิั' => 'ruby',
  'ณ ฟท ธ้ฟร' => 'i am thai'
}.freeze

RSpec.describe ThaiKeyboardCorrector do
  describe '#correct – Thai typed on EN layout' do
    TH_IN_EN.each do |wrong, right|
      it %(converts "#{wrong}" → "#{right}") do
        expect(described_class.correct(wrong)).to eq(right)
      end
    end
  end

  describe '#correct – English typed on TH layout' do
    EN_IN_TH.each do |wrong, right|
      it %(converts "#{wrong}" → "#{right}") do
        expect(described_class.correct(wrong)).to eq(right)
      end
    end
  end

  describe '#detect_layout' do
    it 'flags thai_in_en cases' do
      TH_IN_EN.each_key do |sample|
        expect(described_class.detect_layout(sample)).to eq(:thai_in_en)
      end
    end

    it 'flags en_in_th cases' do
      EN_IN_TH.each_key do |sample|
        expect(described_class.detect_layout(sample)).to eq(:en_in_th)
      end
    end

    it 'flags pure-script cases' do
      expect(described_class.detect_layout('สวัสดี')).to eq(:en_in_th)
      expect(described_class.detect_layout('hello')).to eq(:thai_in_en)
    end

    it 'flags mixed and unknown cases' do
      expect(described_class.detect_layout('helloส')).to eq(:thai_in_en)
      expect(described_class.detect_layout('   ')).to eq(:unknown)
    end
  end
end
