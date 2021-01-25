desc "Operate Chess Game"

namespace :game do
  task run: "environment" do
    GameJob.perform_now
  end

  task test: "environment" do
    puts Game.last
  end
end

