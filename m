From: Markus Plail <plail@web.de>
Subject: Re: Re: [alsa-cvslog] CVS: alsa-kernel/pci/emu10k1
 emu10k1_main.c,1.12,1.13
Date: Wed, 17 Apr 2002 10:12:30 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87sn5ukakx.fsf@www.gitteundmarkus.de>
References: <873cxxmmjt.fsf@www.gitteundmarkus.de>
	<Pine.LNX.4.33.0204160911040.509-100000@pnote.perex-int.cz>
	<s5h7kn729d9.wl@alsa2.suse.de> <87sn5vn72w.fsf@www.gitteundmarkus.de>
	<s5hads3vhph.wl@alsa2.suse.de> <87elhfn1rd.fsf@www.gitteundmarkus.de>
	<s5h3cxvvd8h.wl@alsa2.suse.de> <87lmbnli6r.fsf@www.gitteundmarkus.de>
	<3CBCA523.8030802@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3CBCA523.8030802@superbug.demon.co.uk> (James
 Courtier-Dutton's message of "Tue, 16 Apr 2002 23:26:43 +0100")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: James@superbug.demon.co.uk
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi James!

* James Courtier-Dutton writes:

> I think what Takashi is saying is that when xine attempts to do
> passthru, it should change the switch automatically. It will in fact
> override whatever you entered in alsamixer. So maybe before it was
> overriding it to "analogue" instead of overriding it to "digital".
> I think that is what Takashi was trying to say.

OK, but then again xine didn't change, but alsa, but then again I
propbably just do not have the knowledge to really judge what is going
on.

Regards
Markus

BTW: Does your rev06 card work with the 'wrong' patch from Takashi?
