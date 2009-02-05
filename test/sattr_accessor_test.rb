require File.dirname(__FILE__) + '/test_helper'

class SattrAccessorTest < Test::Unit::TestCase
  context "SingletonAttrExample1" do
    setup do
      @ob = SingletonAttrExample1.new
      SingletonAttrExample1.name = '1'
    end

    should "have name == '1' " do
      assert_equal @ob.name, '1'
    end

    context "with a SingletonAttrExample2" do
      setup do
        @ob2 = SingletonAttrExample2.new
        SingletonAttrExample2.name = '2'
      end

      should "have name == '2'" do
        assert_equal @ob2.name, '2'
      end

      context "instance changes name on SingletonAttrExample1 to '1prime' " do
        setup do
          @ob.name = '1prime'
        end

        context "SingletonAttrExample1" do
          should "have name == '1prime'" do
            assert_equal SingletonAttrExample1.name, '1prime'
          end
        end

        context "SingletonAttrExample1 instance" do
          should "have name == '1prime' " do
            assert_equal @ob.name, '1prime'
          end
        end

      end

      context "SingletonAttrExample1" do
        should "have name == '1' " do
          assert_equal SingletonAttrExample1.name, '1'
        end
      end

      context "SingletonAttrExample2 instance changes name" do
        setup do
          @ob2.name = '2prime'
        end

        context "SingletonAttrExample2 name" do
          should "== '2prime'" do
            assert_equal SingletonAttrExample2.name, '2prime'
          end
        end
      end


    end
  end
  
  context "Using [] attributes in a hierarchy" do
    setup do
      @ex1 = SingletonAttrExample1.new
      @ex2 = SingletonAttrExample2.new
      @ex3 = SingletonAttrExample3.new
      
      @ex1.name = [ '1' ]
      @ex2.name = [ '2' ]
      @ex3.name = [ '3' ]
    end
    
    context "@ex1.name" do
      should "have one entry" do
        puts @ex1.name.inspect
        assert_equal @ex1.name.size, 1
      end
      
      should "have a '1' entry in name" do
        assert_equal @ex1.name[0], '1'
      end
    end
    
    context "@ex2.name" do
      should "have 2 entries" do
        puts "\n@ex2.name.inspect #{@ex2.name.inspect}"
        puts "@ex2.name.size = #{@ex2.name.size}"
        puts "@ex2.name.size = #{@ex2.name.size}"
        puts "@ex2.name.size = #{@ex2.name.size}"
        puts "@ex2.name.size = #{@ex2.name.size}"
        puts "@ex2.name.size = #{@ex2.name.size}"
        assert @ex2.name.size == 2, "@ex2.name.size = #{@ex2.name.size}"
        assert @ex2.name.size == 2, "@ex2.name.size = #{@ex2.name.size}"
        assert @ex2.name.size == 2, "@ex2.name.size = #{@ex2.name.size}"
        assert @ex2.name.size == 2, "@ex2.name.size = #{@ex2.name.size}"
      end
      
      should "should contain '1'" do
        assert @ex2.name.any? { |v| v == '1' }
      end
    end
    
    context "@ex3.name" do
      should "have 3 entries" do
        puts "\n@ex3.name.inspect = #{@ex3.name.inspect}"
        puts "@ex3.name.size = #{@ex3.name.size}"
        assert_equal @ex3.name.size, 3
      end
    end
    

  end
  

end


class SingletonAttrExample1
  sattr_accessor :name, :inheritable => true
end

class SingletonAttrExample2 < SingletonAttrExample1
end

class SingletonAttrExample3 < SingletonAttrExample2
end