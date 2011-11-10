namespace :db do
  describe "Fill database with sample data" do
    task :populate => :environment do
      Rake::Task['db:reset'].invoke
      User.create!(:name => "Example User",
                    :email => "example@railstutorial.org",
                    :password => "foobar",
                    :password_confirmation => "foobar"
                    )
      99.times do |n|
        User.create!(:name => Faker::Name.name,
                      :email => "example-#{n+1}@railstutorial.org",
                      :password => "foobar",
                      :password_confirmation => "foobar"
                    )
      end
    end
  end
end