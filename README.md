# photoshopjs-core

[Might become] a Photoshop scripting library.

## What's the story?

I was developing a couple of Photoshop panels like this:

![Screenshot of Array Photoshop Panel](https://github.com/AriaMinaei/photoshopjs-core/raw/master/docs/images/array.png)

... and I was using Photoshop's ExtendScript api. Soon I realized the ExtendScript DOM lacks features and is not easy to work with. So I came up with a library that wraps around Photoshop's own api and gives a jQuery-like interface, like this:
```javascript
// get the active layer
_('active')
// move a quarter of the document's width to the right
.moveX(_.doc.width / 4)
// rotate 45 degrees around it's top/left
.rotate(45, 'topleft')
```

That library worked and we developed a few panels based on it, but it was too slow, because apparently the ExtendScript DOM is slow. In big documents, every single operation on each layer could take up to a second, and if you have many operations on many layers, the whole thing would take minutes which is not acceptable.

So I scratched the whole thing and decided to write our panels with ActionDescriptors that look like this:
```javascript
var idMk = charIDToTypeID( "Mk  " );
    var desc7 = new ActionDescriptor();
    var idNw = charIDToTypeID( "Nw  " );
        var desc8 = new ActionDescriptor();
        var idPstn = charIDToTypeID( "Pstn" );
        var idPxl = charIDToTypeID( "#Pxl" );
        desc8.putUnitDouble( idPstn, idPxl, 176.911544 );
        var idOrnt = charIDToTypeID( "Ornt" );
        var idOrnt = charIDToTypeID( "Ornt" );
        var idVrtc = charIDToTypeID( "Vrtc" );
        desc8.putEnumerated( idOrnt, idOrnt, idVrtc );
    var idGd = charIDToTypeID( "Gd  " );
    desc7.putObject( idNw, idGd, desc8 );
executeAction( idMk, desc7, DialogModes.NO );
```

ActionDescriptors can be fast, but they don't read well, they're not well-documented, and afaik, they're not easy to debug.

So now, the DOM is slow and the ActionDescriptors are too complicated. The middle-ground would be to create a wrapper around ActionDescriptors with a simpler api, which is where this project is at this point.

We'll be developing more Photoshop panels and that will make me add more features to this project. Chances are that at some point this project gets stable enough that I'll be able to advertize it as "A Photoshop scripting library," remove this story and write up some real docs :)

## Projects using photoshopjs-core

* [Griddify](http://gelobi.org/griddify) - A Photoshop panel to make guides and grids.
* More to come

## License

MIT