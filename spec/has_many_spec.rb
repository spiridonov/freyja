require 'spec_helper'

class HasManyTest2 < Freyja::Base
  attributes :e
end

class HasManyTest1 < Freyja::Base
  attributes :a, :b
  has_many :c, HasManyTest2
end

describe Freyja::Base do

  before :all do
    @source = {
      a: 1,
      b: [1, 2],
      c: [
        {
          d: 'sss',
          e: 1,
        },
        {
          d: 'sss',
          e: 2,
        },
        {
          d: 'sss',
          e: 3,
        },
      ],
    }
    @translator = HasManyTest1.new(@source)
  end

  it 'should read only attributes from the list and associations' do
    result = @translator.as_json
    result.keys.should match_array [:a, :b, :c]
  end

  it 'should apply translators for associations' do
    result = @translator.as_json
    result.keys.should match_array [:a, :b, :c]
    result[:c].should match_array [{e: 1}, {e: 2}, {e: 3}]
  end

end