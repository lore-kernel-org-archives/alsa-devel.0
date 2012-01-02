From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH v8 3/3 RESEND] ASoC: da7210: Add support
 for line input and mic
Date: Mon, 2 Jan 2012 18:10:02 +0530
Message-ID: <1325508002.12508.30.camel@matrix>
References: <1325505952.12508.12.camel@matrix>
	<20120102120024.GH2899@opensource.wolfsonmicro.com>
	<1325506569.12508.15.camel@matrix>
	<20120102121117.GI2899@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe005.messaging.microsoft.com
	[213.199.154.208])
	by alsa0.perex.cz (Postfix) with ESMTP id DAB54244CE
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2012 13:28:01 +0100 (CET)
In-Reply-To: <20120102121117.GI2899@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, lrg <lrg@ti.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2012-01-02 at 12:11 +0000, Mark Brown wrote:
> On Mon, Jan 02, 2012 at 05:46:09PM +0530, Ashish Chavan wrote:
> > On Mon, 2012-01-02 at 12:00 +0000, Mark Brown wrote:
> 
> > > Where are patches 1 and 2?
> 
> > They are already merged.
> 
> Then this isn't patch 3/3, it's a single isolated patch!  If you post it
> as though it's part of a patch series then you're saying there's another
> two patches that should be arriving at the same time which this depends
> on.  The fact that it's been posted as part of a series in the past is
> really not interesting.
> 

I see, I was not aware of this norm. I just thought that not changing
the subject line may help in identifying multiple submissions of the
same patch.

BTW, should the version info be also dropped in case if we consider this
as a new, independent patch? Because many of the version increments were
just because of changes in other, earlier patches in the series.
