# frozen_string_literal: true

require './lib/toggl'

RSpec.describe Toggl do
  describe '#summary' do
    subject { described_class.new('token').summary('toggl_to_pixela', 'workspace_id', '2021-06-05', '2021-06-05') }

    before do
      stub_request(:get, %r{https://api.track.toggl.com/reports/api/v2/summary\?.*})
        .to_return(status: 200, body: File.read('spec/support/fixtures/toggl_summary_response.json'))
    end

    it { is_expected.to include('total_grand' => 7038000) }
  end
end
