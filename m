From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: Re: intel 8x0 went silent in 2.6.11
Date: Tue, 08 Mar 2005 02:10:06 +0100
Message-ID: <422CFB6E.1020002@drzeus.cx>
References: <4227085C.7060104@drzeus.cx>	<29495f1d05030309455a990c5b@mail.gmail.com>	<Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com>	<1109875926.2908.26.camel@mindpipe>	<Pine.LNX.4.62.0503031356150.19015@krusty.vfxcomputing.com>	<1109876978.2908.31.camel@mindpipe>	<Pine.LNX.4.62.0503031527550.30702@krusty.vfxcomputing.com>	<20050303154929.1abd0a62.akpm@osdl.org>	<4227ADE7.3080100@drzeus.cx>	<4228D013.8010307@drzeus.cx>	<s5hmztfwon1.wl@alsa2.suse.de>	<422CB68A.1050900@drzeus.cx> <s5hekerurz8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5hekerurz8.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Mark Canter <marcus@vfxcomputing.com>, rlrevell@joe-job.com, nish.aravamudan@gmail.com, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>>>Look at /etc/asound.state whether it contains the value of "Headphone
>>>Jack Sense" control true or false.
>>> 
>>>
>>>      
>>>
>>It saves the setting once I've been in 2.6.11. From an earlier kernel
>>there is no such entry.
>>    
>>
>
>Of course, the earlier version didn't have this.
>
>And did you take a look at the latest content?  What stands on it?
>Maybe you once saved a value wrongly corrected by any reason?
>
>  
>
I'm not sure what you mean. In the 2.6.10 version the last entry is 
'Stereo Mic'. In 2.6.11 there's 'Headphone Jack Sense' and 'Line Jack 
Sense' following that.
 From what I can tell every entry seems valid.

Rgds
Pierre



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
