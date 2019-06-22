require 'rails_helper'

RSpec.describe LocalTime do
  describe 'self#current_date' do
    it 'returns the current date in America/New_York timezone' do
      now = double('now')
      local_time = double('in_time_zone')
      current_date = double('to_date')
      expect(LocalTime).to receive(:time_now).and_return now
      expect(now).to receive(:in_time_zone).with(LocalTime::TIME_ZONE).and_return local_time
      expect(local_time).to receive(:to_date).and_return current_date

      expect(LocalTime.current_date).to eq current_date
    end
  end
  describe 'self#end_of_current_month' do
    it 'returns the (localized) last day in the current month' do
      today = double('today')
      d = double('return')
      expect(LocalTime).to receive(:current_date).and_return today
      expect(today).to receive(:end_of_month).and_return d
      expect(LocalTime.end_of_current_month).to eq d
    end
  end
  describe 'self#nth_of_current_month' do
    it 'returns the (localized) nth day in the current month' do
      today = double('today')
      d = double('return')
      expect(LocalTime).to receive(:current_date).and_return today
      expect(today).to receive(:change).with(day: 15).and_return d
      expect(LocalTime.nth_of_current_month(15)).to eq d
    end
  end
  context 'private methods' do
    # symbolically private - don't call this method
    describe 'self#time_now' do
      it { expect(Time).to receive(:now); LocalTime.send(:time_now) } # calls Time.now
    end
  end
end
