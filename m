From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: AW: usb quattro
Date: Sat, 07 Sep 2002 06:13:38 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D791A82.7040704@boosthardware.com>
References: <3D77A319.3010703@boosthardware.com>	<DAELIEGDPLDDCIJPAICBGEHNCDAA.annabellesgarden@yahoo.de> <s5hvg5jwgvk.wl@alsa2.suse.de> <3D7912A2.1000908@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:

> 
> I have actually managed to get a stream from alsaplayer through without 
> a hang but the sound is choppy.
> 
> I will make a test signal  so you can hear what I am getting. It's 
> similar to what was happening before the driver was fixed last time.
> 

Well I just noticed that the sound from native alsa apps is fscked to.

Here is a sample for you, it should be a pure sine wav but it's not quite.

http://www.boosthardware.com/audio/sine-0907.wav

I spose that fixing this might help jack or maybe not :)

-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================

"Um...symbol_get and symbol_put... They're
kindof like does anyone remember like get_symbol
and put_symbol I think we used to have..."
- Rusty Russell in his talk on the module subsystem



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
