# More info at https://github.com/guard/guard#readme

guard 'rspec', :version => 2 do
  watch('spec/spec_helper.rb') { "spec" }
  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^lib/rubyonacid/(.+)\.rb}) { |m| "spec/#{m[1]}_spec.rb" }
end
