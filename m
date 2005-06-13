From: edoardo <edoardo@lastorina.it>
Subject: Re: audgiy two zs and emu10k1
Date: Mon, 13 Jun 2005 18:05:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0506131801150.29136@localhost>
References: <Pine.LNX.4.63.0506110156090.19442@localhost> <42AB6EBC.5080201@superbug.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42AB6EBC.5080201@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa developers' list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



On Sun, 12 Jun 2005, James Courtier-Dutton wrote:

>
> Post the output of:
> lspci -vn | grep -1 0401

the output is:

0000:00:06.0 Class 0401: 10de:006a (rev a1)
         Subsystem: 1043:8095
--

0000:01:06.0 Class 0401: 1102:0004 (rev 04)
         Subsystem: 1102:2002

> also the output of:
> cat /proc/asound/cards

the output is:

0 [Audigy2        ]: Audigy2 - Sound Blaster Audigy2
                      Sound Blaster Audigy2 (rev.4, serial:0x20021102) at 
0xc000, irq 16

for peter: i confirm, it's player.

help? please, thankyou : )

ciao! : )

edoardo


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
