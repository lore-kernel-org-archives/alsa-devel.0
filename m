From: Florian Bomers <Florian.Bomers@sun.com>
Subject: Re: snd_ prefix for module options
Date: Wed, 09 Oct 2002 10:41:18 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA46A3E.38A2D18B@sun.com>
References: <s5hfzvh2fid.wl@alsa2.suse.de>
		<DAELIEGDPLDDCIJPAICBEENLCDAA.annabellesgarden@yahoo.de> <s5hwuor29tv.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



Takashi Iwai wrote:
> (...)
> a convenient method is to check and rewrite /etc/modules.conf
> automatically when alsa-driver is installed.  (btw, in the case of
> debian, do we need to check another path, too?)
> 
> i'm not sure whether it's good manner or not, though.

I guess providing a script in the utils dir and pointing to it after compilation
would be nice.

Florian


> 
> Takashi
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
Florian Bomers
Java Sound
Java Software/Sun Microsystems, Inc.
http://java.sun.com/products/java-media/sound/


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
