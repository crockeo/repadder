# Repadder

Repadder is a tool to match controller inputs to keyboard inputs. My use case of
it is for playing videogames that don't support controllers. For instance,
[Risk of Rain](http://riskofraingame.com) is a game I love to play, but it
doesn't officially support DInput controllers. So instead I've created a mapping
for it to play on my Logitech F310.

### Code Concerns

*(So I can remember them and fix them.)*

* In all of the `processJoy<Blank>Event` I'm performing a linear search through every `<Blank>Map` in the file.
* Same thing for when I construct a `Writes` in the `processJoyHatEvent` function.
* Initializes every SDL Joystick detected (even if they're not contained in the config).
* Doesn't check the required set of joysticks for the minimum-Joystick-number test.

### License

This project is licensed under the MIT license, as specified in the accompanying
`LICENSE` file.
