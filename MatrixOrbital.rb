require 'rubygems'
require 'serialport'

class MatrixOrbital 

  def initialize(port_str = "/dev/tty.usbserial-00000038")
    @port_str = port_str
    baud_rate = 19200 # the rate that BlinkMCommunicator uses
    data_bits = 8
    stop_bits = 1
    parity = SerialPort::NONE
    @sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
    @sp.sync = true
  end

  def write(text)
    @sp.write(text)
    @sp.flush
  end

  def print(text)
    @sp.print(text)
    @sp.flush
  end

  def puts(text)
    @sp.puts(text)
    @sp.flush
  end

  def clear # clear the LCD
    @sp.putc(254)
    @sp.putc(88)
    @sp.flush
  end

  def newline # start a new line
    @sp.putc(10) 
    @sp.flush
  end

  def cursor_home # move the cursor to the home position
    @sp.putc(254)
    @sp.putc(72)
    @sp.flush
  end

  def cursor_set(xpos, ypos) # move the cursor to a specific place e.g.: cursorSet(3,2) sets the cursor to column 3, row 2
    @sp.putc(254)
    @sp.putc(71)               
    @sp.putc(xpos) 
    @sp.putc(ypos)
    @sp.flush
  end

  def backspace # backspace and erase previous character
     @sp.putc(8) 
     @sp.flush
  end

  def cursor_left # move cursor left
    @sp.putc(254)
    @sp.putc(76)   
    @sp.flush
  end

  def cursor_right # move cursor right
    @sp.putc(254) 
    @sp.putc(77)   
    @sp.flush
  end

  def set_contrast(contrast) # set LCD contrast
    @sp.putc(254) 
    @sp.putc(80)   
    @sp.putc(contrast)   
    @sp.flush
  end

  def backlight_on(minutes = 0) # turn on backlight for n minutes (default = stay on indefinitely)
    @sp.putc(254) 
    @sp.putc(66)   
    @sp.putc(minutes)
    @sp.flush
  end

  def backlight_off # turn off backlight
    @sp.putc(254) 
    @sp.putc(70)
    @sp.flush   
  end

  ###
  # Auto scroll doens't work for me due to a known bug in the LK204-24-USB
  # http://www.lcdforums.com/forums/viewtopic.php?p=19714&sid=ed23e97595d725b27de47eded1db79f4
  # def auto_scroll_on
  #   @sp.putc(254)
  #   @sp.putc(81)
  #   @sp.flush
  #   sleep(0.2)
  # end
  #  
  # def auto_scroll_off
  #   @sp.putc(254)
  #   @sp.putc(82)
  #   @sp.flush
  #   sleep(0.2)
  # end
  ###

  def set_startup_screen(text) # 80 chars
    @sp.putc(254)
    @sp.putc(64)
    @sp.print(text)
    @sp.flush
    @sp.sleep(0.5) # this seems to take a while. Give it a chance...
  end

  def close
    @sp.close
  end

end

#lcd = MatrixOrbital.new
#lcd.clear
#lcd.print("                    ")
#lcd.print("    Hello there!    ")
#lcd.print("                    ")
#lcd.print("                    ")
#lcd.backlight_on(1)
#lcd.close