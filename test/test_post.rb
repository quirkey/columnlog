require File.dirname(__FILE__) + '/test_helper.rb'

class TestPost < Test::Unit::TestCase

  context "Post" do
    context "creating a post" do
      context "with posted at as a string" do
        setup do
          @post = Post.new(:title => 'My Post', :body => 'My post body', :posted_at => '1 day ago')
        end

        should "convert posted at to time" do
          assert @post.posted_at.is_a?(Time)
        end

        should "save params" do
          assert @post.title
          assert_equal 'My Post', @post.title
        end

        should "return a post" do
          assert @post.is_a?(Post)
        end
      end

      context "with posted at as a time like string" do
        setup do
          @post = Post.new(:title => 'My Post', :body => 'My post body', :posted_at => Time.now.to_s)
        end

        should "convert posted at to time" do
          assert @post.posted_at.is_a?(Time)
        end
      end
      

      context "with a shortcut in the body" do
        setup do
          @post = Post.new(:body => '*tw tweeting my life away')
        end

        should "return a post" do
          assert @post.is_a?(Post)
        end

        should "load specific column into post" do
          assert_equal Column['twitter'], @post.column
        end
      end

      context "with a column specified by name" do
        setup do
          @post = Post.new(:body => 'tweeting my life away', :column => 'tumblr')
        end

        should "return a post" do
          assert @post.is_a?(Post)
        end

        should "load specific column into post" do
          assert_equal Column['tumblr'], @post.column
        end
      end
    end

  end

end