# Animate-To-Godot-Timeline
A Godot plugin that converts Adobe Animate sprite atlas XML files to animation timeline tracks.


# Usage

# Importing directly into animation player
To import XML data directly into an animation player is quite simple. Once you enable the plugin, restart and you should see this menu.

![image](https://user-images.githubusercontent.com/112031679/207199547-af91c7a8-351c-48a0-860f-b914def3b524.png)

Firstly, create an animation player and set it's root node to your sprite.

![image](https://user-images.githubusercontent.com/112031679/207199747-3db12010-b661-48e4-95df-8d527581b5f0.png)

Make sure your sprite has region enabled like so.

![image](https://user-images.githubusercontent.com/112031679/207199813-9b4b7141-0e20-4c15-9f99-d4af9dcef6fc.png)

Back in the menu that was created upon enabling the plugin, simply replace the text in this box with your animation player name.

![image](https://user-images.githubusercontent.com/112031679/207199585-1c669064-4c34-41d8-8d91-4f1c6df78967.png)

Set your required parameters.

![image](https://user-images.githubusercontent.com/112031679/207199611-cfe4739b-60c4-4e12-822b-60fae395b799.png)

Click "Open XML File", and select your XML file. The XML data will be injected into the animation player perfectly.

![image](https://user-images.githubusercontent.com/112031679/207199637-6326ec5d-4794-4069-936b-794f0cd5ef32.png)

# Parsing at runtime
The plugin also comes with an API for parsing the XML files at runtime.

`ATTUtils.parse_atlas_xml("XMLPATH")`

This function, will parse the XML data into a dictionary which you can do whatever you like with.

`ATTUtils.atlas_xml_to_timelines("XMLPATH")`

This function will generate a dictionary containing the animation name and animation data. There are two optional parameters you can use.

`crop_buffer` 

which is a Rect2, and

`animation_fps`

which is an integer.

The crop buffer dictates the rect of the crop region. The animation FPS is self explanatory, it will set the  FPS of the animation. Accessing the animations is as simple as

`var animations = ATTUtils.atlas_xml_to_timelines("XMLPATH")`

and then

`var animation_data`

and finally

`for animation in animations: animation_data.append(animation.data)`


# Saving XML animations as resource files
The following code will save the XML animations as resources in the desired destination folder
![image](https://user-images.githubusercontent.com/112031679/207200305-69ede627-105c-4e53-9e77-f3560993755a.png)
