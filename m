From: edoardo <edoardo@lastorina.it>
Subject: Re: ad1938
Date: Thu, 8 May 2003 23:26:40 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0305082321160.389@fil.paciochino>
References: <Pine.LNX.4.44.0305072051120.7448-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0305072051120.7448-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


well, i think i've played with every control from alsamixer. i raised
every control to a quite high level, but still no sound comes out. what do
you think the problem could be? again, its an asus P4PE motherboard with
integrated sound chip AD1980 (not 1938 as i wrote in the subject) and...
well the driver that's supposed to make it work, intel-8x0, makes it work
for the machine (xmms open and *plays* - uhmmm... - mp3 files fine), but
no actual sound is produced, at all. i've tried everything. have you ever
heard of the same situation with this chipset?

or maybe, maybe, i'm really not unmuting the channels properly... for
unmuting i suppose everything i do is open alsamixer and raise the volume.
as i see no mute/unmute switch on the mixer anyway. is that all i'm
supposed to do? if it were really about unmuting, then the whole thing'd
be real dumb. but i don't think it is. i think it's about some error in
the driver. in fact, AD1980 is not even listed among the supported chips.
any developer listening? do you have plans to support it?

thank you a lot, all of you.

edoardo


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
