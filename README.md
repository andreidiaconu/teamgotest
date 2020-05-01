# Test project

My take on this project was to make the app event and conversation - centric. This is how I and my friends usually get together, using a combo of Facebook Groups (for events) and Messenger (for chat). This UI would work best for small groups and small events. Even for big events, like a concert, I reckon FB & WhatsApp have hundreds of chats or smaller groups that pop up for people to self-organize.

This being said, I don't pretend to know what is best for this startup - this is just my take on the requirements.  

## Getting Started

This is a simple project, with no generated code. Hence, you should be able to clone and run with the latest version of Flutter.

## Project Structure

- `model` contains simple data classes. All immutable and equatable.
- `repository` contains a contract for an API repository and a dummy implementation which generates some data (I had a bit of fun with that).
  - This has unit tests 
- `business_logic` contains Bloc classes and State classes.
  - Bloc implementation is in its simplest form. Input = method calls. Output = Stream of State. 
  - State classes are immutable. They are akin to classes in `model` but they describe a screen state.
  - Tests were written for the most complex Bloc, which manages the feed.
- `ui` contains Flutter code. All rest is Dart code
  - Screens are high-level widgets. Reusable, smaller widget are grouped in folders like `activity` or `conversation`
  - TODO: Widget tests.
  - TODO: Make routing be "provided" instead of static.


I did spend some time on design. I hope you like it.
