    describe 'auto_emission_from_fuel' do
      it 'should return 0 for electricity' do
        auto_emission_from_fuel(:electricity, 0).should == 0
      end
      it 'should return 0 if no gasoline consumed' do
        auto_emission_from_fuel(:gasoline, 0).should == 0
      end
      it 'should return 127.4 for 2 litres of gas' do
        auto_emission_from_fuel(:gasoline, 2).should == 127.4
      end
      it 'should return 0 if no diesel consumed' do
        auto_emission_from_fuel(:diesel, 0).should == 0
      end
      it 'should return 98.2 for 2 litres of diesel' do
        auto_emission_from_fuel(:diesel, 2).should == 98.2
      end
    end

    def auto_emission_from_fuel(fuel_type, fuel_consumed)
      if fuel_type == :electricity
        0.0
      elsif fuel_type == :diesel
        fuel_consumed * 49.1
      else
        fuel_consumed * 63.7
      end
    end
