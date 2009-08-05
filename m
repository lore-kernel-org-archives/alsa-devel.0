From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: MPC5200: Support for buffer wrap
 around
Date: Wed, 5 Aug 2009 22:11:02 +0100
Message-ID: <20090805211102.GB5686@sirena.org.uk>
References: <20090729153844.18131.68062.stgit@riker>
	<1249490672.4582.65.camel@riker>
	<20090805170519.GA26086@rakim.wolfsonmicro.main>
	<fa686aa40908051105sad236fj29301d1b11ece0d7@mail.gmail.com>
	<9e4733910908051134n1ff97b47udb7645b6a714e4e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DCCC42462D
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Aug 2009 23:11:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910908051134n1ff97b47udb7645b6a714e4e3@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, John Bonesio <bones@secretlab.ca>, alsa-devel@alsa-project.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 05, 2009 at 02:34:38PM -0400, Jon Smirl wrote:
> On Wed, Aug 5, 2009 at 2:05 PM, Grant Likely<grant.likely@secretlab.ca> wrote:

> > Acked-by: Grant Likely <grant.likely@secretlab.ca>

> It looks ok to me. I have my hardware torn up so I can't run anything.
> I am rebuilding it to work on I2S.

Applied, thanks.

> I wish the upper layers would deal with appl_ptr instead of making the
> drivers do it.

wv :)
