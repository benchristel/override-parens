module OverrideParens
  def self.included(base)
    namespace = base.name.split('::')[0...-1]
    unqualified_name = base.name.split('::')[-1]
    immediate_namespace = namespace.inject(Kernel) { |mod, const_name| mod.const_get const_name }

    immediate_namespace.class_eval do
      define_method(unqualified_name) do |*args, &block|
        base.parens(*args, &block)
      end

      define_singleton_method(unqualified_name) do |*args, &block|
        base.parens(*args, &block)
      end

      private unqualified_name
    end

    def base.parens(*args)
      raise NotImplementedError.new "To use OverrideParens, you must implement #{self.name}.parens, e.g.:" +
        %Q{
class #{self.name}
  def self.parens(*args)
    # ...
  end
end
}
    end
  end
end
