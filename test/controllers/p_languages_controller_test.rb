require 'test_helper'

class PLanguagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @p_language = p_languages(:one)
  end

  test "should get index" do
    get p_languages_url
    assert_response :success
  end

  test "should get new" do
    get new_p_language_url
    assert_response :success
  end

  test "should create p_language" do
    assert_difference('PLanguage.count') do
      post p_languages_url, params: { p_language: { name: @p_language.name, wiki_link: @p_language.wiki_link } }
    end

    assert_redirected_to p_language_url(PLanguage.last)
  end

  test "should show p_language" do
    get p_language_url(@p_language)
    assert_response :success
  end

  test "should get edit" do
    get edit_p_language_url(@p_language)
    assert_response :success
  end

  test "should update p_language" do
    patch p_language_url(@p_language), params: { p_language: { name: @p_language.name, wiki_link: @p_language.wiki_link } }
    assert_redirected_to p_language_url(@p_language)
  end

  test "should destroy p_language" do
    assert_difference('PLanguage.count', -1) do
      delete p_language_url(@p_language)
    end

    assert_redirected_to p_languages_url
  end
end
