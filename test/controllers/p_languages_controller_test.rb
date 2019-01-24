require 'test_helper'
require 'sidekiq/testing'

class PLanguagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @p_language = p_languages(:one)
    @csv_path = File.join Rails.root, 'db', 'languages.csv'
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

  ## Asynchronus testing
  test "should be able to queue the task for asynchronus task" do
    assert_equal 0, PLanguageAddWorker.jobs.size
    PLanguageAddWorker.perform_async(@csv_path)
    assert_equal 1, PLanguageAddWorker.jobs.size
    PLanguageAddWorker.perform_async(@csv_path)
    assert_equal 2, PLanguageAddWorker.jobs.size
  end

  test "after the execution of the AddWorker the database shall be filled" do
    #clear the database for further test
    PLanguage.delete_all
    assert PLanguage.first.nil?
    PLanguageAddWorker.perform_async(@csv_path)
    PLanguageAddWorker.drain
    assert_not PLanguage.first.nil?
    assert 0, PLanguageAddWorker.jobs.size

    #same task with inline 
    Sidekiq::Testing.inline! do
      PLanguage.delete_all
      assert PLanguage.first.nil?
      PLanguageAddWorker.perform_async(@csv_path)
      assert_not PLanguage.first.nil?
    end
  end

  test "after the execution of the RemoveWorker the database shall be empty" do
    Sidekiq::Testing.inline! do
      PLanguageAddWorker.perform_async(@csv_path)
      PLanguageRemoveWorker.perform_async
      assert PLanguage.first.nil?
    end
  end
end

