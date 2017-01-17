# TouchEmote
TouchEmote is a non-intrusive way to log emotional states using the new Macbook touchbar. The simple UI allows users to touch an emoji on a 7-point scale that best represents their mood. That data can be displayed back to the user based on the user's moods that day, week or month.

![Alt text](/images/weekData.png?raw=true "Data display")

# Specs
TouchEmote is written in Swift 3.0 in the XCode 8 environment. I use XCode's Core Data functionality to store emotion logging data and followed Apple's new Human Interface Guidelines for using the NSTouchBar.

![Alt text](/images/imageWithTouchbar.JPG?raw=true "Picture")

# Todo
There currently is not many forums with active questions and answers about touch bar issues. I'd like to convert the 'sheet' segue from the greeting view to the statistics view to a custom segue, though when I do so the touchbar doesn't properly reload.
As time goes on I'd like to build other data analysis displays.

#Thanks
https://www.raywenderlich.com/ and http://nshipster.com/ both had great tutorials for newcomers to Swift/XCode development.
Also wanted to share: the day I started developing this app I search github for NSTouchBar repos and found Zac Kwan's (@Zaccc123) 'How are you feeling today?' touchbar app. As is said: great Zachs think alike.
