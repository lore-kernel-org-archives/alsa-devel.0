From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: au88x0_synth
Date: Thu, 31 Mar 2005 12:40:05 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0503311235340.12942-100000@studcom.urz.uni-halle.de>
References: <424BC17C.6000700@netvigator.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <424BC17C.6000700@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Raymond wrote:
> http://www.midi.org/about-midi/tutorial/tutor.shtml

42

> make[2]: *** No rule to make target `snd-au8830-synth.o', needed by
> `modules'. Stop.

Yor makefile does not have the rle needed for this modle.


HTH
Clemens



-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
