module Octopussy
  class Repo
    attr_accessor :username, :name

    def initialize(repo)
      case repo
      when String
        repo = repo.split("/")
        @name = repo.pop
        @username = repo.pop
      when Repo
        @username = repo.username
        @name = repo.name
      when Hash
        @name = repo[:repo] ||= repo[:name]
        @username = repo[:username] ||= repo[:user] ||= repo[:owner]
      end
    end

    def slug
      "#{@username}/#{@name}"
    end

    def to_s
      self.slug
    end

    def url
      "http://github.com/#{slug}"
    end

    def user
      @username
    end

    def repo
      @name
    end

    def user=(val)
      @username = val
    end

    def self.from_url(url)
      return if url.nil?
      username, name = url.gsub("http://github.com/", "").split("/")
      Repo.new("#{username}/#{name}")
    end
  end
end
