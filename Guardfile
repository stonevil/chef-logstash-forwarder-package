scope group: :development

#notification :terminal_notifier, sticky: true
notification :tmux,
  display_message: true,
  timeout: 10,
  default_message_format: '%s >> %s',
  line_separator: ' > ',
  color_location: 'status-left-bg'

group :verify do
  guard 'kitchen' do
    watch(%r{test/.+})
    watch(%r{^recipes/(.+)\.rb$})
    watch(%r{^attributes/(.+)\.rb$})
    watch(%r{^files/(.+)})
    watch(%r{^templates/(.+)})
    watch(%r{^providers/(.+)\.rb})
    watch(%r{^resources/(.+)\.rb})
  end
end

group :development, :halt_on_fail => true do
  guard :foodcritic, :cookbook_paths => '.', :all_on_start => true, :cli => '--epic-fail any' do
    watch(%r{attributes/.+\.rb$})
    watch(%r{providers/.+\.rb$})
    watch(%r{recipes/.+\.rb$})
    watch(%r{resources/.+\.rb$})
    watch(%r{^templates/(.+)})
    watch('metadata.rb')
  end
  guard :rubocop, :all_on_start => true do # :cli => ['--lint']
    watch(%r{attributes/.+\.rb$})
    watch(%r{providers/.+\.rb$})
    watch(%r{recipes/.+\.rb$})
    watch(%r{resources/.+\.rb$})
    watch(%r{^templates/(.+)})
    watch('metadata.rb')
  end
  guard :rspec, :all_on_start => true do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
  end
end
