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

      context "shortcuts" do
        setup do
          @shortcuts = Column.shortcuts
        end

        should "collect all available shortcuts as a hash" do
          assert @shortcuts.is_a?(Hash)
          assert_equal Column.count, @shortcuts.length
        end

        should "have shortcuts as keys" do
          assert @shortcuts.keys.include?('*tw')
        end

        should "map to ids for values" do
          assert @shortcuts.values.include?(1)
        end
      end

      context "shortcut scan" do
        context "when the shortcut is the beginning of the text block" do
          setup do
            @column, @text_block = Column.shortcut_scan("*tw this is a tweet")
          end
          
          should "return an array of the column and the text without the shortcut" do
            assert @column.is_a?(Column)
            assert @text_block.is_a?(String)
            assert_equal 'this is a tweet', @text_block
          end
          
          should "return the correct column for the shortcut" do
            assert_equal Column['twitter'], @column
          end
        end
        
        context "when there are no shortcuts" do
          should "return nil" do
            assert_nil Column.shortcut_scan("who knows where this is going")
          end
        end
        context "when the shortcut is in the middle of the text" do
          should "return nil" do
            assert_nil Column.shortcut_scan("this could have been a tweet *tw if i was using this correctly")
          end
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