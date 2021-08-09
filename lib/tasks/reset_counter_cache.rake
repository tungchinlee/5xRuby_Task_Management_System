namespace :db do
  desc 'Reset counter cache of tasks count in user'
  task update_tasks: :environment do
    print '開始更新任務數'
    User.all.each do |u|
      User.reset_counters(u.id, :tasks)
      print '.'
    end
    puts '更新完成！'
  end
end