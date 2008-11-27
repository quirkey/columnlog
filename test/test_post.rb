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
    end
    
  end
  
end