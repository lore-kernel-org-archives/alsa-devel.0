From: Florian Schmidt <mista.tapas@gmx.net>
Subject: doc-page
Date: Thu, 4 Dec 2003 19:42:43 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031204194243.4841b5a7.mista.tapas@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: pshirkey@boosthardware.com
List-Id: alsa-devel@alsa-project.org


Hi Patrick. I saw your changes to the doc page and have one or two
remarks:

1.] The layout is a litle bit messed up here. The black line goes
through "Supported Soundcards" and "Userspace Tools". If i use a smaller
font, it's ok. so i don't know, if it's a mozilla thing [Mozilla Debian
Package 1.5-3]..

2.] There's quite a lot of info in the wiki allready and i wonder if we
could just create [initially empty] entries in the wiki for the missing
links [like dmix/dsnoop, 5.1 sound...]. There's already a dmix page in
the wiki which we could link to. As it grows more mature it can  someday
maybe be integrated into the "normal" documentation..

Using the wiki for drafts for these pages also has the advantage of that
it is very easy to set up initial pages which then can be improved.
Let's say: it becomes much easier for the user to contribute
documentation this way.. Also users who don't know what a wiki is will
soon learn if links from the doc pages go to it :)

3.] Contrary to my first draft of the TOC i would suggest moving the
soundcard matrix to the system maintainers section. Also the name "Sound
Card Matrix & User documentation" is misleading. I suppose this means
the user supplied info regarding each driver. I would rather have "User
documentation" as a single Topic for documentation that is really aimed
at the end user [This contains the userspace tools and the .asoundrc,
though this also overlaps with system maintainers stuff]

Flo

P.S.: If you want help with it, i could just do the changes to a local
copy and then send you a diff.

-- 
music: http://www.soundclick.com/bands/9/florianschmidt.htm




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
