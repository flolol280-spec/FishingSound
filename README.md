FishingSound is a lightweight ESO addon that gives you an instant audio cue when a fish bites — even when the official fishing events fail to fire.
It uses ESO’s internal controller vibration event to detect bites with 100% reliability, making it the most accurate bite‑alert method available.

Whether you’re casually fishing or grinding Master Angler, FishingSound helps you react faster and never miss a bite again.

How It Works 

Using "EVENT_VIBRATION" 

When a Fish bites, there is a EVENT called "EVENT_VIBRATION", which will allways have the same parameters as follows
[1] = 2500 
[2] = 0.0099999997764826...
[3] = 0.05000000.. 
[4] = 0 
[5] = 0
[6] = ""

[1] = Is the Duration of the Vibration
[2-3] = Are the Vibration Intensitys

The Addon checks if the EVENT = "EVENT_VIBRATION" was fired and if it matches 2500ms. 
Most Vibrations are only about 500ms, I did not encounter any overlapings so for, but could be buggy if it did. 

Shout out to the cool Addon "Zgoo High Isle" Author "Rhyono", which helped me to detect EVENTS in ESO and parameters to test this. 


Customization

In the settings ADDONS -> Fishing Sound , are the different Sounds, which you can select and if you want to disable the addon you can do that too. 

The Souds were handpicked by the Addon "Sound Board" by "Miguel"
which suited best for recognition. 

@FloIstImGame is my ESO User and feel free to Mail me in Game
