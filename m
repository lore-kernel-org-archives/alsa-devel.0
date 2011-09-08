From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: auto-loading board-specific modules
Date: Thu, 8 Sep 2011 00:44:53 -0700
Message-ID: <20110908074452.GA3987@opensource.wolfsonmicro.com>
References: <CAG5Tg6VzdgPLG4L9how4-L8SJHVrEk+Twh9QcKnVF_-rVPka+w@mail.gmail.com>
	<20110907223535.GA9557@sirena.org.uk>
	<CAG5Tg6X50WVUx8zBGDFT7TMoY+4qrnKdbsT11eLUUvmfu02jLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 492EF247C5
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Sep 2011 09:44:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAG5Tg6X50WVUx8zBGDFT7TMoY+4qrnKdbsT11eLUUvmfu02jLg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mans Rullgard <mans.rullgard@linaro.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 08, 2011 at 12:37:56AM +0100, Mans Rullgard wrote:

> Is there some driver that does it right I could look at as a template for
> fixing at least some of the old ones?

Anything contributed in the past few kernel releases should be good -
Speyside if I had to pick one because I maintain it but anything being
actively worked on should do the right thing.
