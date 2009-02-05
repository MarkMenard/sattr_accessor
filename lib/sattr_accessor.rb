class Class
  
  def sattr_reader (sym, options = {})
    options = { :inheritable => false }.merge(options)
    class_eval(<<-EOS, __FILE__, __LINE__)
      def self.#{sym}
        @#{sym}
      end
      
      def #{sym}
        result = self.class.#{sym}
        #{
        "
        if result.is_a?(Array)
          # Get the value from our ancestor if there is one.
          if self.class.superclass.respond_to? :#{sym}
            result << self.class.superclass.#{sym} if self.class.superclass.#{sym}.is_a?(Array)
          end
          result.flatten!
        end
        if result.is_a?(Hash)
          # Get the value from our ancestor if there is one.
          if self.class.superclass.respond_to? :#{sym}
            result = self.class.superclass.#{sym}.merge(result) if self.class.superclass.#{sym}.is_a?(Hash)
          end
        end
        " if options[:inheritable] }
        result
      end
    EOS
  end
  
  def sattr_writer (sym)
    class_eval %Q{
      def self.#{sym}= (value)
        @#{sym} = value
      end
      
      def #{sym}= (value)
        self.class.#{sym} = value
      end
    }
  end
  
  def sattr_accessor (sym, options = {})
   sattr_reader(sym, options)
   sattr_writer(sym)
 end

end
