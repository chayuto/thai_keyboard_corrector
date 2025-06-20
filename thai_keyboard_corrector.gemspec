# frozen_string_literal: true

require_relative 'lib/thai_keyboard_corrector/version'

Gem::Specification.new do |spec|
  spec.name          = 'thai_keyboard_corrector'
  spec.version       = ThaiKeyboardCorrector::VERSION
  spec.authors       = ['Chayut Orapinpatipat']
  spec.email         = ['chayut_o@hotmail.com']
  spec.required_ruby_version = '>= 2.7'

  spec.summary       = 'Corrects Thai text typed on the wrong keyboard layout (EN/TH) and vice versa.'
  spec.description   =
    'Detects and converts Thai text mistakenly typed on an English QWERTY ' \
    'layout (and vice versa) back to its intended form. Perfect for search ' \
    'bars, chat apps, and form inputs.'
  spec.homepage      = 'https://github.com/chayuto/thai_keyboard_corrector'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*', 'exe/*', 'README.md', 'LICENSE.txt']
  spec.require_paths = ['lib']

  spec.executables   = ['thai_kbd_correct']

  spec.add_development_dependency 'rspec'
end
