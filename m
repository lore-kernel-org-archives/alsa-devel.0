From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Lots of noob questions on writing an ALSA driver
 for SM501
Date: Tue, 26 Jul 2005 10:28:56 -0500
Message-ID: <42E656B8.9090406@billgatliff.com>
References: <42E645CE.609@billgatliff.com> <Pine.LNX.4.61.0507261633110.8190@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0507261633110.8190@tm8103-a.perex-int.cz>
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

Jaroslav:

Jaroslav Kysela wrote:

>On Tue, 26 Jul 2005, Bill Gatliff wrote:
>  
>
>Look to drivers in the sound/arm (alsa-kernel/arm) tree for ideas.
>
>						Jaroslav
>  
>

I think that the pxa2xx-ac97 and pxa2xx-pcm stuff may be exactly the 
models I'm looking for.

But the sm501 stuff won't be ARM-specific--- it'll be tested on ARM and 
SH, at least.  So where should the source for sm501-pcm.c and sm501-ac97 
be placed?


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com

Today is the last day of your life so far.



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
