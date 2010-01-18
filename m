From: Brendan Pike <spike@spykes.net>
Subject: Re: How much of the X-Fi (emu20k1) chip has Creative
 documented?
Date: Mon, 18 Jan 2010 17:27:18 -0500
Message-ID: <20100118172718.07c1053f@darius>
References: <20100118155155.0f954199@darius>
	<506940.60549.qm@web52907.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.spykes.net (dsl.spykes.net [76.10.173.13])
	by alsa0.perex.cz (Postfix) with ESMTP id 76002103843
	for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2010 23:27:19 +0100 (CET)
In-Reply-To: <506940.60549.qm@web52907.mail.re2.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chris Rankin <rankincj@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 18 Jan 2010 14:21:57 -0800 (PST)
Chris Rankin <rankincj@yahoo.com> wrote:

> --- On Mon, 18/1/10, Brendan Pike <spike@spykes.net> wrote:
> > The matrix is horribly out of date. Yes PCIe cards
> > (emu20k2) are supported. HWMix also exists and works perfectly,
> That's interesting! Can you post the output of
> 
> /proc/asound/<X-Fi card>/pcm0p/info
> 
> please?

That doesn't exist here. The driver is limited in that it doesn't really
provide any information in /proc/asound at all.
>  
> > I use an Auzentech X-Fi Forte myself, which works great.
> 
> Are the emu20k1 cards equally well supported? It looks like emu20k2 cards are exclusively PCIe, whereas I'd probably be looking for a PCI card.

My previous card was a PCI emu20k1 based X-Fi Prelude, which worked the
same way as my current card does.

> 
> Thanks,
> Chris
> 
> 
>       
