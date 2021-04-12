require 'dotenv/load'
require 'pixela'
require './toggl'

date = Date.today - 1

toggl = Toggl.new(ENV['TOGGL_API_TOKEN'])
summary = toggl.summary('toggl_to_pixela', ENV['TOGGL_WORKSPACE_ID'], date, date)

exit if summary['total_grand'].nil?

minutes = summary['total_grand'] / 1000 / 60

client = Pixela::Client.new(username: ENV['PIXELA_USERNAME'], token: ENV['PIXELA_TOKEN'])
client.create_pixel(graph_id: 'task-durations', date: date, quantity: minutes)
