require './app'

RSpec.describe App do
  describe '.run' do
    let(:toggl) { Toggl.new('token') }
    let(:pixela_client) { Pixela::Client.new(username: 'username', token: 'token') }

    before do
      Timecop.freeze(Time.local(2021, 6, 6))

      toggl_mock = instance_double(Toggl)
      allow(Toggl).to receive(:new).and_return(toggl_mock)
      allow(toggl_mock).to receive(:summary).and_return({ 'total_grand' => 7038000 })

      pixela_client_mock = instance_double(Pixela::Client)
      allow(Pixela::Client).to receive(:new).and_return(pixela_client_mock)
      allow(pixela_client_mock).to receive(:create_pixel)
    end

    after do
      Timecop.return
    end

    subject { App.run }

    it do
      subject
      expect(toggl).to have_received(:summary).with('toggl_to_pixela', '4489930', Date.parse('2021-06-05'), Date.parse('2021-06-05')).once
      expect(pixela_client).to have_received(:create_pixel).with(date: Date.parse('2021-06-05'), graph_id: 'task-durations', quantity: 117).once
    end
  end
end
