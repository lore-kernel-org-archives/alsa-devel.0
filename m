From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: mixer control - Captuer Source - rename item
 name in enumerated control
Date: Wed, 14 Sep 2005 12:42:26 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0509141238120.16662-100000@studcom.urz.uni-halle.de>
References: <4327FC13.7010001@netvigator.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4327FC13.7010001@netvigator.com>
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
Cc: alsa-devel@lists.sourceforge.net, openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

Raymond wrote:
> Is it possible to detect which daugther card is connected (e.g Yamaha
> DB50XG, TurtleBeach Cancun FX, Roland SCD-15...) and replace "Video"
> with the name of daugther card on the mixer control ?

This would require some SysEx, but AFAIK the connector doesn't have a
back channel for MIDI.


Regards,
Clemens



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
