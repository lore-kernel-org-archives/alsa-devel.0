From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Cross compiling alsa-driver
Date: Thu, 06 Apr 2006 19:15:15 -0400
Message-ID: <1144365316.12038.37.camel@mindpipe>
References: <1144187819.9472.25.camel@localhost.localdomain>
	 <s5hwte4ntxt.wl%tiwai@suse.de>
	 <1144361810.9219.6.camel@localhost.localdomain>
	 <1144362329.12038.22.camel@mindpipe>
	 <1144362544.9219.14.camel@localhost.localdomain>
	 <1144364276.12038.31.camel@mindpipe>
	 <1144365041.9219.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1144365041.9219.18.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-04-07 at 00:10 +0100, Adrian McMenamin wrote:
> On Thu, 2006-04-06 at 18:57 -0400, Lee Revell wrote:
> > On Thu, 2006-04-06 at 23:29 +0100, Adrian McMenamin wrote:
> > > I know that aica isn't in there - but the general build should still
> > > work and it doesn't... 
> > 
> > Nope - I just tested it by removing the Makefile and running ./configure
> > with a made up card and it does not generate a new Makefile.  So it must
> > be using an old one with incorrect kernel source locations.
> > 
> Sorry, do you mean I am wrong or do you mean the configure script is
> wrong?
> 
> 

http://www.alsa-project.org/~iwai/writing-an-alsa-driver/x1658.htm




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
