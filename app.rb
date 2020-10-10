require 'dotenv/load'
require 'base64'
require 'faraday'
require 'json'
require 'pixela'

class Toggl
  def initialize(token)
    @token = token
  end

  def summary(user_agent, workspace_id, since, _until)
    url = 'https://api.track.toggl.com/reports/api/v2/summary'
    params = {
      user_agent: user_agent,
      workspace_id: workspace_id,
      since: since,
      until: _until
    }
    headers = { 'Authorization' => "Basic #{Base64.encode64(@token + ':api_token')}" }
    res = Faraday.get(url, params, headers)
    JSON.parse(res.body)
  end
end

date = Date.today

toggl = Toggl.new(ENV['TOGGL_API_TOKEN'])
summary = toggl.summary('toggl_to_pixela', ENV['TOGGL_WORKSPACE_ID'], date, date)
minutes = summary['total_grand'] / 1000 / 60

client = Pixela::Client.new(username: ENV['PIXELA_USERNAME'], token: ENV['PIXELA_TOKEN'])
client.create_pixel(graph_id: 'task-durations', date: date, quantity: minutes)
