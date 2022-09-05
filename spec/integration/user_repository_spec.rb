require 'user_repository'

RSpec.describe UserRepository do

    def reset_users_table
        seed_sql = File.read('spec/seeds_users.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'bnb_test' })
        connection.exec(seed_sql)
    end

    describe "#all" do

    before(:each) do 
        reset_users_table
        end

        it "returns an array of all user details" do
            repo = UserRepository.new

            user = repo.all
            expect(user[0].email).to eq 'makers@hotmail.com'
            expect(user[0].username).to eq 'makers1'
        end
    end

    it "Creates an account" do
        repo = UserRepository.new
        new_user = User.new

        new_user.email = 'makers2@hotmail.com'
        new_user.username = 'Toby814'

        repo.create(new_user)
        results = repo.all

        expect(results[1].email).to eq 'makers2@hotmail.com'
        expect(results[1].username).to eq 'Toby814'
    end 

end 