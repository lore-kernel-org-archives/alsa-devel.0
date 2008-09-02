From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] ASoC: Convert wm8510 to a new-style i2c
 driver (v2)
Date: Tue, 2 Sep 2008 22:57:50 +0200
Message-ID: <20080902225750.35e8797e@hyperion.delvare>
References: <20080902170730.737ff34d@hyperion.delvare>
	<1220386306.6499.226.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id BA13624764
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Sep 2008 22:57:58 +0200 (CEST)
In-Reply-To: <1220386306.6499.226.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@kernel.org>
Cc: alsa-devel@alsa-project.org, Geoffrey Wossum <gwossum@acm.org>, Brown <broonie@opensource.wolfsonmicro.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 02 Sep 2008 21:11:46 +0100, Liam Girdwood wrote:
> On Tue, 2008-09-02 at 17:07 +0200, Jean Delvare wrote:
> > Convert the wm8510 codec driver to the new (standard) device
> > driver binding model.
> 
> If you ever bump into either Mark or I at a conference then we are
> probably due you a beer or two for all this fine work.

I'll be at the joint reception between the Kernel Summit and the
Plumbers Conference in Portland in 2 weeks, if you happen to be there
as well. That being said, on my personal scale, the review work you and
Mark have done has more value than my contributions, so I owe both of
you a beer if anything.

(And that's ginger ale for me, not beer, but that's an implementation
details ;))

-- 
Jean Delvare
