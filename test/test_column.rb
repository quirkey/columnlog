require File.dirname(__FILE__) + '/test_helper.rb'

class TestColumn < Test::Unit::TestCase

  context "Column" do
    context "[]" do
      context "with a string" do
        setup do
          @column = Column['twitter']
        end

        should "find column by name" do
          assert_equal Column.find(1), @column
        end

        should "return a Column" do
          assert @column.is_a?(Column)
        end
        
        should "load attributes for column" do
          assert_equal '*tw', @column.shortcut
        end
      end

      context "with an int" do
        setup do
          @column = Column[2]
        end

        should "find by id" do
          assert_equal Column.find(2), @column
        end

        should "return a Column" do
          assert @column.is_a?(Column)
        end
        
        should "load attributes for column" do
          assert_equal 'test', @column.settings.username
        end
        
      end

    end
    
    context "a Column" do
      setup do
        @column = Column['twitter']
      end
      
      should "return a settings as a superhash" do
        assert @column.settings
        assert @column.settings.is_a?(SuperHash)
        assert_equal 'test', @column.settings[:username]
      end
      
      should "load shortcut as a string" do
        assert_equal '*tw', @column.shortcut
      end
    end
  end
  
end