# More info at https://github.com/guard/guard#readme

guard 'test' do
  watch('test/test_helper.rb')  {"test"}
  watch(%r{(^test/.+_test\.rb$)}) {|m| m[1]}
  watch(%r{^app/models/(.+)\.rb$}) {|m| "test/unit/#{m[1]}_test.rb"}
  watch(%r{^app/views/(.+?)/[^/]+$}) { |m| "test/functional/#{m[1]}_controller_test.rb"}
  watch(%r{^app/controllers/(.+)\.rb$}) {|m| "test/functional/#{m[1]}_test.rb"}
  watch(%r{^app/mailers/(.+)\.rb$}) {|m| "test/functional/#{m[1]}_test.rb"}
  watch('app/controllers/application_controller.rb') {"test/functional"}
  watch(%r{^test/(fixtures|factories)/(.+)\.(yml|rb)$}) do |m|
    [
      "test/unit/#{m[2].chop}_test.rb",
      "test/functional/#{m[2]}_controller_test.rb",
    ]
  end
end
