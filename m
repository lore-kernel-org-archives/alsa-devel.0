From: Rene Herman <rene.herman@gmail.com>
Subject: Re: How do I update the ALSA SoundCard Matrix?
Date: Thu, 13 Sep 2007 19:36:12 +0200
Message-ID: <46E9750C.9070702@gmail.com>
References: <46E952F4.4070906@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 035BC243A0
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Sep 2007 19:36:30 +0200 (CEST)
In-Reply-To: <46E952F4.4070906@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/13/2007 05:10 PM, Timur Tabi wrote:

> I'm looking at 
> http://bugtrack.alsa-project.org/main/index.php/Matrix:Main. I'm trying 
> to add information on the CS4270 driver that I wrote, but I just don't 
> get it.  I know how to edit normal Wiki pages, but this looks different.
> 
> It looks like all the information is obtained from some database 
> somewhere.
> 
> This page
> 
> http://bugtrack.alsa-project.org/main/index.php/Help:Howto-Edit
> 
> supposedly tells me how to edit, but it's useless.  It doesn't really 
> tell me *how* to edit, it just tells me that it can.
> 
> So what am I missing?  How do I add information on a new driver?  I'll 
> need to add information on a new vendor soon, too.

When I added/updated a few things a while ago, I just did everything 
manually, working from example. Added various cards here:

http://www.alsa-project.org/main/index.php/Matrix:Vendor-Terratec

and created a new vendor page for AdLib, which probably serves nicely as a 
minimal template:

http://www.alsa-project.org/main/index.php/Matrix:Vendor-AdLib

The information in the current matrix was transferred from an older non-wiki 
matrix but as far as I know, this simple manual editing is all there's to it 
now. I'll admit I lost my way in the TerraTec page a few times since it gets 
fairly clumsy, but well, just refresh and check a lot before you commit ;-)

Rene.
