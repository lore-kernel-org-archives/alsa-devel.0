From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: dsnoop, dshare and dmix plugins
Date: Fri, 21 Mar 2003 13:56:50 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303211354250.2699-100000@pnote.perex-int.cz>
References: <3E7A8063.2090406@boosthardware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E7A8063.2090406@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>, Takashi Iwai <tiwai@suse.de>, Kristof Pelckmans <Kristof.Pelckmans@antwerpen.be>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 21 Mar 2003, Patrick Shirkey wrote:

> Fernando Pablo Lopez-Lezcano wrote:
> > 
> > It would be nice that the user not need to type magic numbers into a
> > configuration file, unique or not. I don't know what it involves, but it
> > would make using the configuration file much easier. 
> > 
> 
> Even nicer is if this could be embedded like the dmix was eventually so 
> that it is unnecessary to use the .asoundrc :)

It's a little problematic to add dshare to the global configuration file. 
I've added the dsnoop plugin just now.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
