require 'spec_helper'

describe Hash do
  let(:hash) do
    {
      :a => 1,
      :b => { :c => 2, :d => 3, :z => -1 },
      :e => {
        :f => { :g => 4, :h => 5 }
      },
      :i => [
        {:j => 6, :k => 7},
        {:j => 8, :k => 9}
      ],
      :d => nil
    }
  end

  it 'slices depth one keys' do
    expect(hash.deep_slice(:a)).to eq({:a => 1})
  end

  it 'slices depth two keys' do
    expect(hash.deep_slice(:b => :c)).to eq({:b => {:c => 2}})
  end

  it 'slices depth three keys' do
    expect(hash.deep_slice(:e => {:f => :g})).to eq({:e => {:f => {:g => 4}}})
  end

  it 'slices nil valued keys' do
    expect(hash.deep_slice(:d)).to eq({:d => nil})
  end

  it 'handles arrays of slice values' do
    expect(hash.deep_slice(:b => [:c, :z])).to eq({:b => {:c => 2, :z => -1}})
  end

  it 'slices values out of arrays' do
    expect(hash.deep_slice(:i => :j)).to eq({:i => [{:j => 6}, {:j => 8}]})
  end
end
