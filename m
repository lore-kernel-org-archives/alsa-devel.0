From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Black list?
Date: Tue, 24 Feb 2004 22:53:34 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <403BD5EE.4060506@superbug.demon.co.uk>
References: <403B71E4.4000706@superbug.demon.co.uk> <Pine.LNX.4.58.0402241639010.1883@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-37.mail.demon.net (anchor-post-36.mail.demon.net [194.217.242.86])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA10694
	for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2004 23:46:37 +0100
In-Reply-To: <Pine.LNX.4.58.0402241639010.1883@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Tue, 24 Feb 2004, James Courtier-Dutton wrote:
> 
> 
>>http://www.alsa-project.org/black.html
>>
>>
>>How can this list be NONE!
>>
>>We need to add Creative for their SB Live Dell edition (emu10k1x) and 
>>the SB Audigy LS.
> 
> 
> Well, have we a response from Creative that they're not willing to give us 
> programming information?
> 
> 						Jaroslav
> 
Quoted response from Creative today: -
"Unfortunately, I can't give you this information. I'm lobbying to get 
it released."

Some time ago, Creative were very supportive of linux and the open 
source community, but in the last year or 2 that has changed considerably.
So I vote to black list Creative.
I think it would also be good to add status to all sound card 
manufacturers with several levels: -
1) Very co-operative, supply datasheets and points of contact. (We 
should add url links to copies of the datasheets, and store copies of 
all datasheets on the alsa web site.)
2) Supply datasheets with enough infomation to write drivers.
3) Minimal help has been provided and limited functionallity has been 
implemented in the driver.
4) Do not help, but people have managed to reverse engineer enough and 
have built drivers.
5) Do not help, and no reverse engineering work has been done.

Maybe on a per sound card level. I think we should also list PCI IDs 
together with the sound card names, for the sake of accuracy.

Adding direct url links to datasheets stored on the alsa site would help 
potential developers a lot. For example, when I did some work on the 
AC97 chips, it took a long time for me to track the datasheets down.

We can then sing the praises of all the helpful companies and aid in 
their marketing effort. So helpful companies get more sales.
We can also then do the opposite with unhelpful companies.

We could then have three lists: -
1) Black list for unhelpful companies.
2) Grey list for partially helpful companies
3) White list for very helpful companies.

So, for example I see a sound card on a web site. e.g.Gainward 
Hollywood@Home 7.1 soundcard/PCI 24bit VIA Envy24 chipset
Is that a black, grey or white sound card?

Cheers
James


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
