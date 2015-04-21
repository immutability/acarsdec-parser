# acarsdec-parser
A simple bash parser for the [acarsdec utility](http://sourceforge.net/projects/acarsdec/). 

# How Does It Work
This is actually a very simple shell script for BASH that, when fed the output from acarsdec, will parse each message into separate variables. It only depends on grep (and eventually a database client). It will echo the message data to the standard output, but will also allow you to do whatever you want with the message data. You can find a commented section of the script, which inserts the message data into a plain table on a remote MySQL database. Just modify this part and comment out the echo statements to fit your needs.

Example Usage: `./acarsdec -p 20 -r 0 131.725 | ./acars-parser.sh`

Use this script at your own risk. It is more of a quick hack rather than a solid piece of code and may have issues. It is not fool proof and does not do a good job at checking the input for errors. If you spot anything suspicious, let me know, and I'll also be happy to accept pull requests with improvements. But keep in mind that I'm not a big friend of bash when you look at the code. :)

# Background
A friend of mine asked me for help setting up acarsdec with a USB DVB-T dongle on Raspberry Pi. If you don't know what ACARS is, this is probably not going to be useful to you.

While acarsdec 3.0 is a nice little utility, it is not very flexible with its output. It can either print the ACARS messages it receives to stdout, log them into a file, or feed them via UDP to another application over the network (using plane plotter or its native format). In version 3.0, it actually comes with a small server (acarsserv) via UDP, which is capable of filtering the messages and storing them into a SQLite database.

This is all nice and cool, but what we actually needed was to feed the received messages over to a remote database with the least hassle, and keep the Pi acting only as a receiver. Writing a simple bash parser seemed the most straightforward way, although the more *correct* approach would probably be to modify acarsdec to output the messages in another format (such as CSV or something) which would be easier to parse. But I haven't touched C in a while...
