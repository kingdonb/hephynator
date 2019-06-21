require 'rails_helper'

RSpec.describe Cloud::DigitalOcean do
  describe '#initialize' do
    it do
      c = Cloud::DigitalOcean.new
      binding.pry
    end
  end
end
