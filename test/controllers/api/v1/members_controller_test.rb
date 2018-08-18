require 'test_helper'

class Api::V1::MembersControllerTest < ActionDispatch::IntegrationTest

  test "member login for site" do

    post("/api/v1/members/login.json", params: { username: 'admin', password: 'admin'})
    assert_equal 200, status

    p json_response = JSON.parse(@response.body)
    # assert_equal json_response["user"], {"user_id"=>"58451d26599e3b0ff4c1ab82", "username"=>"admin"}
  end

  test "member register for site" do
    post("/api/v1/members/register.json", params: { username: 'admin1299', password: 'admin199', site_id: '58819fcc599e3b08b46990f1'})
    assert_equal 200, status
    json_response = JSON.parse(@response.body)
    assert_equal json_response, {"status"=>"ok", "mpp"=>""}
  end

  test "member logout for site" do
    get("/api/v1/members/logout.json")
    assert_equal 200, status
    p json_response = JSON.parse(@response.body)
  end


end
