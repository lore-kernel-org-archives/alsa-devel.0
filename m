From: Rafal Dejewski <lardel@interia.pl>
Subject: Re: Ali5451 on HP VT6200 notebook not working
Date: Fri, 29 Nov 2002 12:40:48 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200211291240.48502.lardel@interia.pl>
References: <200211211230.00392.lardel@interia.pl> <200211291147.25551.lardel@interia.pl> <s5hbs48r62g.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbs48r62g.wl@alsa2.suse.de>
Content-Disposition: inline
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

On Friday 29 November 2002 12:03, you wrote:
>
> ok, the devices are there.  i think it's a bug of the driver, which
> assumes the order of devices from 1533 -> 7101.
> please try the patch attached (to cvs).
>
That did it! Cool! 
The oss emulation works great. I have some problems in mplayer and xmms in 
alsa native mode, but that might be another thing.

Rafal

----------------------------------------------------------------------
Powiedz sobie dobre "Dzien dobry"!http://link.interia.pl/f168b




-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
