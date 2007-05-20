From: Rask Ingemann Lambertsen <rask@sygehus.dk>
Subject: Re: Can someone verify support for "AzTech
	Sound	Galaxy Nova 16 Extra II-3D - using AZT-2316/R Chipset
	-	FCC-ID:I38-MMSN846" ?
Date: Sun, 20 May 2007 14:23:49 +0200
Message-ID: <20070520122349.GB5690@sygehus.dk>
References: <20070513101757.8C8191BF23B@ws1-1.us4.outblaze.com>
	<4648DA4E.8050107@gmail.com> <4648E10B.4010403@gmail.com>
	<20070515101259.GS5690@sygehus.dk> <464B955F.3030508@gmail.com>
	<20070517130811.GY5690@sygehus.dk> <464E6710.4000909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pfepc.post.tele.dk (pfepc.post.tele.dk [195.41.46.237])
	by alsa0.perex.cz (Postfix) with ESMTP id 1DAA22458C
	for <alsa-devel@alsa-project.org>;
	Sun, 20 May 2007 14:23:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <464E6710.4000909@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, May 19, 2007 at 04:55:12AM +0200, Rene Herman wrote:
> On 05/17/2007 03:08 PM, Rask Ingemann Lambertsen wrote:
> 
> >I've found the X24C00 chip, a 12 MHz crystal or oscilator (I'm not sure 
> >which) and an Intel S-80C51FANM chip. The uncommented jumpers J1 and J2
> >are my best bet, although they are connected to the AZTSSPT0592 chip.
> 
> Right, so you also have that one. Also the AZT-NXPMIX0592?

   Yes.

> If J1 and J2 are connected to pin 17 and 18 at the top (the side which is 
> "up" when you can read the markings) of the AZTSSPT0592 then those will be 
> my J4/J5. Also unmarked, but I have the booklet!

   They are. I also have J4/J5 labelled PC SPKR, do you happen to know what
they are for?

> If they're the same, then you should have a "virtual parallel port" at 
> 0x278 when they're closed for "Disney Sound Source" compatibility.

   I do.

-- 
Rask Ingemann Lambertsen
