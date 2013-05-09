require 'spec_helper'

class AttributesTest1 < Freyja::Base
  attributes :a, :b, :custom_attribute

  def custom_attribute
    source[:b].to_s
  end
end

class AttributesTest2 < Freyja::Base
end

describe Freyja::Base do

  describe 'with AttributesTest1' do

    before :all do
      @source = {
        'a' => 1,
        'b' => :value,
        'c' => '3',
        'd' => {
          e: 1,
        },
        f: 2,
      }
      @translator = AttributesTest1.new(@source)
    end

    it 'should read only attributes from the list' do
      result = @translator.as_json
      result.keys.should match_array [:a, :b, :custom_attribute]
    end

    it 'should call custom method' do
      result = @translator.as_json
      result[:custom_attribute].should eq 'value'
    end
  end

  describe 'with AttributesTest2' do
    before :all do
      @source = {
        a: 1,
        b: :value,
        c: '3',
      }
      @translator = AttributesTest2.new(@source)
    end

    it 'should return empty hash' do
      result = @translator.as_json
      result.keys.should eq []
    end
  end
end