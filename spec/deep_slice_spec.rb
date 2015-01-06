require 'spec_helper'

describe Hash do
  let(:hash) do
    {
      :a => 1,
      :b => { :c => 2, :d => 3, :z => -1 },
      :e => {
        :f => { :g => 4, :h => 5 }
      },
      :d => nil
    }
  end

  it 'slices depth one keys' do
    expect(hash.deep_slice(:a)).to eq({:a => 1})
  end

  it 'slices depth two keys' do
    expect(hash.deep_slice(:b => :c)).to eq({:b => {:c => 2}})
  end

  it 'slices depth thre keys' do
    expect(hash.deep_slice(:e => {:f => :g})).to eq({:e => {:f => {:g => 4}}})
  end

  it 'slices nil valued keys' do
    expect(hash.deep_slice(:d)).to eq({:d => nil})
  end

  it 'handles arrays of slice values' do
    expect(hash.deep_slice(:b => [:c, :z])).to eq({:b => {:c => 2, :z => -1}})
  end
end
