# Images2Pen

Images2Pen makes a bunch of images into a Penultimate(.pen) document with a bunch of pages, so you can draw on them with your Penultimate application.

<img src="http://cloud.github.com/downloads/kiding/Images2Pen/concept.png">

# Background

I LOVE [Penultimate][1]. I've been using it since the first version was released with my first-generation iPad, and 3M Smart Pen. It was just awesome, more after adding image is supported.

However, what I really wanted to do is get rid of heavy books or lecture notes in my backpack. There are many PDF/PPT annotation app in the App Store, but none of them satisfied me as much as Penultimate.

So I started to think, what if I can make Penultimate document on my Mac, with images rendered from PDF or PPT, put it on my iPad, and draw something on the images.

# How to Use the Program

	Images2Pen  "[imagesFolder]" "[title]"

Those who are not familiar with Terminal: 

1. Download the program from [Downloads][2].

2. Launch Terminal.app on you Mac.

3. Drag and drop Images2Pen onto Terminal window from Downloads folder.

4. Drag and drop the folder where images are located at.

5. Write down title you want to use.

6. Press return.

7. A pen file will be generated in the images folder. Send it to your iPad with iTunes or Dropbox.

# File Format Structure

CAUTION: The content below is ALSO CONSIDERED AS SOURCE CODE - SEE LICENSE.

CAUTION: Notebook, Page, PageLayer, ImagePageLayer classes are not completed for any other use yet.

## Layer

	Notebook *notebook
		- Page *page1
			- PageLayer(ImagePageLayer) *pageLayer1
			- …
		- Page *page2
			- PageLayer(ImagePageLayer) *pageLayer2
			- …
		- …

## Binary

	header: 20 Bytes

		metadata: NSDictionary Class Encoded With NSKeyedArchiver

		notebook: Notebook Class Encoded With NSKeyedArchiver

			page1: Page Class Encoded With NSKeyedArchiver
				resource1: Image Data

			page2: Page Class Encoded With NSKeyedArchiver
				resource2: Image Data

			…

	footer: NSArray Class Encoded By NSKeyedArchiver

# License

This entire project, source codes are under GPLv3.

Really. Get over it.

# Disclaimer

This project is intended for educational purpose only.

There has never been intention to harm CocoaBox, Penultimate, or anything else.

[1]: http://www.cocoabox.com/penultimate
[2]: https://github.com/kiding/Images2Pen/downloads
