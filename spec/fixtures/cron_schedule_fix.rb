CronSchedule.fixture {{
  :day_of_week    => ['*', rand(7) + 1].pick,
  :month          => ['*', rand(12) + 1].pick,
  :day_of_month   => ['*', rand(31) + 1].pick,
  :hour           => ['*', rand(24) + 1].pick,
  :minute         => ['*', rand(60) + 1].pick,
  :content_item   => ContentItem.gen(:advertisement)
}}

given 'a cron schedule => @cron_schedule' do
  @cron_schedule = CronSchedule.gen
end