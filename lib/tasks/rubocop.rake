desc 'Run RuboCop on the codebase'
task rubocop: :environment do
  sh 'bundle exec rubocop'
end
