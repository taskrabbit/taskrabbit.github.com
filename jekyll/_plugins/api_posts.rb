STDERR.puts 'Running to match api mdown files'

module Jekyll
  class Post
    # A new way of recognising posts.
    remove_const(:MATCHER)
    MATCHER = /^(\d+)-(.*)(\.[^.]+)$/
    attr_accessor :order

    # Spaceship is based on Post#order, date, slug
    #
    # Returns -1, 0, 1
    def <=>(other)
      cmp = other.order <=> self.order
      if 0 == cmp
       cmp = super
      end
      return cmp
    end

    # Processing the posts.
    def process(name)
      m, order, slug, ext = *name.match(MATCHER)
      self.date  = Time.now
      self.order = order
      self.slug  = slug
      self.ext   = ext
    rescue ArgumentError
      raise FatalException.new("Post #{name} does not have a order number.")
    end
  end
end