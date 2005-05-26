From: Andrew Morton <akpm@osdl.org>
Subject: Re: nforce 4 audio has no s/pdif out
Date: Wed, 25 May 2005 17:31:13 -0700
Message-ID: <20050525173113.16253b80.akpm@osdl.org>
References: <20050325012931.GA30885@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050325012931.GA30885@codeblau.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Felix von Leitner <felix-linuxkernel@fefe.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Felix von Leitner <felix-linuxkernel@fefe.de> wrote:
>
> My shiny new nforce 4 main board has sound that is detected OK by ALSA:
> 
>   intel8x0_measure_ac97_clock: measured 49970 usecs
>   intel8x0: clocking to 46877
>   ALSA device list:
>     #0: NVidia CK804 with ALC850 at 0xd2003000, irq 185
> 
> but I can't get my stereo to play.  It is connected via optical S/PDIF.
> Works fine under Windoze, so the hardware is ok.
> 
> Any idea what I could do?

Felix, is this problem still present in 2.6.12-rc5?

Thanks.


-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
