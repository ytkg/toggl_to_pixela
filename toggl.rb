require 'base64'
require 'faraday'
require 'json'

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
