From: alsa@0x00.my-ho.st
Subject: Re: Maestro 2E (rev 10) not found or device busy w/
 0.9.2
Date: Thu, 27 Mar 2003 10:46:31 -0700 (MST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.50.0303271039120.8112-100000@0x00.my-ho.st>
References: <Pine.LNX.4.50.0303261659330.8112-100000@0x00.my-ho.st>
 <s5hof3xnp8c.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hof3xnp8c.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 27 Mar 2003, Takashi Iwai wrote:

> At Wed, 26 Mar 2003 17:12:55 -0700 (MST),
> alsa@0x00.my-ho.st wrote:
> >
> > The 'maestro' driver included with Linux 2.4.x loads, and for the most
> > part works okay.  However trying to use the latest ALSA results in:
> >
> > kernel: es1968: not attempting power management.
> > kernel: ALSA ../../alsa-kernel/pci/ac97/ac97_codec.c:1960: AC'97 0:0 does not respond - RESET
> > kernel: ESS Maestro soundcard not found or device busy
> >
> > Anyone have any suggestions on how to fix this?
>
> which version of alsa did you test exactly?
> i thought this was fixed in the recent version.  please try the cvs
> version if not tried yet.

Thanks for the quick response.  I have tried 0.9.2 and the latest cvs;
both give the same errors.  :(

Any suggestions?

 - Ted


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
