From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/4] Separate common pxa2xx-ac97 code
Date: Wed, 10 Sep 2008 14:13:36 +0100
Message-ID: <20080910131334.GD23682@sirena.org.uk>
References: <1221008480-13377-1-git-send-email-dbaryshkov@gmail.com>
	<20080910115717.GC23682@sirena.org.uk>
	<20080910123456.GB17144@doriath.ww600.siemens.net>
	<1221051161.17091.241.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 00620243CD
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Sep 2008 15:13:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1221051161.17091.241.camel@odin>
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
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 10, 2008 at 01:52:41PM +0100, Liam Girdwood wrote:

> I'd prefer some real hardware for pxa27x since it has some different
> AC97 silicon errata. However, since there are no pxa27x volunteers we
> should upstream and wait for any unlikely pxa27x issues in the 2.6.28-rc
> series.

I've got a PXA27x sitting here, I'll test then push to Takashi assuming
I don't run into any problems.
