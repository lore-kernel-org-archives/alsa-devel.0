From: brett-alsa@kavi.com
Subject: Re: powermac build fails
Date: Mon, 30 Sep 2002 11:37:05 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020930183705.GA14193@debian>
References: <20020924231609.GC3369@debian> <s5h7khanx6p.wl@alsa2.suse.de>
Reply-To: brett-alsa@kavi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h7khanx6p.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ok, I give up.  Do I just need to build the sound module alone, or do I
need to rebuild all of the toolchain?  (I'm currently using the debian
packages for alsa-utils 0.9rc1).  There doesn't appear to be a build
script for all the tools - in the cvs snapshot there's a Makefile and a
'build' shell script.  Are either of these documented somewhere?  Doing
a 'make' at the top level simply installs docmentation only.
-Brett

On Wed, Sep 25, 2002 at 01:08:46PM +0200, Takashi Iwai wrote:
> At Tue, 24 Sep 2002 16:16:09 -0700,
> brett-alsa@kavi.com wrote:
> > 
> > I'm trying to compile alsa 0.9rc3 on a Powerbook G4 DVI against
> > 2.4.20-pre7 + benh patches, I get an error:
> 
> could you try the cvs version?
> 
> thanks,
> 
> Takashi


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
