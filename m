From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: Fix at32-pcm build breakage with PM
	enabled
Date: Fri, 19 Sep 2008 20:25:14 +0100
Message-ID: <20080919192513.GA18851@sirena.org.uk>
References: <1221843045-18093-1-git-send-email-haavard.skinnemoen@atmel.com>
	<20080919182036.GA16316@sirena.org.uk>
	<20080919211437.08db455c@hskinnemo-gx745.norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7393D24679
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Sep 2008 21:25:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080919211437.08db455c@hskinnemo-gx745.norway.atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 19, 2008 at 09:14:37PM +0200, Haavard Skinnemoen wrote:
> Mark Brown <broonie@sirena.org.uk> wrote:

> > Please submit all ALSA patches to alsa-devel (added to the CC).

> I would if it wasn't listed as subscribers-only...but from a closer
> look, it appears like it's only moderated for non-subscribers. Should I
> resend the patch?

Probably best, yes.  Or if the subscribers thing is an issue you could
send it to Takashi directly.

> Btw, Liam Girdwood's mail address from MAINTAINERS doesn't work.

Yup, he's now lrg@slimlogic.co.uk (I'd updated the address for this
thread when I replied).  He's submitted a patch for MAINTAINERS already
but it's not propagated beyond ALSA git yet.
