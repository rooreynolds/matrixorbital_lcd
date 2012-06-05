require 'rubygems'
require 'sinatra'
require "sinatra/reloader"
require './MatrixOrbital.rb'
lcd = MatrixOrbital.new
lcd.clear

get '/' do
  "Hello! Try /lcd/hello, /lcd?text=hello, /lcd/light/on or /lcd/light/off"
end

get '/lcd/light/on' do
	lcd.backlight_on
	"light on"
end

get '/lcd/light/off' do
	lcd.backlight_off
	"light off"
end

def show_form(method, text) 
  return "<html><body><form name='input' action='#{method}' method='get'><input type='text' name='text'></form><p/>#{text}</body></html>"
end

get '/lcd/?:text?' do
  text = params[:text]
  lcd.clear
  lcd.print(text[0,80]) #truncate at 80 chars
  lcd.backlight_on(1)
  return show_form('/lcd', text)
end
