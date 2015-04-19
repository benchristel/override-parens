gem 'minitest'
require 'minitest/autorun'
require_relative 'lib/override_parens'

class OuterClass
  include OverrideParens

  def self.parens(arg)
    "outer #{arg}"
  end

  class MiddleClass
    include OverrideParens

    def self.parens(arg)
      "middle class #{arg}"
    end

    class InnerClass
      include OverrideParens

      def self.parens(arg)
        "inner class #{arg}"
      end
    end
  end

  module NotImplemented
    include OverrideParens
  end
end

module OuterModule
  include OverrideParens

  def self.parens(arg)
    "outer module #{arg}"
  end

  module InnerModule
    include OverrideParens

    def self.parens(arg)
      "inner module #{arg}"
    end
  end

  module ClassInModule
    include OverrideParens

    def self.parens(arg)
      "class in module #{arg}"
    end
  end
end

class Shadowed
  include OverrideParens

  def self.parens(arg)
    "hidden by inner class"
  end
end

class TestParens < MiniTest::Test
  def test_overriding_parens_on_a_class
    assert_equal 'outer 1', OuterClass(1)
  end

  def test_overriding_parens_on_a_module
    assert_equal 'outer module 1', OuterModule(1)
  end

  def test_overriding_parens_on_an_inner_class
    assert_equal 'middle class 1', OuterClass::MiddleClass(1)
  end

  def test_overriding_parens_on_a_deeply_nested_class
    assert_equal 'inner class 1', OuterClass::MiddleClass::InnerClass(1)
  end

  def test_overriding_parens_on_a_nested_module
    assert_equal 'inner module 1', OuterModule::InnerModule(1)
  end

  def test_overriding_parens_on_a_class_in_a_module
    assert_equal 'class in module 1', OuterModule::ClassInModule(1)
  end

  class Shadowed
    include OverrideParens

    def self.parens(arg)
      "shadowed #{arg}"
    end
  end

  def test_namespace_local_classes_shadow_top_level_classes
    assert_equal 'shadowed 1', Shadowed(1)
  end

  def test_shadowed_classes_are_still_accessible_from_kernel
    assert_equal "hidden by inner class", Kernel::Shadowed(1)
  end

  def test_no_funny_business
    result = begin
      OuterClass.new.MiddleClass(1)
    rescue NoMethodError
      "raised"
    end

    assert_equal "raised", result
  end

  def test_exception_when_parens_is_not_implemented
    result = begin
      OuterClass::NotImplemented(1)
    rescue NotImplementedError => e
      e.message
    end

    assert result.include? 'OuterClass::NotImplemented'
  end
end
