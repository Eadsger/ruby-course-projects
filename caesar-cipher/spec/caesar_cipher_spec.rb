# frozen_string_literal: true
require 'caesar_cipher'

describe '#caesar_cipher' do
  context 'with a shift factor of 5' do
    let(:shift_factor) { 5 }

    it 'encrypts a lowercase string' do
      input_string = 'hello'
      expect(caesar_cipher(input_string, shift_factor)).to eq('mjqqt')
    end

    it 'encrypts an uppercase string' do
      input_string = 'WORLD'
      expect(caesar_cipher(input_string, shift_factor)).to eq('BTWQI')
    end

    it 'ignores non-alphabetic characters' do
      input_string = 'Hello, World!'
      expect(caesar_cipher(input_string, shift_factor)).to eq('Mjqqt, Btwqi!')
    end
  end

  context 'with a shift factor of 0' do
    let(:shift_factor) { 0 }

    it 'returns the same string' do
      input_string = 'Testing 123'
      expect(caesar_cipher(input_string, shift_factor)).to eq('Testing 123')
    end
  end

  context 'with a negative shift factor' do
    let(:shift_factor) { -3 }

    it 'handles negative shifts' do
      input_string = 'xyz'
      expect(caesar_cipher(input_string, shift_factor)).to eq('uvw')
    end
  end

  context 'with a large shift factor' do
    let(:shift_factor) { 30 }

    it 'wraps around the alphabet' do
      input_string = 'abc'
      expect(caesar_cipher(input_string, shift_factor)).to eq('efg')
    end
  end
end
