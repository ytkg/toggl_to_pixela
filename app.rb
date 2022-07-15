# frozen_string_literal: true

require 'dotenv/load'
require 'pixela'
require './lib/toggl'

module App
  module_function def run
    %w/TOGGL_API_TOKEN TOGGL_WORKSPACE_ID PIXELA_USERNAME PIXELA_TOKEN/.each do |environment_variable_name|
      raise "Missing required environment variable #{environment_variable_name}" if ENV[environment_variable_name].nil?
    end

    date = Date.today - 1

    toggl = Toggl.new(ENV['TOGGL_API_TOKEN'])
    summary = toggl.summary('toggl_to_pixela', ENV['TOGGL_WORKSPACE_ID'], date, date)

    exit if summary['total_grand'].nil?

    minutes = summary['total_grand'] / 1000 / 60

    client = Pixela::Client.new(username: ENV['PIXELA_USERNAME'], token: ENV['PIXELA_TOKEN'])
    client.create_pixel(graph_id: 'task-durations', date: date, quantity: minutes)
  end
end

App.run if __FILE__ == $PROGRAM_NAME
