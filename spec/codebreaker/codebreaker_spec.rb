require 'spec_helper'

module Codebreaker
  describe Game do
    let(:game) { Game.new }
    context "#new_game" do
    end
    context "#check_hint" do
      before do
        game.stub(:gets) { "1234\n" }
      end

      after do
        game.check_hint
      end

      it "send 'Enter code or 'hint':' message" do
        game.instance_variable_set(:@check_hint, 0)
        expect(game).to receive(:puts).with("Enter code or 'hint':")
      end

      it "send 'Enter code:' message" do
        game.instance_variable_set(:@check_hint, 1)
        expect(game).to receive(:puts).with("Enter code:")
      end

      it "check gets.chomp if @check_hint == 0" do
        game.instance_variable_set(:@check_hint, 0)
        game.check_hint
        code = game.instance_variable_get(:@user_code)
        expect(code).to eq("1234")
      end

      it "check gets.chomp if @check_hint == 1" do
        game.instance_variable_set(:@check_hint, 1)
        game.check_hint
        code = game.instance_variable_get(:@user_code)
        expect(code).to eq("1234")
      end

    end

    context "#output_hint" do
      before do
        game.stub(:gets).and_return("1234\n")
        game.stub(:hint).and_return("***1")
      end

      after do
        game.output_hint
      end

      it "send 'Enter code:' message" do
        game.instance_variable_set(:@user_code, 'hint')
        expect(game).to receive(:puts).with("Enter code:")
      end

      it "check gets.chomp if @user_code == 'hint'" do
        game.instance_variable_set(:@user_code, 'hint')
        game.output_hint
        code = game.instance_variable_get(:@user_code)
        expect(code).to eq("1234")
      end
      context "#generate_code" do
        it "check is generate array for length" do
          game.generate_code
          code = game.instance_variable_get(:@secret_code)
          expect(code.length).to eq(4)
        end

        it "check is generate array for 1-6 numbers" do
          100.times do
            game.generate_code
            code = game.instance_variable_get(:@secret_code)
            4.times do |i|
              expect(code[i].to_s).to match(/[1-6]/)
            end
          end
        end
      end

      context "#check_input_data" do
        it "send 'incorrect data' message" do
          # game.instance_variable_set(:@user_code, 1)
          # expect(game).to receive(:puts).with("incorrect data")
        end
      end

      context "#check_user_code" do
        before do
          game.instance_variable_set(:@user_code_array, [1,2,3,4])
        end

        it "check for win" do
          game.instance_variable_set(:@secret_code, [1,2,3,4])
          game.check_user_code
          win = game.instance_variable_get(:@win)
          expect(win).to eq(1)
        end

        it "output '+'" do
          game.instance_variable_set(:@secret_code, [1,5,5,5])
          game.check_user_code 
          expect(game.instance_variable_get(:@output)).to eq(['+'])
        end

        it "output '+-'" do
          game.instance_variable_set(:@secret_code, [1,5,2,5])
          game.check_user_code
          expect(game.instance_variable_get(:@output)).to eq(['+','-'])
        end

        it "output '-'" do
          game.instance_variable_set(:@secret_code, [2,5,5,5])
          game.check_user_code
          expect(game.instance_variable_get(:@output)).to eq(['-'])
        end
      end

      context "#check_for_lose" do
        after do
          game.check_for_lose
        end

        it "" do
          # game.instance_variable_set(:@attemps_count, 10)
          # game.instance_variable_set(:@attemps, 10)
          # expect(game).to receive(:puts).with("You lose! Secret code - ")
        end

        it "" do
          # game.instance_variable_set(:@attemps_count, 10)
          # game.instance_variable_set(:@attemps, 10)
          # expect(game).to receive(:puts).with("")
        end
      end

      context "#arr_to_s" do
        after do
          game.arr_to_s([1, 2, 3, 4])
        end

        it "output secret_code" do
          # expect(game).to receive(:print).with("1  2  3  4")
        end

        it "send '' message" do
          # expect(game).to receive(:puts).with("")
        end
      end

      context "#hint" do
        after do
          game.hint
        end

        it "" do
          game.stub(random) { 0 }
          code = game.instance_variable_set(:@secret_code, ['1', '2', '3', '4'])
          expect(game.hint).to eq(['1', '*', '*', '*'])
        end

        it "" do
          
        end

        it "" do
          
        end

        it "" do
          
        end
      end

      context "#game" do
        before do
          game.stub(:gets) { "1234\n" }
          game.stub(:new_game) { [1,2,3,4] }
          game.stub(:check_hint) { '1234' }
          game.stub(:output_hint) { ['1','*','*','*'] }
          game.stub(:check_input_data) { '' }
          game.stub(:user_code_to_a) { [1,2,3,4] }
          game.stub(:check_user_code) { [1,2,3,4] }
          game.stub(:hash_to_s) { [1,2,3,4] }
          game.stub(:saves_score) { [1,2,3,4] }
          game.stub(:check_for_lose) { [1,2,3,4] }
        end

        after do
          game.game
        end

        it "send 'Please enter your name' message" do
          expect(game).to receive(:puts).with("Please enter your name")
        end

        it "check gets.chomp" do
          game.game
          code = game.instance_variable_get(:@user_name)
          expect(code).to eq("1234")
        end

        it "" do
          game.instance_variable_set(:@user_code, '1234')
          code = game.instance_variable_get(:@user_code_array)
          expect(code).to eq("1234")
        end

        it "" do
          game.instance_variable_set(:@win, 1)
          expect(game).to receive(:puts).with('You win!')
        end

        it "" do
        end
      end
    end
  end  
end
