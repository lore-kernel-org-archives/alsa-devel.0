From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: Re: [alsa-cvslog] CVS: BEFORE REVERT  [SUCCESS]
   C-Media CMI9761 -A- type, TESTING 01
Date: Wed, 16 Feb 2005 23:00:41 +0100
Message-ID: <4213C289.7030500@gmx.de>
References: <E1D1Ttl-0000lb-In@sc8-pr-cvs1.sourceforge.net> <4213BB44.5060702@gmx.de>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <4213BB44.5060702@gmx.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

thomas schorpp wrote:

> after modprobe
> 
> - arts works with pcm fine
> - working master vol slider(!) (kmix)
> - working pcm vol regulation on 1. dxs slider (rest 3 no sound reaction)
> 
> ... further tesing...
> 


a) oss-apps sound on DXS slider nr 2 (xmms , /dev/mixer , dsp)

only discrete access to /dev/mixer (on/off), see if i can fix that (add 
pcm slider again, reading diff to 2.6.0)

suggest no fixed status without reaching that.

y
tom




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
