From: Michal Seta <mis@creazone.com>
Subject: Re: snd-usb-midi, midi input, oss, oops!
Date: Tue, 17 Sep 2002 16:07:32 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020917160732.50a83021.mis@creazone.com>
References: <Pine.HPX.4.33n.0209170930500.5178-100000@studcom.urz.uni-halle.de>
 <200209171947.MAA06264@cmn29.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200209171947.MAA06264@cmn29.stanford.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

oups...  sorry.
I meant to send my tip to the list and not privately :)

glad it worked.

On Tue, 17 Sep 2002 12:47:48 -0700
Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

 
> Thanks to an email from Michal Seta (off the list) the MIDI in
> problem is solved. Apparently the Midisport 2x2 firmware does
> not like any active MIDI inputs while the firmware is loading.
> If you disconnect everything, plug in the interface to the usb
> bus, load all the drivers and _then_ connect the input midi
> cables everything is fine.
> 


-- 
./MiS

Michal Seta		http://creazone.eworldmusic.com/doc/mis
CreaZone		http://www.creazone.com
No One Receiving	http://www.noonereceiving.32k.org

upcoming release:
NOR - "The Release of the Wandering-Eyed Girl"
	http://www.grainofsound.com



-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
