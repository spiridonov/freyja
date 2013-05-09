require 'spec_helper'

class IncludeTest1 < Freyja::Base
  attributes :a, :b, :c
  has_one :d

  def include_c?
    false
  end

  def include_d?
    false
  end
end

describe Freyja::Base do

  before :all do
    @source = {
      a: 1,
      b: :value,
      c: '3',
      d: {
        e: 1,
      },
      f: 2,
    }
    @translator = IncludeTest1.new(@source)
  end

  it 'should read only attributes from the list and check include? methods' do
    result = @translator.as_json
    result.keys.should match_array [:a, :b]
  end

end