require 'spec_helper'

class HasOneTest2 < Freyja::Base
  attributes :e
end

class HasOneTest1 < Freyja::Base
  attributes :a, :b
  has_one :c, HasOneTest2
end

describe Freyja::Base do

  describe 'without nils' do
    before :all do
      @source = {
        a: 1,
        b: :value,
        c: {
          d: 1,
          e: [2, 4],
        },
      }
      @translator = HasOneTest1.new(@source)
    end

    it 'should read only attributes from the list and associations' do
      result = @translator.as_json
      result.keys.should match_array [:a, :b, :c]
    end

    it 'should apply translators for associations' do
      result = @translator.as_json
      result.keys.should match_array [:a, :b, :c]
      result[:c].keys.should match_array [:e]
    end
  end

  describe 'with nils' do
    before :all do
      @source = {
        a: 1,
        b: nil,
        c: nil,
      }
      @translator = HasOneTest1.new(@source)
    end

    it 'should not assign nil association' do
      result = @translator.as_json
      result.keys.should match_array [:a, :b]
    end
  end

end