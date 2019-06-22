require 'rails_helper'

RSpec.describe TempCluster, type: :model do
  describe '#cluster' do
    context 'when cluster_id is blank' do
      it 'attempts to create a new cluster, and returns it' do
        pending
      end
    end
    context 'when cluster_id is present' do
      it 'attempts to retrieve the cluster from droplet_kit' do
        pending
      end
    end
  end
  describe '#expired?' do
    let(:date) { double(:expiry_date) }
    let(:current_date) { double(:current) }
    it 'true' do
      expect(subject).to receive(:expiry_date).and_return date
      expect(date).to receive(:<=).with(current_date).and_return true
      expect(LocalTime).to receive(:current_date).and_return current_date
      expect(subject.expired?).to eq true
    end
    it 'false' do
      expect(subject).to receive(:expiry_date).and_return date
      expect(date).to receive(:<=).with(current_date).and_return false
      expect(LocalTime).to receive(:current_date).and_return current_date
      expect(subject.expired?).to be_falsey
    end
  end
  describe '#expiry_date' do
    let(:created) { double('created_date') }
    let(:d) { double('return') }
    it '' do
      expect(subject).to receive(:created_date).and_return created
      expect(created).to receive(:+).with(TempCluster::EXPIRY_DAYS.days)
        .and_return d
      expect(subject.expiry_date).to eq d
    end
  end
  describe '#created_date' do
    let(:created) { double('created_at') }
    let(:d) { double('return') }
    it 'converts created_at to a date' do
      expect(subject).to receive(:created_at).and_return created
      expect(created).to receive(:to_date).and_return d
      expect(subject.created_date).to eq d
    end
  end
end
