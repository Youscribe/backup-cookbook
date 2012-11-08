actions :create, :disable, :remove

default_action :create

attribute :description, :kind_of => String, :default => nil
attribute :definition, :kind_of => String, :required => true
attribute :hour, :kind_of => String, :default => "1"
attribute :minute, :kind_of => String, :default => "*"
attribute :day, :kind_of => String, :default => "*"
attribute :month, :kind_of => String, :default => "*"
attribute :weekday, :kind_of => String, :default => "*"
attribute :mailto, :kind_of => String
attribute :user, :kind_of => String

# Covers 0.10.8 and earlier
def initialize(*args)
  super
  @action = :create
end
