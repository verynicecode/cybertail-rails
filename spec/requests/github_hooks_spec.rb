require 'rails_helper'

describe 'GitHub hooks' do
  it 'something' do
    github_service = Service.create name: 'GitHub'

    params = {
      repository: {
        full_name: 'jonallured/uplink-rails'
      }
    }

    headers = { 'X-GitHub-Event' => 'ping' }

    post '/github_hooks', params: params, headers: headers

    expect(Hook.count).to eq 1

    hook = Hook.first
    expect(hook.service).to eq github_service
    expect(hook.project).to eq "jonallured/uplink-rails"
    expect(hook.message).to eq "Got event ping, saved as Hook #{hook.id}."
    expect(hook.url).to eq "https://github.com"
  end

  context 'push event' do
    context 'with some commits' do
      it 'creates a GitHub push Hook' do
        github_service = Service.create name: 'GitHub'

        params = {
          commits: [ 'a', 'b' ],
          compare: "https://github.com/jonallured/uplink-rails/compare/sha1...sha2",
          pusher: { name: 'jonallured' },
          ref: 'refs/heads/master',
          repository: { full_name: 'jonallured/uplink-rails' }
        }

        headers = { 'X-GitHub-Event' => 'push' }

        post '/github_hooks', params: params, headers: headers

        expect(Hook.count).to eq 1

        hook = Hook.first
        expect(hook.service).to eq github_service
        expect(hook.project).to eq "jonallured/uplink-rails"
        expect(hook.message).to eq "jonallured pushed 2 commits to master"
        expect(hook.url).to eq "https://github.com/jonallured/uplink-rails/compare/sha1...sha2"
      end
    end
  end
end
