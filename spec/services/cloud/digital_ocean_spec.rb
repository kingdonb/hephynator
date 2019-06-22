require 'rails_helper'

RSpec.describe Cloud::DigitalOcean do
  describe '#initialize' do
    before do
      @c = Cloud::DigitalOcean.new
    end
    it 'instantiates from the new method' do
      expect(@c).to be_kind_of(Cloud::DigitalOcean)
    end
    it 'exposes the droplet_kit client' do
      expect(@c.client).to be_kind_of(DropletKit::Client)
    end
  end
end
