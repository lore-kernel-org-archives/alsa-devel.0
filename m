From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: Terratec Aureon Space
Date: 16 May 2003 11:33:28 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1053081208.17139.41.camel@caernarfon>
References: <200305151826.55345.zeb@zebulon.org.uk>
	 <s5hof23dyn1.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hof23dyn1.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: =?UTF-8?Q?Z=EF=BF=BDbulon?= <zeb@zebulon.org.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takishi,

On Fri, 2003-05-16 at 10:33, Takashi Iwai wrote:
> > 
> > Can I expect to see it supported in the future ?
> 
> only if we get enough technical information...
> 
> at least we need to know the wire connection between codec and ice1724
> chips, especially 61, 62 and 63 pins of Wolfson chip and GPIO pins of
> ice1724 chip.

I'm currently developing Linux drivers for our AC97 range of audio
codecs. Unfortunately, the WM8770 is not in my schedule at the moment as
I'm busy working on WM97xx touchscreen drivers.

However, the WM8770 datasheet is available here.
http://www.wolfsonmicro.com/download.asp/did.217/WM8770.pdf

Hope this helps.

Thanks

Liam

-- 
Liam Girdwood <liam.girdwood@wolfsonmicro.com>



Wolfson Microelectronics plc
http://www.wolfsonmicro.com
t: +44 131 272-7000
f: +44 131 272-7001
Registered in Scotland 89839

This message may contain confidential or proprietary information. If you receive this message in error, please
immediately delete it, destroy all copies of it and notify the sender. Any views expressed in this message are those of the individual sender,
except where the message states otherwise. We take reasonable precautions to ensure our Emails are virus free.
However, we cannot accept responsibility for any virus transmitted by us
and recommend that you subject any incoming Email to your own virus
checking procedures.



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
