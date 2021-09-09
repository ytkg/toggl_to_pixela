# frozen_string_literal: true

require 'dotenv/load'
require 'pixela'
require './lib/toggl'

module App
  module_function def run
    date = Date.today - 1

    toggl = Toggl.new(ENV['TOGGL_API_TOKEN'])
    project_ids = ENV['TOGGL_PROJECT_IDS']
    summary = toggl.summary('toggl_to_pixela', ENV['TOGGL_WORKSPACE_ID'], date, date, project_ids)

    exit if summary['total_grand'].nil?

    minutes = summary['total_grand'] / 1000 / 60

    client = Pixela::Client.new(username: ENV['PIXELA_USERNAME'], token: ENV['PIXELA_TOKEN'])
    client.create_pixel(graph_id: 'task-durations', date: date, quantity: minutes)
  end
end

App.run if __FILE__ == $PROGRAM_NAME
