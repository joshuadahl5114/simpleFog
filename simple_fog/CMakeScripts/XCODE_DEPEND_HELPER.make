# DO NOT EDIT
# This makefile makes sure all linkable targets are
# up-to-date with anything they link to
default:
	echo "Do not invoke directly"

# Rules to remove targets that are older than anything to which they
# link.  This forces Xcode to relink the targets from scratch.  It
# does not seem to check these dependencies itself.
PostBuild.simple_fog.Debug:
/Users/joshuadahl/Desktop/Tools/OpenGL\ Book\ Examples/chapter_8/simple_fog/Debug/simple_fog:
	/bin/rm -f /Users/joshuadahl/Desktop/Tools/OpenGL\ Book\ Examples/chapter_8/simple_fog/Debug/simple_fog


PostBuild.simple_fog.Release:
/Users/joshuadahl/Desktop/Tools/OpenGL\ Book\ Examples/chapter_8/simple_fog/Release/simple_fog:
	/bin/rm -f /Users/joshuadahl/Desktop/Tools/OpenGL\ Book\ Examples/chapter_8/simple_fog/Release/simple_fog


PostBuild.simple_fog.MinSizeRel:
/Users/joshuadahl/Desktop/Tools/OpenGL\ Book\ Examples/chapter_8/simple_fog/MinSizeRel/simple_fog:
	/bin/rm -f /Users/joshuadahl/Desktop/Tools/OpenGL\ Book\ Examples/chapter_8/simple_fog/MinSizeRel/simple_fog


PostBuild.simple_fog.RelWithDebInfo:
/Users/joshuadahl/Desktop/Tools/OpenGL\ Book\ Examples/chapter_8/simple_fog/RelWithDebInfo/simple_fog:
	/bin/rm -f /Users/joshuadahl/Desktop/Tools/OpenGL\ Book\ Examples/chapter_8/simple_fog/RelWithDebInfo/simple_fog




# For each target create a dummy ruleso the target does not have to exist
