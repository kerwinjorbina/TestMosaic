RSpec.describe Test do
  it "Test is procesing the incoming data" do
    incoming = [ {:date => 20090501, :width => 2},
             {:date => 20090501, :height => 7},
             {:date => 20090501, :depth => 3},
             {:date => 20090502, :width => 4},
             {:date => 20090502, :height => 6},
             {:date => 20090502, :depth => 2},
           ]
    outgoing = [ {:date => 20090501, :width => 2, :height => 7, :depth => 3},
             {:date => 20090502, :width => 4, :height => 6, :depth => 2},
           ]
    expect(Test.process(incoming, :date) == outgoing).to eql(true)
  end

  it "Test is procesing the incoming data with unsorted data" do
    incoming = [ {:date => 20090501, :width => 2},
             {:date => 20090501, :height => 7},
             {:date => 20090502, :height => 6},
             {:date => 20090502, :depth => 2},
             {:date => 20090501, :depth => 3},
             {:date => 20090502, :width => 4},
           ]
    outgoing = [ {:date => 20090501, :width => 2, :height => 7, :depth => 3},
             {:date => 20090502, :width => 4, :height => 6, :depth => 2},
           ]
    expect(Test.process(incoming, :date) == outgoing).to eql(true)
  end

  it "Test is procesing the incoming data with unsorted data and jumbled key-value pairs" do
    incoming = [ {:width => 2, :date => 20090501}, 
             {:height => 7, :date => 20090501},
             {:date => 20090502, :height => 6}, 
             {:depth => 2, :date => 20090502},
             {:depth => 3, :date => 20090501}, 
             {:date => 20090502, :width => 4},
           ]
    outgoing = [ {:date => 20090501, :width => 2, :height => 7, :depth => 3},
             {:date => 20090502, :width => 4, :height => 6, :depth => 2},
           ]
    expect(Test.process(incoming, :date) == outgoing).to eql(true)
  end

  it "Test with other data" do
    incoming = [ {:color => "red", :shape => "circle"},
             {:shape => "square", :color => "yellow"},
             {:color => "green", :size => 6},
             {:size => 5, :color => "red"},
             {:shape => "diamond", :color => "blue"},
             {:color => "yellow", :size => 3},
           ]
    outgoing = [ {:color => "blue", :shape => "diamond"},
             {:color => "green", :size => 6},
             {:color => "red", :shape => "circle", :size => 5},
             {:color => "yellow", :shape => "square", :size => 3}
           ]
    expect(Test.process(incoming, :color) == outgoing).to eql(true)
  end

  it "Test with other data with irregular hash lengths" do
    incoming = [ {:color => "red", :shape => "circle"},
             {:shape => "square", :color => "yellow", :"outline" => "solid"},
             {:color => "green", :size => 6, :shape => "rectangle"},
             {:size => 5, :color => "red"},
             {:shape => "diamond", :color => "blue"},
             {:color => "yellow", :size => 3},
           ]
    outgoing = [ {:color => "blue", :shape => "diamond"},
             {:color => "green", :shape => "rectangle", :size => 6},
             {:color => "red", :shape => "circle", :size => 5},
             {:color => "yellow", :shape => "square", :size => 3, :"outline" => "solid"}
           ]
    expect(Test.process(incoming, :color) == outgoing).to eql(true)
  end

  it "Test with other data with irregular hash lengths and different merge key" do
    incoming = [ {:color => "red", :shape => "circle"},
             {:color => "green", :size => 6, :shape => "rectangle"},
             {:area => 5, :shape => "rectangle"},
             {:shape => "circle", :area => 10, :"outline" => "solid"},
           ]
    outgoing = [ {:color => "red", :area => 10, :outline => "solid", :shape => "circle"},
             {:color => "green", :shape => "rectangle", :size => 6, :area => 5},
           ]
    expect(Test.process(incoming, :shape) == outgoing).to eql(true)
  end
end
