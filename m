From: Steve Harris <S.W.Harris@ecs.soton.ac.uk>
Subject: Re: A couple of hardware problems
Date: Wed, 15 Jan 2003 09:53:27 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030115095326.GA17774@ecs.soton.ac.uk>
References: <20030114143440.GW22132@ecs.soton.ac.uk> <s5hfzrvya3b.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hfzrvya3b.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 14, 2003 at 05:23:04 +0100, Takashi Iwai wrote:
> > The other I dont know about: I bought an ESS Solo1 based card (Terratec
> > 128i PCI) to use the MIDI port, but it doesn't appear to work for MIDI
> > input.
...
> the last time i tried, i also couldn't get the midi-in working, and
> forgot this issue for a while.  i just took a look at the code again. 
> could you test the attached patch?  it's to the latest cvs but likely
> applicable to your version, too.

I managed to aaply the patch, but it caused a kernel panic. I'm going to
have to install a card I know works 'cos I'm against a bit of a deadline,
but I can post you the card if you dont have access to one.

- Steve


-------------------------------------------------------
This SF.NET email is sponsored by: Take your first step towards giving 
your online business a competitive advantage. Test-drive a Thawte SSL 
certificate - our easy online guide will show you how. Click here to get 
started: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0027en
