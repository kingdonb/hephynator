require 'rails_helper'

RSpec.describe TempCluster, type: :model do
  describe '#tick' do
    before do
      allow(subject).to receive(:terminated?).and_return false
    end
    context 'a terminated cluster' do
      it 'does not get the expiry check' do
      expect(subject).to receive(:terminated?).and_return true
      expect(subject).to_not receive(:expired?)
      subject.tick
      end
    end
    context 'when cluster_id is present' do
      it 'checks the expiry date through #expired?' do
        expect(subject).to receive(:expired?)
        subject.tick
      end
      it 'actually tears the thing down when #expired? is true' do
        expect(subject).to receive(:expired?).and_return true
        expect(subject).to receive(:expire_cluster)
        subject.tick
      end
    end
  end
  describe '#cluster' do
    let(:subject) { FactoryBot.create(:temp_cluster, cluster_id: nil) }
    let(:cluster) { double('cluster') }
    context 'when cluster_id is blank' do
      it 'attempts to create a new cluster, and returns it' do
        expect(subject).to receive(:create_cluster).and_return cluster
        expect(subject.cluster).to eq cluster
      end
    end
    context 'when cluster_id is present' do
      let(:subject) { FactoryBot.create(:temp_cluster, cluster_id: 'abcde') }
      it 'attempts to retrieve the cluster details through droplet_kit' do
        expect(subject).to receive(:get_cluster).and_return cluster
        expect(subject.cluster).to eq cluster
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
    let(:subject) { FactoryBot.create(:temp_cluster) }
    it 'converts created_at to a date' do
      expect(subject.created_date).to be_kind_of Date
    end
  end
end
