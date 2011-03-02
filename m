From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] twl4030_codec cleanup
Date: Wed, 2 Mar 2011 09:21:44 -0800
Message-ID: <20110302172144.GT20560@atomide.com>
References: <1299072246-26402-1-git-send-email-ilkka.koskinen@nokia.com>
	<20110302143433.GM16181@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mho-02-ewr.mailhop.org (mho-02-ewr.mailhop.org [204.13.248.72])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D5A31037F3
	for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2011 18:21:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110302143433.GM16181@sortiz-mobl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, peter.ujfalusi@nokia.com, linux-kernel@vger.kernel.org, Ilkka Koskinen <ilkka.koskinen@nokia.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hi Samuel,

* Samuel Ortiz <sameo@linux.intel.com> [110302 06:32]:
> Hi Ilkka,
> 
> On Wed, Mar 02, 2011 at 03:24:04PM +0200, Ilkka Koskinen wrote:
> > This series of patches removes duplicate audio_mclk fields from
> > twl4030_codec driver.
> > 
> > The patches have been compiled on sound-2.6/for-2.6.39 branch.
> > I haven't tested them on any target board though.
> I'm fine with the twl.h changes, but I think it would make sense for Tony to
> take this patchset. Tony, is that ok with you ?

Sure if you prefer that.

Tony
