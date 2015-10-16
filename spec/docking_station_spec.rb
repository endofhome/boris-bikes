require 'docking_station'

describe DockingStation do

  describe 'initialization' do
    it 'has a default capacity' do
      expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
    end

    subject { DockingStation.new }
    let(:bike) { double(:bike) }
    it 'defaults capacity' do
      described_class::DEFAULT_CAPACITY.times do
        subject.dock(bike)
      end
      expect{ subject.dock(bike) }.to raise_error 'Already full'
    end
  end

  describe '#release_bike' do
    it { is_expected.to respond_to :release_bike }

    it 'releases working bikes' do
      bike = double(:bike, broken?: false)
      subject.dock bike
      expect(subject.release_bike).to be bike
    end

    it 'does not release broken bikes' do
      bike = double(:bike, broken?: true)
      subject.dock bike
      expect {subject.release_bike}.to raise_error 'cannot release a broken bike'
    end

    it 'raises error when there are no more bikes available' do
      expect {subject.release_bike}.to raise_error("No bikes available")
    end

  end

  describe '#dock' do
    let(:bike) { double(:bike) }

    it { is_expected.to respond_to(:dock).with(1) }

    it 'refuses to dock bike when already at capacity' do
      subject.capacity.times { subject.dock bike }
      expect { subject.dock bike }.to raise_error("Already full")
    end
  end

  describe '#release_broken_bike' do
    it { is_expected.to respond_to :release_broken_bike }

    it 'releases broken bikes' do
    bike = double(:bike, broken?: true)
    subject.dock bike
    expect(subject.release_broken_bike).to be bike
    end

  end

end

