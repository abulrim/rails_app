require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.create({
      first_name: 'Rami',
      last_name: 'Rizk',
      email: 'ramirizk90@example.com',
      password: '1234',
      password_confirmation: '1234'
    })
  end

  test "getting first name" do
    assert_equal @user.full_name, 'Rami Rizk'
  end

  test "setting first name" do
    @user.full_name = 'Teddy Zeenny'
    assert_equal @user.first_name, 'Teddy'
    assert_equal @user.last_name, 'Zeenny'
  end

  test "first name validation" do
    assert @user.valid?
    @user.first_name = nil
    assert @user.invalid?
    assert_equal @user.errors[:first_name].length, 1
    assert @user.errors[:first_name].include?("can't be blank")
  end

  test "last name validation" do
    assert @user.valid?
    @user.last_name = nil
    assert @user.invalid?
    assert_equal @user.errors[:last_name].length, 1
    assert @user.errors[:last_name].include?("can't be blank")
  end

  test "email validations" do
    assert @user.valid?
    @user.email = nil
    assert @user.invalid?
    assert_equal @user.errors[:email].length, 2
    assert @user.errors[:email].include?("can't be blank")
    assert @user.errors[:email].include?("is invalid")
    @user.email = 'invalidemail'
    assert @user.invalid?
    assert_equal @user.errors[:email].length, 1
    assert @user.errors[:email].include?("is invalid")
  end
end
